from collections import deque

import rpn

PRECEDENCE = {
    '^': 3,
    '*': 2,
    '/': 2,
    '-': 1,
    '+': 1,
    '(': 0
}

class InfixException(Exception):
    pass

def convert(tokens):
    stack = deque()

    for token in tokens:
        if token.isdigit():
            yield token
        elif token == '(':
            stack.append(token)
        elif token == ')':
            while True:
                if len(stack) == 0:
                    raise InfixException('Stack underflow')
                operator = stack.pop()
                if operator == '(':
                    break
                yield operator
        else:
            token_precedence = PRECEDENCE.get(token)
            while True:
                if len(stack) > 0:
                    stack_precedence = PRECEDENCE.get(stack[-1])
                else:
                    stack_precedence = 0
                if token_precedence > stack_precedence:
                    stack.append(token)
                    break
                elif token_precedence < stack_precedence:
                    yield stack.pop()
                else:
                    yield stack.pop()
                    stack.append(token)
                    break

    while len(stack) > 0:
        yield stack.pop()

def evaluate(tokens):
    return rpn.evaluate(convert(tokens))
