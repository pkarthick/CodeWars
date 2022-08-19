#[derive(Debug, PartialEq, Clone)]
enum Operator {
    Add,
    Minus,
    Multiply,
    Divide,
}

impl Operator {
    fn eval(&self, operand1: f64, operand2: f64) -> f64 {
        match self {
            Operator::Add => operand1 + operand2,
            Operator::Minus => operand1 - operand2,
            Operator::Multiply => operand1 * operand2,
            Operator::Divide => operand1 / operand2,
        }
    }
}

#[derive(Debug, PartialEq, Clone)]
enum Token {
    Literal(f64),
    Op(Operator),
}

struct ExpressionEvaluator {
    tokens: Vec<Token>,
}

fn tokenize(expr: &str) -> Vec<Token> {
    let mut tokens = vec![];
    let mut tokens_stack: Vec<Vec<Token>> = vec![];
    let cs: Vec<char> = expr.chars().collect();
    let mut i = 0_usize;
    loop {
        if i == expr.len() {
            break;
        }

        if cs[i] != ' ' {
            match cs[i] {
                '0'..='9' => {
                    let val = get_value(&mut i, &cs);
                    tokens.push(Token::Literal(val));
                    continue;
                }
                '+' => tokens.push(Token::Op(Operator::Add)),
                '-' => tokens.push(Token::Op(Operator::Minus)),
                '*' => tokens.push(Token::Op(Operator::Multiply)),
                '/' => tokens.push(Token::Op(Operator::Divide)),
                '(' => {
                    tokens_stack.push(tokens);
                    tokens = vec![];
                }
                ')' => {
                    let mut evaluator = ExpressionEvaluator::from_tokens(tokens.clone());
                    let val = evaluator.evaluate();

                    if let Some(ts) = tokens_stack.pop() {
                        tokens = ts;
                        tokens.push(Token::Literal(val));
                    }
                }
                _ => panic!("Unidentified char: {}", cs[i]),
            }
        }

        i += 1;
    }
    tokens
}

fn get_value(i: &mut usize, cs: &Vec<char>) -> f64 {
    let mut result = 0.0;

    let mut decimal_part = 0.0_f64;
    let mut has_dot = false;

    loop {
        if *i == cs.len() {
            break;
        }

        match cs[*i] {
            '0'..='9' => {
                let digit = (cs[*i] as i32 - 48) as f64;
                result = result * 10.0 + digit;
                decimal_part *= 10.0;
            }
            '.' => {
                decimal_part = 1.0;
                has_dot = true;
            }
            _ => break,
        }

        *i += 1;
    }

    if has_dot {
        result / decimal_part
    } else {
        result
    }
}

impl ExpressionEvaluator {
    fn from_expression(expr: &str) -> Self {
        let tokens = tokenize(expr);
        ExpressionEvaluator { tokens }
    }

    fn from_tokens(tokens: Vec<Token>) -> Self {
        ExpressionEvaluator { tokens }
    }

    fn evaluate(&mut self) -> f64 {
        self.simplify_leading_unary_minus();
        self.simplify_multiply_divide_operators();
        self.simplify_add_minus_operators();
        self.evaluate_tokens()
    }

    fn simplify_add_minus_operators(&mut self) {
        let mut i = 0;
        loop {
            if i == self.tokens.len() {
                break;
            }

            match &self.tokens[i..] {
                [Token::Literal(v1), Token::Op(Operator::Add), Token::Op(Operator::Minus), Token::Literal(v2), ..] =>
                {
                    self.tokens[i] = Token::Literal(v1 - v2);
                    self.remove_items_at_index(i + 1, 3);
                    continue;
                }
                [Token::Literal(v1), Token::Op(Operator::Add), Token::Literal(v2), ..] => {
                    self.tokens[i] = Token::Literal(v1 + v2);
                    self.remove_items_at_index(i + 1, 2);
                    continue;
                }
                [Token::Literal(v1), Token::Op(Operator::Minus), Token::Op(Operator::Minus), Token::Literal(v2), ..] =>
                {
                    self.tokens[i] = Token::Literal(v1 - -v2);
                    self.remove_items_at_index(i + 1, 3);
                    continue;
                }
                [Token::Literal(v1), Token::Op(Operator::Minus), Token::Literal(v2), ..] => {
                    self.tokens[i] = Token::Literal(v1 - v2);
                    self.remove_items_at_index(i + 1, 2);
                    continue;
                }
                _ => i += 1,
            }
        }
    }

