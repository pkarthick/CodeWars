// fn create_phone_number2(numbers: &[u8]) -> String {
//     let mut s = "(000) 000-0000".to_string();
//     let ns = &String::from_utf8(numbers.iter().map(|d| *d + 48).to_slice().collect::<Vec<u8>>()).unwrap();
//     s.replace_range(1..4, &ns[0..3]);
//     s.replace_range(6..9, &ns[3..6]);
//     s.replace_range(10..=13, &ns[6..=9]);
//     s
// }

fn create_phone_number(numbers: &[u8]) -> String {
    let ns = numbers.iter().map(|d| *d + 48).collect::<Vec<u8>>();
    let x = [ &[b'('], &ns[0..3], &[b')', b' '], &ns[3..6], &[b'-'], &ns[6..=9]].concat();
    String::from_utf8(x).unwrap()
}

fn main() {
    assert_eq!(
        create_phone_number(&[1, 2, 3, 4, 5, 6, 7, 8, 9, 0]),
        "(123) 456-7890"
    );
    assert_eq!(
        create_phone_number(&[1, 1, 1, 1, 1, 1, 1, 1, 1, 1]),
        "(111) 111-1111"
    );
    assert_eq!(
        create_phone_number(&[1, 2, 3, 4, 5, 6, 7, 8, 9, 9]),
        "(123) 456-7899"
    );
    println!("Success!");
}
