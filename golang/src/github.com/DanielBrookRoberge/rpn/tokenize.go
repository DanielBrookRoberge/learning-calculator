package rpn

import "unicode"

func Tokenize(expression string) []string {
	inprogress := ""
	result := make([]string, 0)

	for _, c := range expression {
		if unicode.IsSpace(c) {
			continue
		} else if unicode.IsDigit(c) {
			inprogress += string(c)
		} else if unicode.IsLetter(c) {
			panic("Invalid character")
		} else {
			if len(inprogress) > 0 {
				result = append(result, inprogress)
				inprogress = ""
			}
			result = append(result, string(c))
		}
	}
	if len(inprogress) > 0 {
		result = append(result, inprogress)
	}
	return result
}
