package rpn

import "math"
import "strconv"

type binopt func(float64, float64) float64

var binaryOperators = map[string]binopt{
	"+": func(op1, op2 float64) float64 { return op2 + op1 },
	"-": func(op1, op2 float64) float64 { return op2 - op1 },
	"*": func(op1, op2 float64) float64 { return op2 * op1 },
	"/": func(op1, op2 float64) float64 { return op2 / op1 },
	"^": func(op1, op2 float64) float64 { return math.Pow(op2, op1) },
}

func Evaluate(tokens []string) float64 {
	stack := make([]float64, 0);

	for _, token := range tokens {
		if num, err := strconv.ParseFloat(token, 64); err == nil {
			stack = append(stack, num)
		} else if operation, ok := binaryOperators[token]; ok {
			// This will panic if there is a stack underflow
			op1 := stack[len(stack)-1]
			op2 := stack[len(stack)-2]
			stack = stack[:len(stack)-2]
			stack = append(stack, operation(op1, op2))
		} else {
			panic("Unknown token")
		}
	}
	if len(stack) != 1 {
		panic("Multiple values left on stack")
	}
	return stack[0]
}
