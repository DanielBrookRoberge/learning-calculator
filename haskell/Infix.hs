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
  | otherwise = resolveCloseBracket stack (op:output)

resolvePrecedence :: String -> Stack -> Tokens -> State
resolvePrecedence op [] output = ([op], output)
resolvePrecedence op (top:stack) output
  | opPrecedence < stackPrecedence = resolvePrecedence op stack (top:output)
  | opPrecedence == stackPrecedence = (op:stack, top:output)
  | otherwise = (op:top:stack, output)
  where opPrecedence = precedence op
        stackPrecedence = precedence top

convertTokens :: State -> String -> State
convertTokens (stack, output) token
  | isNumber token = (stack, token:output)
  | token == "(" = (token:stack, output)
  | token == ")" = resolveCloseBracket stack output
  | otherwise = resolvePrecedence token stack output

exhaustStack :: Stack -> Tokens -> Tokens
exhaustStack [] output = output
exhaustStack (top:stack) output = exhaustStack stack (top:output)

translateToRpn :: Tokens -> Tokens
translateToRpn tokens =
    let (stack, output) = foldl convertTokens ([], []) tokens
    in reverse $ exhaustStack stack output
