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

consumeRpnToken :: Stack -> String -> Stack
consumeRpnToken stack token
  | isNumber token = (read token):stack
  | token == "+" = performOperation (+) stack
  | token == "-" = performOperation (-) stack
  | token == "*" = performOperation (*) stack
  | token == "/" = performOperation (/) stack
  | otherwise = error "Unrecognized token"

extractResult :: Stack -> Float
extractResult [] = error "Stack underflow"
extractResult (x:[]) = x
extractResult _ = error "Multiple values left on stack"

evaluateRpn :: Tokens -> Float
evaluateRpn tokens = extractResult $ foldl consumeRpnToken [] tokens
