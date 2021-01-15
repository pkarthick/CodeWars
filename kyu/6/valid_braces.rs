fn valid_braces(s: &str) -> bool {
    let mut stack = Vec::new();
    for ch in s.chars() {
        match ch {
            '}' => {
                if let Some('{') = stack.pop() {
                    continue;
                } else {
                    return false;
                }
            }
            ']' => {
                if let Some('[') = stack.pop() {
                    continue;
                } else {
                    return false;
                }
            }
            ')' => {
                if let Some('(') = stack.pop() {
                    continue;
                } else {
                    return false;
                }
            }
            _ => stack.push(ch),
        }
    }

    stack.is_empty()
}

fn main() {
    assert!(valid_braces("()"));
    assert!(false == valid_braces("[(])"));
    println!("Success!");
}
