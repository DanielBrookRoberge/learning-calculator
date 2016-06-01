package main

import "github.com/DanielBrookRoberge/rpn"
import "fmt"

func main() {
	testexpr := []string{"1", "2", "+", "5", "*", "2", "^"}
	fmt.Printf("Result is %f\n", rpn.Evaluate(testexpr))

	testexpr2 := []string{"(", "1", "+", "2", ")", "*", "5"}
	tokens := rpn.ConvertInfix(testexpr2)
	fmt.Printf("Tokens are %v\n", tokens)
	fmt.Printf("Result is %f\n", rpn.Evaluate(tokens))

	testexpr3 := "(1 + 2) * 6"
	infixTokens := rpn.Tokenize(testexpr3)
	fmt.Printf("Tokens are %v\n", infixTokens)
	rpnTokens := rpn.ConvertInfix(infixTokens)
	fmt.Printf("Tokens are %v\n", rpnTokens)
	fmt.Printf("Result is %f\n", rpn.Evaluate(rpnTokens))
}
