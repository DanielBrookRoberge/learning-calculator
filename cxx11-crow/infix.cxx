#include <cctype>
#include <list>
#include <stack>
#include <string>
#include <iostream>

#include "rpn.hxx"

using namespace std;

namespace infixcalc {
  int precedence(char op) {
    switch (op) {
    case '+':
    case '-':
      return 1;
    case '*':
    case '/':
      return 2;
    default: // including '(', which is the most important one
      return 0;
    }
  }

  list<string> convertInfix(list<string> tokens) {
    stack<string> operators;
    list<string> result;

    for (auto token: tokens) {
      if (token.size() != 1 || isdigit(token[0])) {
        // we assume it's a number
        result.push_back(token);
      } else {
        switch (token[0]) {
        default:
          throw;
        case '(':
          operators.push(token);
          break;
        case ')':
          while (operators.top() != "(") {
            if (operators.size() == 0) {
              throw;
            }
            result.push_back(operators.top());
            operators.pop();
          }
          operators.pop();
          break;
        case '+':
        case '-':
        case '*':
        case '/':
          int tokenPrecedence = precedence(token[0]);
          int stackPrecedence;
          do {
            if (operators.size() == 0) {
              operators.push(token);
              break;
            }
            stackPrecedence = precedence(operators.top()[0]);

            if (tokenPrecedence <= stackPrecedence) {
              result.push_back(operators.top());
              operators.pop();
            }

            if (tokenPrecedence >= stackPrecedence) {
              operators.push(token);
            }
          } while (tokenPrecedence < stackPrecedence);
          break;
        }
      }
    }

    while (operators.size() > 0) {
      result.push_back(operators.top());
      operators.pop();
    }

    return result;
  }

  double evaluateInfix(list<string> tokens) {
    return rpncalc::evaluateRpn(convertInfix(tokens));
  }
};

int main() {
  list<string> testexpr {"4", "*", "(", "2", "+", "3", ")"};

  cout << infixcalc::evaluateInfix(testexpr) << endl;
  auto result = infixcalc::convertInfix(testexpr);
  for (auto token : result) {
    cout << token << ' ';
  }
  cout << endl;
}
