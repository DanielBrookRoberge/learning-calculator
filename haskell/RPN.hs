module RPN
( evaluateRpn )
where

import Data.Char (isDigit)

type Stack = [Float]
type Tokens = [String]
type Binary = (Float -> Float -> Float)

isNumber :: String -> Bool
isNumber = all isDigit

operators :: String
operators = "+-*/"

opFor :: String -> Binary
opFor "+" = (+)
opFor "-" = (-)
opFor "*" = (*)
opFor "/" = (/)
opFor _ = error "Unrecognized token"

performOperation :: Stack -> Binary -> Stack
performOperation [] _ = error "Stack underflow"
performOperation (_:[]) _ = error "Stack underflow"
performOperation (x:y:stack) op = (y `op` x):stack

consumeRpnToken :: Stack -> String -> Stack
consumeRpnToken stack token
  | isNumber token = (read token):stack
  | otherwise = performOperation stack $ opFor token

extractResult :: Stack -> Float
extractResult [] = error "Stack underflow"
extractResult (x:[]) = x
extractResult _ = error "Multiple values left on stack"

evaluateRpn :: Tokens -> Float
evaluateRpn tokens = extractResult $ foldl consumeRpnToken [] tokens
