import Infix
import RPN
import Tokenize

evaluate :: String -> Float
evaluate = evaluateRpn . translateToRpn . tokenizeExpr