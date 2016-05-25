from collections import deque

BINARY_OPERATORS = {
    '+': lambda op1, op2: op2 + op1,
    '-': lambda op1, op2: op2 - op1,
    '*': lambda op1, op2: op2 * op1,
    '/': lambda op1, op2: op2 / op1,
    '^': lambda op1, op2: op2 ** op1
}

class RpnException(Exception):
    pass

def evaluate(tokens):
    stack = deque()
    for token in tokens:
        if token.isdigit():
            stack.append(int(token))
        elif token in BINARY_OPERATORS:
            if len(stack) < 2:
                raise RpnException('Stack underflow')
            stack.append(
                BINARY_OPERATORS[token](
                    stack.pop(),
                    stack.pop()
                )
            )
        else:
            raise RpnException('Unknown token')

    if len(stack) != 1:
        raise RpnException('Multiple stack elements remain')

    return stack[0]
