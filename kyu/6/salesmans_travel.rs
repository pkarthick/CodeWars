fn travel(r: &str, zipcode: &str) -> String {
    if zipcode.len() == 0 {
        zipcode.to_owned() + ":/"
    } else {
        let addresses = r
            .split('\n')
            .into_iter()
            .filter_map(|l| {
                let v = l
                    .split(',')
                    .filter_map(|s| {
                        let s = s.trim();

                        if s.ends_with(zipcode) {
                            let ind = s.find(zipcode).unwrap();
                            if let Some(space_ind) = s.find(' ') {
                                Some((&s[space_ind + 1..ind - 1], &s[0..space_ind]))
                            } else {
                                None
                            }
                        } else {
                            None
                        }
                    })
                    .into_iter()
                    .collect::<Vec<(&str, &str)>>();

                if v.len() > 0 {
                    Some(v)
                } else {
                    None
                }
            })
            .flatten()
            .collect::<Vec<(&str, &str)>>();
        if addresses.len() == 0 {
            zipcode.to_owned() + ":/"
        } else {
            let (s, h) = addresses
                .into_iter()
                .fold(("".to_owned(), "".to_owned()), |x, y| {
                    (x.0 + "," + y.0, x.1 + "," + y.1)
                });

            zipcode.to_owned() + ":" + &s[1..] + "/" + &h[1..]
        }
    }
}

fn main() {
    assert_eq! (travel("123 Main Street St. Louisville OH 43071, 432 Main Long Road St. Louisville OH 43071,786 High Street Pollocksville NY 56432,
    54 Holy Grail Street Niagara Town ZP 32908, 3200 Main Rd. Bern AE 56210,1 Gordon St. Atlanta RE 13000,
    10 Pussy Cat Rd. Chicago EX 34342, 10 Gordon St. Atlanta RE 13000, 58 Gordon Road Atlanta RE 13000,
    22 Tokyo Av. Tedmondville SW 43098, 674 Paris bd. Abbeville AA 45521, 10 Surta Alley Goodtown GG 30654,
    45 Holy Grail Al. Niagara Town ZP 32908, 320 Main Al. Bern AE 56210, 14 Gordon Park Atlanta RE 13000,
    100 Pussy Cat Rd. Chicago EX 34342, 2 Gordon St. Atlanta RE 13000, 5 Gordon Road Atlanta RE 13000,
    2200 Tokyo Av. Tedmondville SW 43098, 67 Paris St. Abbeville AA 45521, 11 Surta Avenue Goodtown GG 30654,
    45 Holy Grail Al. Niagara Town ZP 32918, 320 Main Al. Bern AE 56215, 14 Gordon Park Atlanta RE 13200,
    100 Pussy Cat Rd. Chicago EX 34345, 2 Gordon St. Atlanta RE 13222, 5 Gordon Road Atlanta RE 13001,
    2200 Tokyo Av. Tedmondville SW 43198, 67 Paris St. Abbeville AA 45522, 11 Surta Avenue Goodville GG 30655,
    2222 Tokyo Av. Tedmondville SW 43198, 670 Paris St. Abbeville AA 45522, 114 Surta Avenue Goodville GG 30655,
    2 Holy Grail Street Niagara Town ZP 32908, 3 Main Rd. Bern AE 56210, 77 Gordon St. Atlanta RE 13000,
    100 Pussy Cat Rd. Chicago OH 13201", "AA 45522"), "AA 45522:Paris St. Abbeville,Paris St. Abbeville/67,670");
}

#[cfg(test)]
mod tests {

    use super::travel;

    fn ad() -> String {
        return String::from("123 Main Street St. Louisville OH 43071, 432 Main Long Road St. Louisville OH 43071,786 High Street Pollocksville NY 56432,
            54 Holy Grail Street Niagara Town ZP 32908, 3200 Main Rd. Bern AE 56210,1 Gordon St. Atlanta RE 13000,
            10 Pussy Cat Rd. Chicago EX 34342, 10 Gordon St. Atlanta RE 13000, 58 Gordon Road Atlanta RE 13000,
            22 Tokyo Av. Tedmondville SW 43098, 674 Paris bd. Abbeville AA 45521, 10 Surta Alley Goodtown GG 30654,
            45 Holy Grail Al. Niagara Town ZP 32908, 320 Main Al. Bern AE 56210, 14 Gordon Park Atlanta RE 13000,
            100 Pussy Cat Rd. Chicago EX 34342, 2 Gordon St. Atlanta RE 13000, 5 Gordon Road Atlanta RE 13000,
            2200 Tokyo Av. Tedmondville SW 43098, 67 Paris St. Abbeville AA 45521, 11 Surta Avenue Goodtown GG 30654,
            45 Holy Grail Al. Niagara Town ZP 32918, 320 Main Al. Bern AE 56215, 14 Gordon Park Atlanta RE 13200,
            100 Pussy Cat Rd. Chicago EX 34345, 2 Gordon St. Atlanta RE 13222, 5 Gordon Road Atlanta RE 13001,
            2200 Tokyo Av. Tedmondville SW 43198, 67 Paris St. Abbeville AA 45522, 11 Surta Avenue Goodville GG 30655,
            2222 Tokyo Av. Tedmondville SW 43198, 670 Paris St. Abbeville AA 45522, 114 Surta Avenue Goodville GG 30655,
            2 Holy Grail Street Niagara Town ZP 32908, 3 Main Rd. Bern AE 56210, 77 Gordon St. Atlanta RE 13000,
            100 Pussy Cat Rd. Chicago OH 13201");
    }

    fn dotest(r: &str, zipcode: &str, exp: &str) -> () {
        //println!("r:{:?}", r);
        println!(" zipcode:{:?}", zipcode);
        let ans = travel(r, zipcode);
        println!("actual: {:?}", ans);
        println!("expect: {:?}", exp);
        println!("{}", ans == exp);
        assert_eq!(ans, exp);
        println!("{}", "-");
    }

    #[test]
    fn basic_tests() {
        let r = &ad();
        dotest(
            r,
            "AA 45522",
            "AA 45522:Paris St. Abbeville,Paris St. Abbeville/67,670",
        );
        dotest(r, "OH 430", "OH 430:/");
    }
}
