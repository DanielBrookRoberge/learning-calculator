#include "rpn.hxx"

#include <stack>
#include <map>
#include <iostream>

using namespace std;

namespace rpncalc {
  double plus(double op1, double op2) { return op2 + op1; };
  double minus(double op1, double op2) { return op2 - op1; };
  double times(double op1, double op2) { return op2 * op1; };
  double div(double op1, double op2) { return op2 / op1; };

  map<string, decltype(plus)&> binary_operators = {
    {"+", plus},
    {"-", minus},
    {"*", times},
    {"/", div}
  };

  double pop(stack<double> &subject) {
    double value = subject.top();
    subject.pop();
    return value;
  }

  double evaluateRpn(list<string> tokens) {
    stack<double> calcStack;

    for (auto &token: tokens) {
      auto op = binary_operators.find(token);
      if (op != binary_operators.end()) {
        if (calcStack.size() < 2) {
          throw;
        }
        calcStack.push(op->second(pop(calcStack), pop(calcStack)));
      } else {
        // We assume it's a number for now
        calcStack.push(stod(token));
      }
    }

    if (calcStack.size() != 1) {
      throw;
    }

    return pop(calcStack);
  }
};
