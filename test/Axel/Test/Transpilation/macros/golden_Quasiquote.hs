module Quasiquote where
import Axel
import qualified Prelude as GHCPrelude
import qualified Axel.Parse.AST as AST
import Axel.Prelude
import qualified Axel.Parse.AST as AST
import qualified Axel.Sourcemap as SM
assertEq :: () => ((->) (AST.Expression a) ((->) (AST.Expression b) SM.Expression))
assertEq expr expected = (aXEL_SYMBOL_IF_ ((==) ((<$) () expr) ((<$) () expected)) (AST.SExpression (GHCPrelude.Just ((,) "axelTemp/2948473737463148627/result.axel" (SM.Position 2 86))) [(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/2948473737463148627/result.axel" (SM.Position 2 86))) "raw"),(AST.LiteralString (GHCPrelude.Just ((,) "axelTemp/2948473737463148627/result.axel" (SM.Position 2 86))) "-- Passed!")]) (error ((<>) (AST.toAxel expr) ((<>) " given, but " ((<>) (AST.toAxel expected) " expected!")))))
sym :: () => ((->) String SM.Expression)
sym x = (AST.Symbol Nothing x)
sexp :: () => ((->) ([] SM.Expression) SM.Expression)
sexp xs = (AST.SExpression Nothing xs)
-- Passed!
-- Passed!
-- Passed!
-- Passed!
testQuasiquote_AXEL_AUTOGENERATED_MACRO_DEFINITION _ = (pure [(assertEq (AST.Symbol (GHCPrelude.Just ((,) "axelTemp/4388616380899794166/result.axel" (SM.Position 1 73))) "topLevelBasic") (sym "topLevelBasic")),(assertEq (AST.SExpression (GHCPrelude.Just ((,) "golden_Quasiquote" (SM.Position 27 30))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/4388616380899794166/result.axel" (SM.Position 1 210))) "quote")],[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/4388616380899794166/result.axel" (SM.Position 1 219))) "topLevelQuote")]])) (sexp [(sym "quote"),(sym "topLevelQuote")])),(assertEq (AST.SExpression (GHCPrelude.Just ((,) "golden_Quasiquote" (SM.Position 29 16))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/4388616380899794166/result.axel" (SM.Position 1 383))) "\\")],[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/4388616380899794166/result.axel" (SM.Position 1 388))) "inFormBasic")],[(sym "inFormUnquote")],(AST.toExpressionList [(sym "inFormSpliceUnquote1"),(sym "inFormSpliceUnquote2")]),[(AST.SExpression (GHCPrelude.Just ((,) "golden_Quasiquote" (SM.Position 29 128))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/4388616380899794166/result.axel" (SM.Position 1 600))) "quote")],[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/4388616380899794166/result.axel" (SM.Position 1 609))) "inFormQuote")]]))]])) (sexp [(sym "\\"),(sym "inFormBasic"),(sym "inFormUnquote"),(sym "inFormSpliceUnquote1"),(sym "inFormSpliceUnquote2"),(sexp [(sym "quote"),(sym "inFormQuote")])])),(assertEq (AST.SExpression (GHCPrelude.Just ((,) "golden_Quasiquote" (SM.Position 31 16))) (concat [[(AST.SExpression (GHCPrelude.Just ((,) "golden_Quasiquote" (SM.Position 31 17))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/4388616380899794166/result.axel" (SM.Position 1 982))) "inForm2Basic")],[(sym "inForm2Unquote")],(AST.toExpressionList [(sym "inForm2SpliceUnquote1"),(sym "inForm2SpliceUnquote2")]),[(AST.SExpression (GHCPrelude.Just ((,) "golden_Quasiquote" (SM.Position 31 132))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/4388616380899794166/result.axel" (SM.Position 1 1198))) "quote")],[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/4388616380899794166/result.axel" (SM.Position 1 1207))) "inForm2Quote")]]))]]))]])) (sexp [(sexp [(sym "inForm2Basic"),(sym "inForm2Unquote"),(sym "inForm2SpliceUnquote1"),(sym "inForm2SpliceUnquote2"),(sexp [(sym "quote"),(sym "inForm2Quote")])])]))])
testQuasiquote_AXEL_AUTOGENERATED_MACRO_DEFINITION :: [AST.Expression SM.SourceMetadata] -> GHCPrelude.IO [AST.Expression SM.SourceMetadata]
