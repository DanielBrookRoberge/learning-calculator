fn evaluate_rpn(tokens: &[&str]) -> f64 {
    let mut stack : Vec<f64> = vec![];

    for token in tokens {
        match token.parse::<f64>() {
            Ok(x) => stack.push(x),
            Err(_) => {
                let op1 = stack.pop().unwrap();
                let op2 = stack.pop().unwrap();
                stack.push(match token.chars().nth(0).unwrap() {
                    '+' => op2 + op1,
                    '-' => op2 - op1,
                    '*' => op2 * op1,
                    '/' => op2 / op1,
                    _ => panic!("Unrecognized operator")
                });
            }
        };
    }

    stack[0]
}

fn main() {
    println!("{}", evaluate_rpn(&["1", "2", "-"]));
}
