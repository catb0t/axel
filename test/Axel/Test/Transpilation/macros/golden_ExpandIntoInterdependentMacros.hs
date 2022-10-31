module ExpandIntoInterdependentMacros where
import Axel
import qualified Prelude as GHCPrelude
import qualified Axel.Parse.AST as AST
import Axel.Prelude
shouldExist :: () => (IO ())
shouldExist  = (pure ())
generateMacroChain_AXEL_AUTOGENERATED_MACRO_DEFINITION [(AST.Symbol ann macro)] = (pure (let {macro1 = ((<>) macro "1");macro2 = ((<>) macro "2");macro3 = ((<>) macro "3")} in [(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 9 7))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 289))) "defmacro")],[(AST.Symbol ann macro1)],[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 10 8))) (concat [[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 10 9))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 543))) "list")]]))],[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 10 12))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 664))) "pure")],[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 10 18))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 781))) "list")],[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 11 38))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 898))) "quote")],[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 10 20))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 1016))) "def")],[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 1023))) "shouldExist")],[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 10 37))) (concat [[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 10 38))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 1256))) "list")]]))],[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 10 41))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 1377))) "IO")],[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 1383))) "Unit")]]))]]))],[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 11 21))) (concat [[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 11 22))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 1617))) "list")]]))],[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 11 25))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 1738))) "pure")],[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 1746))) "unit")]]))]]))]]))]]))]]))]]))]]))]])),(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 12 7))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 1892))) "defmacro")],[(AST.Symbol ann macro2)],[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 13 8))) (concat [[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 13 9))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 2146))) "list")]]))],[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 13 12))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 2267))) "pure")],[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 13 18))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 2384))) "list")],[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 13 20))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 2501))) "AST.SExpression")],[(AST.SExpression GHCPrelude.Nothing (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 2566))) "GHCPrelude.Just")],[(AST.SExpression GHCPrelude.Nothing (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 2631))) ",")],[(AST.LiteralString (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 2636))) "golden_ExpandIntoInterdependentMacros")],[(AST.SExpression GHCPrelude.Nothing (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 2725))) "SM.Position")],[(AST.LiteralInt (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 2740))) 13)],[(AST.LiteralInt (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 2746))) 20)]]))]]))]]))],[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 13 20))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 2873))) "concat")],[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 13 20))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 2992))) "list")],[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 13 47))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 3109))) "list")],[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 13 47))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 3226))) "quote")],[(AST.Symbol ann macro1)]]))]]))]]))]]))]]))]]))]]))]]))]])),(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 14 7))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 3403))) "defmacro")],[(AST.Symbol ann macro3)],[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 15 8))) (concat [[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 15 9))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 3657))) "list")]]))],[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 15 12))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 3778))) "pure")],[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 15 18))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 3895))) "list")],[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 15 20))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 4012))) "AST.SExpression")],[(AST.SExpression GHCPrelude.Nothing (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 4077))) "GHCPrelude.Just")],[(AST.SExpression GHCPrelude.Nothing (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 4142))) ",")],[(AST.LiteralString (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 4147))) "golden_ExpandIntoInterdependentMacros")],[(AST.SExpression GHCPrelude.Nothing (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 4236))) "SM.Position")],[(AST.LiteralInt (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 4251))) 15)],[(AST.LiteralInt (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 4257))) 20)]]))]]))]]))],[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 15 20))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 4384))) "concat")],[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 15 20))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 4503))) "list")],[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 15 47))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 4620))) "list")],[(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 15 47))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1508974868586227362/result.axel" (SM.Position 1 4737))) "quote")],[(AST.Symbol ann macro2)]]))]]))]]))]]))]]))]]))]]))]]))]]))]))
macros1_AXEL_AUTOGENERATED_MACRO_DEFINITION [] = (pure [(AST.SExpression (GHCPrelude.Just ((,) "axelTemp/8322265170428161891/result.axel" (SM.Position 1 1))) [(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/8322265170428161891/result.axel" (SM.Position 1 2))) "::"),(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/8322265170428161891/result.axel" (SM.Position 1 5))) "shouldExist"),(AST.SExpression (GHCPrelude.Just ((,) "axelTemp/8322265170428161891/result.axel" (SM.Position 1 17))) [(AST.Symbol GHCPrelude.Nothing "list")]),(AST.SExpression (GHCPrelude.Just ((,) "axelTemp/8322265170428161891/result.axel" (SM.Position 1 20))) [(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/8322265170428161891/result.axel" (SM.Position 1 21))) "IO"),(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/8322265170428161891/result.axel" (SM.Position 1 24))) "Unit")])]),(AST.SExpression (GHCPrelude.Just ((,) "axelTemp/8322265170428161891/result.axel" (SM.Position 2 1))) [(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/8322265170428161891/result.axel" (SM.Position 2 2))) "="),(AST.SExpression (GHCPrelude.Just ((,) "axelTemp/8322265170428161891/result.axel" (SM.Position 2 4))) [(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/8322265170428161891/result.axel" (SM.Position 2 5))) "shouldExist")]),(AST.SExpression (GHCPrelude.Just ((,) "axelTemp/8322265170428161891/result.axel" (SM.Position 2 18))) [(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/8322265170428161891/result.axel" (SM.Position 2 19))) "pure"),(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/8322265170428161891/result.axel" (SM.Position 2 24))) "unit")])])])
macros2_AXEL_AUTOGENERATED_MACRO_DEFINITION [] = (pure [(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 13 20))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/6774190842878730163/result.axel" (SM.Position 1 166))) "macros1")]]))])
macros3_AXEL_AUTOGENERATED_MACRO_DEFINITION [] = (pure [(AST.SExpression (GHCPrelude.Just ((,) "golden_ExpandIntoInterdependentMacros" (SM.Position 15 20))) (concat [[(AST.Symbol (GHCPrelude.Just ((,) "axelTemp/1643648512022641200/result.axel" (SM.Position 1 166))) "macros2")]]))])
generateMacroChain_AXEL_AUTOGENERATED_MACRO_DEFINITION :: [AST.Expression SM.SourceMetadata] -> GHCPrelude.IO [AST.Expression SM.SourceMetadata]
macros1_AXEL_AUTOGENERATED_MACRO_DEFINITION :: [AST.Expression SM.SourceMetadata] -> GHCPrelude.IO [AST.Expression SM.SourceMetadata]
macros2_AXEL_AUTOGENERATED_MACRO_DEFINITION :: [AST.Expression SM.SourceMetadata] -> GHCPrelude.IO [AST.Expression SM.SourceMetadata]
macros3_AXEL_AUTOGENERATED_MACRO_DEFINITION :: [AST.Expression SM.SourceMetadata] -> GHCPrelude.IO [AST.Expression SM.SourceMetadata]