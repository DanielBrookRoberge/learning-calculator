fn convert_infix(tokens: &[&str]) -> [&str] {
    let mut stack : Vec(&str) = vec![];
    let mut output : Vec(&str) = vec![];

    for token in tokens {
        match token.parse::<f64>() {
            Ok(_) => output.push(x),
            Err(_) => {
                if token == "("
            }
    }
}
