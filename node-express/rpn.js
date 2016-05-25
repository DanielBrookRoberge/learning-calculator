'use strict';

const _ = require('underscore');

let plus = (op1, op2) => op2 + op1;
let minus = (op1, op2) => op2 - op1;
let multiply = (op1, op2) => op2 * op1;
let divide = (op1, op2) => op2 / op1;
let pow = (op1, op2) => Math.pow(op2, op1);

const binaryOperators = {
    '+': plus,
    '-': minus,
    '*': multiply,
    '/': divide,
    '^': pow
};

let neg = function(operand) {
    return -operand;
};

const unaryOperators = {
    neg,
    sin: Math.sin,
    cos: Math.cos,
    tan: Math.tan,
    exp: Math.exp,
    abs: Math.abs,
    log: Math.log
};

let evaluateRpn = function(tokens) {
    let stack = [];

    tokens.forEach(function(token) {
        if (_.isNumber(token)) {
            stack.push(token);
        } else if (binaryOperators[token] !== undefined) {
            if (stack.length < 2) {
                throw new Error('Stack underflow');
            }
            stack.push(binaryOperators[token](stack.pop(), stack.pop()));
        } else if (unaryOperators[token] !== undefined) {
            if (stack.length < 1) {
                throw new Error('Stack underflow');
            }
            stack.push(unaryOperators[token](stack.pop()));
        } else {
            throw new Error('Unknown token');
        }
    });

    if (stack.length !== 1) {
        throw new Error('Still multiple values on the stack');
    }
    return stack[0];
};

module.exports = {
    evaluateRpn
};
