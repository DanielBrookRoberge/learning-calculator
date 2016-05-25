'use strict'

const whitespaceChars = ' \t\n';
const operatorChars = '(+-*/^)';
const numericChars = '0123456789';

let tokenizeExpression = function(expression) {
    let tokens = [];
    let inprogress = '';

    for (let c of expression) {
        if (whitespaceChars.includes(c)) {
            continue;
        }
        if (operatorChars.includes(c)) {
            if (inprogress !== '') {
                tokens.push(parseInt(inprogress, 10));
                inprogress = '';
            }
            tokens.push(c);
        } else if (numericChars.includes(c)) {
            inprogress = inprogress + c;
        } else {
            throw new Error('Does not support non arithmetic operations');
        }
    }

    if (inprogress !== '') {
        tokens.push(parseInt(inprogress, 10));
    }
    return tokens;
};


module.exports = {
    tokenizeExpression
};
