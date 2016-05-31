#include <cctype>
#include <list>
#include <string>
#include <iostream>

using namespace std;

namespace infixcalc {
  list<string> tokenize(string expression) {
    string inprogress = "";
    list<string> result;

    for (char c : expression) {
      if (isspace(c)) {
        continue;
      }
      if (isdigit(c)) {
        inprogress += c;
      } else if (isalpha(c)) {
        throw;
      } else {
        if (inprogress.length() > 0) {
          result.push_back(inprogress);
          inprogress = "";
        }
        string charstr(1, c);
        result.push_back(charstr);
      }
    }
      if (inprogress.length() > 0) {
        result.push_back(inprogress);
      }
      return result;
  }
};

// int main() {
//   auto result = infixcalc::tokenize("1 + (2 * 3)");
//   for (auto token: result) {
//     cout << '"' << token << '"' << ' ';
//   }
//   cout << endl;
// }
