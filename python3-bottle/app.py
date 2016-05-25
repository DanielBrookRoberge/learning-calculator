from bottle import route, run

from tokenize import tokenize
from infix import evaluate

@route('/<expr>')
def calculate(expr):
    return str(evaluate(tokenize(expr)))

run(host='localhost', port=3000)