    fn simplify_multiply_divide_operators(&mut self) {
        let mut i = 0;
        loop {
            if i == self.tokens.len() {
                break;
            }

            match &self.tokens[i..] {
                [Token::Literal(v1), Token::Op(Operator::Multiply), Token::Op(Operator::Minus), Token::Literal(v2), ..] =>
                {
                    self.tokens[i] = Token::Literal(v1 * -v2);
                    self.remove_items_at_index(i + 1, 3);
                    continue;
                }
                [Token::Literal(v1), Token::Op(Operator::Divide), Token::Op(Operator::Minus), Token::Literal(v2), ..] =>
                {
                    self.tokens[i] = Token::Literal(v1 / -v2);
                    self.remove_items_at_index(i + 1, 3);
                    continue;
                }
                [Token::Literal(v1), Token::Op(Operator::Multiply), Token::Literal(v2), ..] => {
                    self.tokens[i] = Token::Literal(v1 * v2);
                    self.remove_items_at_index(i + 1, 2);
                    continue;
                }
                [Token::Literal(v1), Token::Op(Operator::Divide), Token::Literal(v2), ..] => {
                    self.tokens[i] = Token::Literal(v1 / v2);
                    self.remove_items_at_index(i + 1, 2);
                    continue;
                }
                _ => {}
            }

            i += 1;
        }
    }

    fn remove_items_at_index(&mut self, index: usize, count: usize) {
        for _ in 0..count {
            self.tokens.remove(index);
        }
    }

    fn simplify_leading_unary_minus(&mut self) {
        match &self.tokens[0..] {
            [Token::Op(Operator::Minus), Token::Literal(v), ..] => {
                self.tokens[1] = Token::Literal(-v);
                self.tokens.remove(0);
            }
            _ => {}
        }
    }

    fn evaluate_tokens(&self) -> f64 {
        match &self.tokens[..] {
            [Token::Literal(val)] => *val,
            [Token::Op(Operator::Minus), Token::Literal(val)] => -*val,
            [Token::Literal(operand1), Token::Op(operator), Token::Literal(operand2)] => {
                operator.eval(*operand1, *operand2)
            }
            _ => panic!("Tokens sequence not handled: {:?}", &self.tokens[..]),
        }
    }
}

pub fn calc(expr: &str) -> f64 {
    let mut evaluator = ExpressionEvaluator::from_expression(expr);
    evaluator.evaluate()
}

#[cfg(test)]
mod tests {
    use super::calc;

    // Wrap custom message to reduce repitition
    macro_rules! assert_expr_eq {
        ($expr: expr, $expect: expr) => {
            assert_eq!(
                calc($expr),
                $expect,
                "\nexpected expression \"{}\" to equal \"{:?}\", but got \"{:?}\"",
                $expr,
                $expect,
                calc($expr),
            );
        };
    }

    #[test]
    fn single_values() {
        assert_expr_eq!("0", 0.0);
        assert_expr_eq!("1", 1.0);
        assert_expr_eq!("42", 42.0);
        assert_expr_eq!("350", 350.0);
    }

    #[test]
    fn basic_operations() {
        assert_expr_eq!("1 + 1", 2.0);
        assert_expr_eq!("1 - 1", 0.0);
        assert_expr_eq!("1 * 1", 1.0);
        assert_expr_eq!("1 / 1", 1.0);
        assert_expr_eq!("12 * 123", 1476.0);
    }

    #[test]
    fn whitespace_between_operators_and_operands() {
        assert_expr_eq!("1-1", 0.0);
        assert_expr_eq!("1 -1", 0.0);
        assert_expr_eq!("1- 1", 0.0);
        assert_expr_eq!("1* 1", 1.0);
    }

    #[test]
    fn unary_minuses() {
        assert_expr_eq!("1- -1", 2.0);
        assert_expr_eq!("1--1", 2.0);
        assert_expr_eq!("1 - -1", 2.0);
        assert_expr_eq!("-42", -42.0);
    }

    #[test]
    fn parentheses() {
        assert_expr_eq!("(1)", 1.0);
        assert_expr_eq!("((1))", 1.0);
        assert_expr_eq!("((80 - (19)))", 61.0);
    }

    #[test]
    fn multiple_operators() {
        assert_expr_eq!("12* 123/(-5 + 2)", -492.0);
        assert_expr_eq!("1 - -(-(-(-4)))", -3.0);
        assert_expr_eq!("2 /2+3 * 4.75- -6", 21.25);
        assert_expr_eq!("2 / (2 + 3) * 4.33 - -6", 7.732);
        assert_expr_eq!("(1 - 2) + -(-(-(-4)))", 3.0);
        assert_expr_eq!("((2.33 / (2.9+3.5)*4) - -6)", 7.45625);
    }
}
