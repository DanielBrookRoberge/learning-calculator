import Infix
import RPN

evaluate :: [String] -> Float
evaluate = evaluateRpn . translateToRpn