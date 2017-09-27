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

traverseExpr :: (Tokens, String) -> Char -> (Tokens, String)
traverseExpr (tokens, int) c
  | isSeparator c = (tokens, int)
  | isDigit c = (tokens, int ++ [c])
  | c `elem` operators = ((pushIntIfNecessary (tokens, int)) ++ [[c]], "")
  | otherwise = error "Unrecognized character"

parse :: String -> (Tokens, String)
parse expr = foldl traverseExpr ([], "") expr

tokenizeExpr :: String -> Tokens
tokenizeExpr = pushIntIfNecessary . parse