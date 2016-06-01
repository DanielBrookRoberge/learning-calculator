package rpn

import "github.com/alediaferia/stackgo"
import "strconv"

var precedence = map[string]int{
	"^": 3,
	"*": 2,
	"/": 2,
	"-": 1,
	"+": 1,
	"(": 0,
}

func ConvertInfix(tokens []string) []string {
	stack := stackgo.NewStack()
	result := make([]string, 0)

	for _, token := range tokens {
		if _, err := strconv.ParseFloat(token, 64); err == nil {
			result = append(result, token)
		} else if token == "(" {
			stack.Push(token)
		} else if token == ")" {
			// This will panic if the stack underflows
			for stack.Top() != "(" {
				result = append(result, stack.Pop().(string))
			}
			stack.Pop()
		} else {
			tokenPrecedence, ok := precedence[token]
			if !ok {
				panic("Invalid token")
			}
			for {
				if stack.Top() == nil {
					stack.Push(token)
					break
				}
				stackPrecedence := precedence[stack.Top().(string)]
				if tokenPrecedence <= stackPrecedence {
					result = append(result, stack.Pop().(string))
				}

				if tokenPrecedence >= stackPrecedence {
					stack.Push(token)
					break
				}
			}

		}
	}

	for stack.Top() != nil {
		result = append(result, stack.Pop().(string))
	}

	return result
}

func ConvertInfix2(tokens chan string) chan string {
	c := make(chan string, 5)

	go func() {
		stack := stackgo.NewStack()

		for token := range tokens {
			if _, err := strconv.ParseFloat(token, 64); err == nil {
				c <- token
			} else if token == "(" {
				stack.Push(token)
			} else if token == ")" {
				// This will panic if the stack underflows
				for stack.Top() != "(" {
					c <- stack.Pop().(string)
				}
				stack.Pop()
			} else {
				tokenPrecedence, ok := precedence[token]
				if !ok {
					panic("Invalid token")
				}
				for {
					if stack.Top() == nil {
						stack.Push(token)
						break
					}
					stackPrecedence := precedence[stack.Top().(string)]

					if tokenPrecedence <= stackPrecedence {
						c <- stack.Pop().(string)
					}

					if tokenPrecedence >= stackPrecedence {
						stack.Push(token)
						break
					}
				}

			}
		}

		for stack.Top() != nil {
			c <- stack.Pop().(string)
		}
		close(c)
	}()

	return c
}
