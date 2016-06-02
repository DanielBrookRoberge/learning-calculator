package main

import "github.com/DanielBrookRoberge/rpn"
import "fmt"
import "net/http"
import "log"
import "strings"

func expressionEvaluator(w http.ResponseWriter, r *http.Request) {
	expr := strings.TrimLeft(r.URL.Path, "/")
	fmt.Fprintf(w, "%f\n", rpn.Calculate(expr))
}

func main() {
	testexpr3 := "(1 + 2) * 6"
	fmt.Printf("Result is %f\n", rpn.Calculate(testexpr3))

	log.Fatal(http.ListenAndServe(":2020", http.HandlerFunc(expressionEvaluator)))
}
