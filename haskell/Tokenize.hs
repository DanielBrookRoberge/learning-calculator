module Tokenize
( tokenizeExpr )
where

import Data.Char (isDigit, isSeparator)

type Tokens = [String]

operators :: String
operators = "+-*/()"

pushIntIfNecessary :: (Tokens, String) -> Tokens
pushIntIfNecessary (tokens, "") = tokens
pushIntIfNecessary (tokens, int) = int:tokens

traverseExpr :: (Tokens, String) -> Char -> (Tokens, String)
traverseExpr (tokens, int) c
  | isSeparator c = (tokens, int)
  | isDigit c = (tokens, int ++ [c])
  | c `elem` operators = ([c]:(pushIntIfNecessary (tokens, int)), "")
  | otherwise = error "Unrecognized character"

parse :: String -> (Tokens, String)
parse expr = foldl traverseExpr ([], "") expr

tokenizeExpr :: String -> Tokens
tokenizeExpr = reverse . pushIntIfNecessary . parse
