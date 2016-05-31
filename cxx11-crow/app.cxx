#include "crow_all.h"
#include "infix.hxx"
#include "tokenize.hxx"

using namespace std;
using namespace infixcalc;

int main() {
  crow::SimpleApp app;

  CROW_ROUTE(app, "/<string>")([](string expr){

      return to_string(evaluateInfix(tokenize(expr)));
    });

    app.port(18080).multithreaded().run();
}
