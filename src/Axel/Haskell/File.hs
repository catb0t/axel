{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}

module Axel.Haskell.File where

import Prelude hiding (putStrLn)

import Axel.AST
  ( SMStatement
  , Statement(SModuleDeclaration, STopLevel)
  , ToHaskell(toHaskell)
  , TopLevel(TopLevel)
  )
import Axel.Eff.Console (putStrLn)
import qualified Axel.Eff.Console as Effs (Console)
import Axel.Eff.Error (Error)
import qualified Axel.Eff.FileSystem as Effs (FileSystem)
import qualified Axel.Eff.FileSystem as FS (readFile, removeFile, writeFile)
import qualified Axel.Eff.Ghci as Effs (Ghci)
import qualified Axel.Eff.Log as Effs (Log)
import Axel.Eff.Process (StreamSpecification(InheritStreams))
import qualified Axel.Eff.Process as Effs (Process)
import Axel.Eff.Resource (readResource)
import qualified Axel.Eff.Resource as Effs (Resource)
import qualified Axel.Eff.Resource as Res (astDefinition)
import qualified Axel.Eff.Restartable as Effs (Restartable)
import Axel.Haskell.Convert (convertFile)
import Axel.Haskell.FilePath (axelPathToHaskellPath, haskellPathToAxelPath)
import Axel.Haskell.Stack (interpretFile)
import Axel.Macros (ModuleInfo, handleFunctionApplication, processProgram)
import Axel.Normalize (normalizeStatement, withExprCtxt)
import Axel.Parse (parseSource)
import Axel.Parse.AST (Expression(Symbol))
import qualified Axel.Sourcemap as SM
  ( Expression
  , Output
  , raw
  , unwrapCompoundExpressions
  )
import Axel.Utils.Recursion (bottomUpFmap)

import Control.Lens.Operators ((<&>), (?~))
import Control.Lens.Tuple (_2)
import Control.Monad (forM, mapM, unless, void)
import Control.Monad.Freer (Eff, LastMember, Members)
import Control.Monad.Freer.Error (runError)
import qualified Control.Monad.Freer.Error as Effs (Error)
import Control.Monad.Freer.Reader (runReader)
import qualified Control.Monad.Freer.Reader as Effs (Reader)
import Control.Monad.Freer.State (gets, modify)
import qualified Control.Monad.Freer.State as Effs (State)

import Data.Data (Data)
import qualified Data.Map as M (adjust, fromList, lookup)
import Data.Maybe (catMaybes)
import Data.Monoid (Alt(Alt))
import Data.Semigroup ((<>))

import qualified Language.Haskell.Ghcid as Ghci (Ghci)

import System.FilePath (takeFileName)

convertList :: (Data ann) => Expression ann -> Expression ann
convertList =
  bottomUpFmap $ \case
    Symbol ann "List" -> Symbol ann "[]"
    x -> x

convertUnit :: (Data ann) => Expression ann -> Expression ann
convertUnit =
  bottomUpFmap $ \case
    Symbol ann "Unit" -> Symbol ann "()"
    Symbol ann "unit" -> Symbol ann "()"
    x -> x

readModuleInfo ::
     (Members '[ Effs.Error Error, Effs.FileSystem] effs)
  => [FilePath]
  -> Eff effs ModuleInfo
readModuleInfo axelFiles = do
  modules <-
    forM axelFiles $ \filePath -> do
      source <- FS.readFile filePath
      exprs <-
        SM.unwrapCompoundExpressions <$> parseSource (Just filePath) source
      Alt moduleDecl <-
        mconcat . map Alt <$>
        mapM
          (\expr ->
             runError
               @Error
               (runReader filePath $ withExprCtxt $ normalizeStatement expr) <&> \case
               Right (SModuleDeclaration _ moduleId) ->
                 Just (filePath, (moduleId, Nothing))
               _ -> Nothing)
          exprs
      pure moduleDecl
  pure $ M.fromList $ catMaybes modules

transpileSource ::
     forall effs fileExpanderEffs funAppExpanderEffs.
     ( fileExpanderEffs ~ '[ Effs.Console, Effs.Error Error, Effs.FileSystem, Effs.Ghci, Effs.Log, Effs.Process, Effs.Resource, Effs.State ModuleInfo]
     , funAppExpanderEffs ~ (Effs.Reader Ghci.Ghci ': Effs.Reader FilePath ': Effs.Restartable SM.Expression ': Effs.State [SMStatement] ': fileExpanderEffs)
     , Members '[ Effs.Error Error, Effs.Ghci, Effs.State ModuleInfo] effs
     , Members fileExpanderEffs effs
     )
  => FilePath
  -> String
  -> Eff effs SM.Output
transpileSource filePath source =
  toHaskell . STopLevel . TopLevel Nothing <$>
  (parseSource (Just filePath) source >>=
   processProgram
     @fileExpanderEffs
     @funAppExpanderEffs
     handleFunctionApplication
     (void . transpileFileInPlace)
     filePath)

convertFileInPlace ::
     ( LastMember IO effs
     , Members '[ Effs.Console, Effs.Error Error, Effs.FileSystem] effs
     )
  => FilePath
  -> Eff effs FilePath
convertFileInPlace path = do
  let newPath = haskellPathToAxelPath path
  void $ convertFile path newPath
  pure newPath

transpileFile ::
     (Members '[ Effs.Console, Effs.Error Error, Effs.FileSystem, Effs.Ghci, Effs.Log, Effs.Process, Effs.Resource, Effs.State ModuleInfo] effs)
  => FilePath
  -> FilePath
  -> Eff effs ()
transpileFile path newPath = do
  fileContents <- FS.readFile path
  newContents <- transpileSource path fileContents
  putStrLn $ path <> " => " <> newPath
  FS.writeFile newPath (SM.raw newContents)
  modify @ModuleInfo $ M.adjust (_2 ?~ newContents) path

transpileFileInPlace ::
     (Members '[ Effs.Console, Effs.Error Error, Effs.FileSystem, Effs.Ghci, Effs.Log, Effs.Process, Effs.Resource, Effs.State ModuleInfo] effs)
  => FilePath
  -> Eff effs FilePath
transpileFileInPlace path = do
  moduleInfo <- gets @ModuleInfo $ M.lookup path
  let alreadyCompiled =
        case moduleInfo of
          Just (_, Just _) -> True
          _ -> False
  let newPath = axelPathToHaskellPath path
  unless alreadyCompiled $ transpileFile path newPath
  pure newPath

evalFile ::
     (Members '[ Effs.Console, Effs.Error Error, Effs.FileSystem, Effs.Process, Effs.Resource] effs)
  => FilePath
  -> Eff effs ()
evalFile path = do
  putStrLn ("Building " <> takeFileName path <> "...")
  let astDefinitionPath = "AutogeneratedAxelAST.hs"
  readResource Res.astDefinition >>= FS.writeFile astDefinitionPath
  let newPath = axelPathToHaskellPath path
  putStrLn ("Running " <> takeFileName path <> "...")
  void $ interpretFile @'InheritStreams newPath
  FS.removeFile astDefinitionPath
