'use strict';

const _ = require('underscore');
const rpn = require('./rpn');

const precedence = {
    '^': 3,
    '*': 2,
    '/': 2,
    '-': 1,
    '+': 1,
    '(': 0
};

let convertInfix = function(tokens) {
    let stack = [];
    let output = [];

    tokens.forEach(function(token) {
        if (_.isNumber(token)) {
            output.push(token);
        } else if (token === '(') {
            stack.push(token);
        } else if (token === ')') {
            while (true) {
                if (stack.length <= 0) {
                    throw 'Stack underflow';
                }
                let operator = stack.pop();
                if (operator === '(') {
                    break;
                }
                output.push(operator);
            }
        } else {
            let tokenPrecedence = precedence[token];
            while (true) {
                let stackPrecedence = precedence[stack[stack.length-1]] || 0;
                if (tokenPrecedence > stackPrecedence) {
                    stack.push(token);
                    break;
                } else if (tokenPrecedence < stackPrecedence) {
                    output.push(stack.pop());
                } else {
                    output.push(stack.pop());
                    stack.push(token);
                    break;
                }
            }
        }
    });

    while (stack.length > 0) {
        output.push(stack.pop());
    }

    return output;
};

let evaluateInfix = _.compose(rpn.evaluateRpn, convertInfix);

module.exports = {
    convertInfix,
    evaluateInfix
};
