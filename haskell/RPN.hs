module RPN
( evaluateRpn )
where

import Data.Char (isDigit)

isNumber :: String -> Bool
isNumber = all isDigit

type Stack = [Float]
type Tokens = [String]

performOperation :: (Float -> Float -> Float) -> Stack -> Stack
performOperation _ [] = error "Stack underflow"
performOperation _ (_:[]) = error "Stack underflow"
performOperation op (x:y:stack) = (y `op` x):stack

consumeRpnToken :: Tokens -> Stack -> Stack
consumeRpnToken [] stack = stack
consumeRpnToken (token:tokens) stack
  | isNumber token = recurse $ (read token):stack
  | token == "+" = operate (+)
  | token == "-" = operate (-)
  | token == "*" = operate (*)
  | token == "/" = operate (/)
  | otherwise = error "Unrecognized token"
  where recurse = consumeRpnToken tokens
        operate op = recurse $ performOperation op stack

extractResult :: Stack -> Float
extractResult [] = error "Stack underflow"
extractResult (x:[]) = x
extractResult _ = error "Multiple values left on stack"

evaluateRpn :: Tokens -> Float
evaluateRpn tokens = extractResult $ consumeRpnToken tokens []
