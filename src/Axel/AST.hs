{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TupleSections #-}

module Axel.AST where

import Axel.Haskell.Language (isOperator)
import Axel.Haskell.Macros (hygenisizeMacroName)
import Axel.Utils.Display
  ( Bracket(CurlyBraces, DoubleQuotes, Parentheses, SingleQuotes,
        SquareBrackets)
  , Delimiter(Commas, Newlines, Pipes, Spaces)
  , delimit
  , renderBlock
  , renderPragma
  , surround
  )
import Axel.Utils.Recursion (Recursive(bottomUpFmap, bottomUpTraverse))

import Control.Arrow ((***))
import Control.Lens.Operators ((%~), (^.))
import Control.Lens.TH (makeFieldsNoPrefix, makePrisms)

import Data.Function ((&))
import Data.Semigroup ((<>))

class ToHaskell a where
  toHaskell :: a -> String

type Identifier = String

data CaseBlock = CaseBlock
  { _expr :: Expression
  , _matches :: [(Expression, Expression)]
  } deriving (Eq, Show)

data FunctionApplication = FunctionApplication
  { _function :: Expression
  , _arguments :: [Expression]
  } deriving (Eq, Show)

data IfBlock = IfBlock
  { _cond :: Expression
  , _ifTrue :: Expression
  , _ifFalse :: Expression
  } deriving (Eq, Show)

newtype TopLevel = TopLevel
  { _statements :: [Statement]
  } deriving (Eq, Show)

data TypeDefinition
  = ProperType Identifier
  | TypeConstructor FunctionApplication
  deriving (Eq, Show)

instance ToHaskell TypeDefinition where
  toHaskell :: TypeDefinition -> String
  toHaskell (ProperType x) = x
  toHaskell (TypeConstructor x) = toHaskell x

data DataDeclaration = DataDeclaration
  { _typeDefinition :: TypeDefinition
  , _constructors :: [FunctionApplication]
  } deriving (Eq, Show)

data NewtypeDeclaration = NewtypeDeclaration
  { _typeDefinition :: TypeDefinition
  , _constructor :: FunctionApplication
  } deriving (Eq, Show)

data FunctionDefinition = FunctionDefinition
  { _name :: Identifier
  , _arguments :: [Expression]
  , _body :: Expression
  , _whereBindings :: [FunctionDefinition]
  } deriving (Eq, Show)

data Import
  = ImportItem Identifier
  | ImportType Identifier
               [Identifier]
  deriving (Eq, Show)

instance ToHaskell Import where
  toHaskell :: Import -> String
  toHaskell (ImportItem x) =
    if isOperator x
      then surround Parentheses x
      else x
  toHaskell (ImportType typeName imports) =
    typeName <> surround Parentheses (delimit Commas imports)

data ImportSpecification
  = ImportAll
  | ImportOnly [Import]
  deriving (Eq, Show)

instance ToHaskell ImportSpecification where
  toHaskell :: ImportSpecification -> String
  toHaskell ImportAll = ""
  toHaskell (ImportOnly importList) =
    surround Parentheses $ delimit Commas $ map toHaskell importList

data Lambda = Lambda
  { _arguments :: [Expression]
  , _body :: Expression
  } deriving (Eq, Show)

data LetBlock = LetBlock
  { _bindings :: [(Expression, Expression)]
  , _body :: Expression
  } deriving (Eq, Show)

newtype MacroDefinition = MacroDefinition
  { _functionDefinition :: FunctionDefinition
  } deriving (Eq, Show)

data MacroImport = MacroImport
  { _moduleName :: Identifier
  , _imports :: [Identifier]
  } deriving (Eq, Show)

newtype Pragma = Pragma
  { _pragmaSpecification :: String
  } deriving (Eq, Show)

data QualifiedImport = QualifiedImport
  { _moduleName :: Identifier
  , _alias :: Identifier
  , _imports :: ImportSpecification
  } deriving (Eq, Show)

newtype RecordDefinition = RecordDefinition
  { _bindings :: [(Identifier, Expression)]
  } deriving (Eq, Show)

newtype RecordType = RecordType
  { _fields :: [(Identifier, Expression)]
  } deriving (Eq, Show)

data RestrictedImport = RestrictedImport
  { _moduleName :: Identifier
  , _imports :: ImportSpecification
  } deriving (Eq, Show)

data TypeclassDefinition = TypeclassDefinition
  { _name :: Expression
  , _constraints :: [Expression]
  , _signatures :: [TypeSignature]
  } deriving (Eq, Show)

data TypeclassInstance = TypeclassInstance
  { _instanceName :: Expression
  , _definitions :: [FunctionDefinition]
  } deriving (Eq, Show)

data TypeSignature = TypeSignature
  { _name :: Identifier
  , _typeDefinition :: Expression
  } deriving (Eq, Show)

data TypeSynonym = TypeSynonym
  { _alias :: Expression
  , _definition :: Expression
  } deriving (Eq, Show)

data Expression
  = ECaseBlock CaseBlock
  | EEmptySExpression
  | EFunctionApplication FunctionApplication
  | EIdentifier Identifier
  | EIfBlock IfBlock
  | ELambda Lambda
  | ELetBlock LetBlock
  | ELiteral Literal
  | ERawExpression String
  | ERecordDefinition RecordDefinition
  | ERecordType RecordType
  deriving (Eq, Show)

instance ToHaskell Expression where
  toHaskell :: Expression -> String
  toHaskell (ECaseBlock x) = toHaskell x
  toHaskell EEmptySExpression = "()"
  toHaskell (EFunctionApplication x) = toHaskell x
  toHaskell (EIdentifier x) =
    if isOperator x
      then surround Parentheses x
      else x
  toHaskell (EIfBlock x) = toHaskell x
  toHaskell (ELambda x) = toHaskell x
  toHaskell (ELetBlock x) = toHaskell x
  toHaskell (ELiteral x) = toHaskell x
  toHaskell (ERawExpression x) = x
  toHaskell (ERecordDefinition x) = toHaskell x
  toHaskell (ERecordType x) = toHaskell x

data Literal
  = LChar Char
  | LInt Int
  | LString String
  deriving (Eq, Show)

instance ToHaskell Literal where
  toHaskell :: Literal -> String
  toHaskell (LChar x) = surround SingleQuotes [x]
  toHaskell (LInt x) = show x
  toHaskell (LString x) = surround DoubleQuotes x

data Statement
  = SDataDeclaration DataDeclaration
  | SFunctionDefinition FunctionDefinition
  | SMacroDefinition MacroDefinition
  | SMacroImport MacroImport
  | SModuleDeclaration Identifier
  | SNewtypeDeclaration NewtypeDeclaration
  | SPragma Pragma
  | SQualifiedImport QualifiedImport
  | SRawStatement String
  | SRestrictedImport RestrictedImport
  | STopLevel TopLevel
  | STypeclassDefinition TypeclassDefinition
  | STypeclassInstance TypeclassInstance
  | STypeSignature TypeSignature
  | STypeSynonym TypeSynonym
  | SUnrestrictedImport Identifier
  deriving (Eq, Show)

instance ToHaskell Statement where
  toHaskell :: Statement -> String
  toHaskell (SDataDeclaration x) = toHaskell x
  toHaskell (SFunctionDefinition x) = toHaskell x
  toHaskell (SPragma x) = toHaskell x
  toHaskell (SMacroDefinition x) = toHaskell x
  toHaskell (SMacroImport x) = toHaskell x
  toHaskell (SModuleDeclaration x) = "module " <> x <> " where"
  toHaskell (SNewtypeDeclaration x) = toHaskell x
  toHaskell (SQualifiedImport x) = toHaskell x
  toHaskell (SRawStatement x) = x
  toHaskell (SRestrictedImport x) = toHaskell x
  toHaskell (STopLevel xs) = toHaskell xs
  toHaskell (STypeclassDefinition x) = toHaskell x
  toHaskell (STypeclassInstance x) = toHaskell x
  toHaskell (STypeSignature x) = toHaskell x
  toHaskell (STypeSynonym x) = toHaskell x
  toHaskell (SUnrestrictedImport x) = "import " <> x

makePrisms ''Statement

type Program = [Statement]

makeFieldsNoPrefix ''CaseBlock

makeFieldsNoPrefix ''DataDeclaration

makeFieldsNoPrefix ''FunctionApplication

makeFieldsNoPrefix ''FunctionDefinition

makeFieldsNoPrefix ''Lambda

makeFieldsNoPrefix ''LetBlock

makeFieldsNoPrefix ''IfBlock

makeFieldsNoPrefix ''MacroDefinition

makeFieldsNoPrefix ''MacroImport

makeFieldsNoPrefix ''NewtypeDeclaration

makeFieldsNoPrefix ''Pragma

makeFieldsNoPrefix ''QualifiedImport

makeFieldsNoPrefix ''RecordDefinition

makeFieldsNoPrefix ''RecordType

makeFieldsNoPrefix ''RestrictedImport

makeFieldsNoPrefix ''TopLevel

makeFieldsNoPrefix ''TypeclassDefinition

makeFieldsNoPrefix ''TypeclassInstance

makeFieldsNoPrefix ''TypeSignature

makeFieldsNoPrefix ''TypeSynonym

instance ToHaskell CaseBlock where
  toHaskell :: CaseBlock -> String
  toHaskell caseBlock =
    surround Parentheses $
    "case " <> toHaskell (caseBlock ^. expr) <> " of " <>
    renderBlock (map matchToHaskell (caseBlock ^. matches))
    where
      matchToHaskell (pat, result) = toHaskell pat <> " -> " <> toHaskell result

instance ToHaskell FunctionApplication where
  toHaskell :: FunctionApplication -> String
  toHaskell functionApplication =
    case functionApplication ^. function of
      EIdentifier "list" ->
        surround SquareBrackets $
        delimit Commas (map toHaskell $ functionApplication ^. arguments)
      _ ->
        surround Parentheses $
        toHaskell (functionApplication ^. function) <> " " <>
        delimit Spaces (map toHaskell $ functionApplication ^. arguments)

instance ToHaskell TypeSignature where
  toHaskell :: TypeSignature -> String
  toHaskell typeSignature =
    toHaskell (EIdentifier (typeSignature ^. name)) <> " :: " <>
    toHaskell (typeSignature ^. typeDefinition)

instance ToHaskell FunctionDefinition where
  toHaskell :: FunctionDefinition -> String
  toHaskell fnDef =
    toHaskell (EIdentifier (fnDef ^. name)) <> " " <>
    delimit Spaces (map toHaskell (fnDef ^. arguments)) <>
    " = " <>
    toHaskell (fnDef ^. body) <>
    " where " <>
    renderBlock (map toHaskell (fnDef ^. whereBindings))

instance ToHaskell DataDeclaration where
  toHaskell :: DataDeclaration -> String
  toHaskell dataDeclaration =
    "data " <> toHaskell (dataDeclaration ^. typeDefinition) <> " = " <>
    delimit
      Pipes
      (map (removeSurroundingParentheses . toHaskell) $
       dataDeclaration ^. constructors)
    where
      removeSurroundingParentheses = tail . init

instance ToHaskell IfBlock where
  toHaskell :: IfBlock -> String
  toHaskell ifBlock =
    "if " <> toHaskell (ifBlock ^. cond) <> " then " <>
    toHaskell (ifBlock ^. ifTrue) <>
    " else " <>
    toHaskell (ifBlock ^. ifFalse)

instance ToHaskell NewtypeDeclaration where
  toHaskell :: NewtypeDeclaration -> String
  toHaskell newtypeDeclaration =
    "newtype " <> toHaskell (newtypeDeclaration ^. typeDefinition) <> " = " <>
    removeSurroundingParentheses (toHaskell (newtypeDeclaration ^. constructor))
    where
      removeSurroundingParentheses = tail . init

instance ToHaskell Lambda where
  toHaskell :: Lambda -> String
  toHaskell lambda =
    surround Parentheses $
    "\\" <> delimit Spaces (map toHaskell (lambda ^. arguments)) <> " -> " <>
    toHaskell (lambda ^. body)

instance ToHaskell Pragma where
  toHaskell :: Pragma -> String
  toHaskell pragma = renderPragma (pragma ^. pragmaSpecification)

instance ToHaskell LetBlock where
  toHaskell :: LetBlock -> String
  toHaskell letBlock =
    surround Parentheses $
    "let " <> renderBlock (map bindingToHaskell (letBlock ^. bindings)) <>
    " in " <>
    toHaskell (letBlock ^. body)
    where
      bindingToHaskell (pattern', value) =
        toHaskell pattern' <> " = " <> toHaskell value

instance ToHaskell MacroDefinition where
  toHaskell :: MacroDefinition -> String
  toHaskell macroDefinition = toHaskell (macroDefinition ^. functionDefinition)

instance ToHaskell MacroImport where
  toHaskell :: MacroImport -> String
  toHaskell macroImport =
    toHaskell $
    RestrictedImport
      (macroImport ^. moduleName)
      (ImportOnly $
       map (ImportItem . hygenisizeMacroName) $ macroImport ^. imports)

instance ToHaskell QualifiedImport where
  toHaskell :: QualifiedImport -> String
  toHaskell qualifiedImport =
    "import qualified " <> qualifiedImport ^. moduleName <> " as " <>
    qualifiedImport ^.
    alias <>
    toHaskell (qualifiedImport ^. imports)

instance ToHaskell RecordDefinition where
  toHaskell :: RecordDefinition -> String
  toHaskell recordDefinition =
    surround CurlyBraces $
    delimit Commas $
    map
      (\(var, val) -> var <> " = " <> toHaskell val)
      (recordDefinition ^. bindings)

instance ToHaskell RecordType where
  toHaskell :: RecordType -> String
  toHaskell recordDefinition =
    surround CurlyBraces $
    delimit Commas $
    map
      (\(field, ty) -> field <> " :: " <> toHaskell ty)
      (recordDefinition ^. fields)

instance ToHaskell RestrictedImport where
  toHaskell :: RestrictedImport -> String
  toHaskell restrictedImport =
    "import " <> restrictedImport ^. moduleName <>
    toHaskell (restrictedImport ^. imports)

instance ToHaskell TopLevel where
  toHaskell :: TopLevel -> String
  toHaskell topLevel = delimit Newlines $ map toHaskell (topLevel ^. statements)

instance ToHaskell TypeclassDefinition where
  toHaskell :: TypeclassDefinition -> String
  toHaskell typeclassDefinition =
    "class " <>
    surround
      Parentheses
      (delimit Commas (map toHaskell (typeclassDefinition ^. constraints))) <>
    " => " <>
    toHaskell (typeclassDefinition ^. name) <>
    " where " <>
    renderBlock (map toHaskell $ typeclassDefinition ^. signatures)

instance ToHaskell TypeclassInstance where
  toHaskell :: TypeclassInstance -> String
  toHaskell typeclassInstance =
    "instance " <> toHaskell (typeclassInstance ^. instanceName) <> " where " <>
    renderBlock (map toHaskell $ typeclassInstance ^. definitions)

instance ToHaskell TypeSynonym where
  toHaskell :: TypeSynonym -> String
  toHaskell typeSynonym =
    "type " <> toHaskell (typeSynonym ^. alias) <> " = " <>
    toHaskell (typeSynonym ^. definition)

instance Recursive Expression where
  bottomUpFmap :: (Expression -> Expression) -> Expression -> Expression
  bottomUpFmap f x =
    f $
    case x of
      ECaseBlock caseBlock ->
        ECaseBlock $
        caseBlock & expr %~ bottomUpFmap f &
        matches %~ map (bottomUpFmap f *** bottomUpFmap f)
      EEmptySExpression -> x
      EFunctionApplication functionApplication ->
        EFunctionApplication $
        functionApplication & function %~ bottomUpFmap f &
        arguments %~ map (bottomUpFmap f)
      EIdentifier _ -> x
      EIfBlock ifBlock ->
        EIfBlock $
        ifBlock & cond %~ bottomUpFmap f & ifTrue %~ bottomUpFmap f &
        ifFalse %~ bottomUpFmap f
      ELambda lambda ->
        ELambda $
        lambda & arguments %~ map (bottomUpFmap f) & body %~ bottomUpFmap f
      ELetBlock letBlock ->
        ELetBlock $
        letBlock & bindings %~ map (bottomUpFmap f *** bottomUpFmap f) &
        body %~ bottomUpFmap f
      ELiteral literal ->
        case literal of
          LChar _ -> x
          LInt _ -> x
          LString _ -> x
      ERawExpression _ -> x
      ERecordDefinition _ -> x
      ERecordType _ -> x
  bottomUpTraverse ::
       (Monad m) => (Expression -> m Expression) -> Expression -> m Expression
  bottomUpTraverse f x =
    f =<<
    case x of
      ECaseBlock caseBlock ->
        ECaseBlock <$>
        (CaseBlock <$> bottomUpTraverse f (caseBlock ^. expr) <*>
         traverse
           (\(a, b) -> (,) <$> bottomUpTraverse f a <*> bottomUpTraverse f b)
           (caseBlock ^. matches))
      EEmptySExpression -> pure x
      EFunctionApplication functionApplication ->
        EFunctionApplication <$>
        (FunctionApplication <$>
         bottomUpTraverse f (functionApplication ^. function) <*>
         traverse (bottomUpTraverse f) (functionApplication ^. arguments))
      EIdentifier _ -> pure x
      EIfBlock ifBlock ->
        EIfBlock <$>
        (IfBlock <$> bottomUpTraverse f (ifBlock ^. cond) <*>
         bottomUpTraverse f (ifBlock ^. ifTrue) <*>
         bottomUpTraverse f (ifBlock ^. ifFalse))
      ELambda lambda ->
        ELambda <$>
        (Lambda <$> traverse (bottomUpTraverse f) (lambda ^. arguments) <*>
         bottomUpTraverse f (lambda ^. body))
      ELetBlock letBlock ->
        ELetBlock <$>
        (LetBlock <$>
         traverse
           (\(a, b) -> (a, ) <$> bottomUpTraverse f b)
           (letBlock ^. bindings) <*>
         bottomUpTraverse f (letBlock ^. body))
      ELiteral literal ->
        case literal of
          LChar _ -> pure x
          LInt _ -> pure x
          LString _ -> pure x
      ERawExpression _ -> pure x
      ERecordDefinition _ -> pure x
      ERecordType _ -> pure x
