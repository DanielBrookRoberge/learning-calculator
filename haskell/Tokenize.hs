module Tokenize
( tokenizeExpr )
where

import Data.Char (isDigit, isSeparator)

type Tokens = [String]

operators :: String
operators = "+-*/()"

pushIntIfNecessary :: (Tokens, String) -> Tokens
pushIntIfNecessary (tokens, "") = tokens
pushIntIfNecessary (tokens, int) = tokens ++ [int]

traverseExpr :: (String, Tokens, String) -> (String, Tokens, String)
traverseExpr ("", x, y) = ("", x, y)
traverseExpr ((c:expr), tokens, int)
  | isSeparator c = traverseExpr (expr, tokens, int)
  | isDigit c = traverseExpr (expr, tokens, int ++ [c])
  | c `elem` operators = traverseExpr (expr, (pushIntIfNecessary (tokens, int)) ++ [[c]], "")
  | otherwise = error "Unrecognized character"

discardFirst :: (a, b, c) -> (b, c)
discardFirst (_, x, y) = (x, y)

parse :: String -> (Tokens, String)
parse expr = discardFirst $ traverseExpr (expr, [], "")

tokenizeExpr :: String -> Tokens
tokenizeExpr = pushIntIfNecessary . parse