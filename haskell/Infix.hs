module Infix
( translateToRpn )
where

import Data.Char (isDigit)

isNumber :: String -> Bool
isNumber = all isDigit

type Tokens = [String]
type Stack = [String]
type State = (Stack, Tokens)

precedence :: String -> Int
precedence "*" = 2
precedence "/" = 2
precedence "-" = 1
precedence "+" = 1
precedence _ = 0

resolveCloseBracket :: Stack -> Tokens -> State
resolveCloseBracket [] _ = error "Stack underflow"
resolveCloseBracket (op:stack) output
  | op == "(" = (stack, output)
  | otherwise = resolveCloseBracket stack (output ++ [op])

resolvePrecedence :: String -> Stack -> Tokens -> State
resolvePrecedence op [] output = ([op], output)
resolvePrecedence op (top:stack) output
  | opPrecedence < stackPrecedence = resolvePrecedence op stack (output ++ [top])
  | opPrecedence == stackPrecedence = (op:stack, (output ++ [top]))
  | otherwise = (op:top:stack, output)
  where opPrecedence = precedence op
        stackPrecedence = precedence top

convertTokens :: Tokens -> (Stack, Tokens) -> State
convertTokens [] pair = pair
convertTokens (token:tokens) (stack, output)
  | isNumber token = recurse (stack, output ++ [token])
  | token == "(" = recurse (token:stack, output)
  | token == ")" = recurse $ resolveCloseBracket stack output
  | otherwise = recurse $ resolvePrecedence token stack output
  where recurse = convertTokens tokens

exhaustStack :: Stack -> Tokens -> Tokens
exhaustStack [] output = output
exhaustStack (top:stack) output = exhaustStack stack (output ++ [top])

translateToRpn :: Tokens -> Tokens
translateToRpn tokens =
    let (stack, output) = convertTokens tokens ([], [])
    in exhaustStack stack output