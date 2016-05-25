'use strict';

let express = require('express');
let infix = require('./infix');
let tokenizer = require('./tokenizer');
let _ = require('underscore');

let evaluateInput = _.compose(infix.evaluateInfix, tokenizer.tokenizeExpression);

let app = express();

app.get('/:expr', function(req, res) {
    try {
        res.send(
            String(
                evaluateInput(
                    req.params.expr.replace(/div/g, '/')
                )
            )
        );
    } catch (e) {
        res.sendStatus(400);
    }
});

app.listen(3000);
