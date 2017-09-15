module RPN
( evaluateRpn )
where

import Data.Char (isDigit)

isNumber :: String -> Bool
isNumber = all isDigit

performOperation :: (Float -> Float -> Float) -> [Float] -> [Float]
performOperation _ [] = error "Stack underflow"
performOperation _ (_:[]) = error "Stack underflow"
performOperation op (x:y:stack) = (y `op` x):stack

consumeRpnToken :: [String] -> [Float] -> [Float]
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

extractResult :: [Float] -> Float
extractResult [] = error "Stack underflow"
extractResult (x:[]) = x
extractResult _ = error "Multiple values left on stack"

evaluateRpn :: [String] -> Float
evaluateRpn tokens = extractResult $ consumeRpnToken tokens []
