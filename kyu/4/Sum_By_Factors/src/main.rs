fn sum_of_divided(l: Vec<i64>) -> Vec<(i64, i64)> {
    if l.is_empty() {
        vec![]
    } else {
        let mut divided_sums: Vec<(i64, i64)> = Vec::new();

        let max = l.iter().map(|x| x.abs()).max().unwrap();

        let get_pair = |f: i64| {
            let by2s: Vec<i64> = l.iter().filter(|n| **n == f || **n % f == 0).map(|n| *n).collect();

            if !by2s.is_empty() {
                let sum = by2s.iter().sum();
                Some((f, sum))
            } else {
                None
            }
        };

        if let Some(pair) = get_pair(2) {
            divided_sums.push(pair);
        }

        let mut factor = 1_i64;

        while factor <= max {
            factor += 2;

            if divided_sums.iter().any(|(f, _)| factor % *f == 0) {
                continue;
            }

            if let Some(pair) = get_pair(factor) {
                divided_sums.push(pair);
            }

        }

        divided_sums
    }
}

fn testing(l: Vec<i64>, exp: Vec<(i64, i64)>) -> () {
    assert_eq!(sum_of_divided(l), exp)
}

#[test]
fn basics_sum_of_divided() {
    testing(vec![12, 15], vec![(2, 12), (3, 27), (5, 15)]);
    testing(
        vec![15, 21, 24, 30, 45],
        vec![(2, 54), (3, 135), (5, 90), (7, 21)],
    );
    testing(
        vec![15, 21, 24, 30, 45, 107],
        vec![(2, 54), (3, 135), (5, 90), (7, 21), (107, 107)],
    );
}

fn main() {
    println!("Hello, world!");
}
