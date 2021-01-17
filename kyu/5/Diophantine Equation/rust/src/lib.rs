fn solequa(n: u64) -> Vec<(u64, u64)> {
    let mut res = vec![];

    let limit = (n as f64).sqrt() as u64;

    if limit * limit == n {
        res.push((limit, 0));
    }

    for a in 1..limit {
        if n % a == 0 {
            let b = n / a;
            let twox = a + b;
            let foury = b - a;
            if twox % 2 == 0 && foury % 4 == 0 {
                res.push((twox / 2, foury / 4));
            }
        }
    }

    res
}

#[cfg(test)]
mod tests {
    use super::*;

    fn testing(n: u64, exp: Vec<(u64, u64)>) -> () {
        assert_eq!(solequa(n), exp)
    }

    #[test]
    fn basics_solequa() {
        testing(5, vec![(3, 1)]);
        testing(20, vec![(6, 2)]);
        testing(9001, vec![(4501, 2250)]);
        testing(9004, vec![(2252, 1125)]);
        testing(90002, vec![]);
        testing(
            90005,
            vec![(45003, 22501), (9003, 4499), (981, 467), (309, 37)],
        );
        testing(9000001, vec![(4500001, 2250000), (73801, 36870)]);
    }
}
