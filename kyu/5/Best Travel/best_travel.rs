fn find(k: i32, t: i32, sls: &Vec<i32>, d: i32, xt: i32, s: usize, e: usize, found: &mut i32) {

    if xt <= t {
        if d < k {
            for i in s ..= e {
                find(k, t, sls, d+1, xt + sls[i], i+1, e+1, found);
            }
        }
        else if d == k && xt > *found {
            *found = xt;
        }
    }
}

fn choose_best_sum(t: i32, k: i32, ls: &Vec<i32>) -> i32 {

    if k as usize <= ls.len() { 
            
        let mut found = -1;
        let mut sls = ls.clone().into_iter().filter(|x| *x <= t).collect::<Vec<i32>>();
        sls.sort();
        sls.reverse();

        find(k, t, &sls, 0, 0, 0, sls.len()-k as usize, &mut found);
        found
        
    } else {
        -1
    }

}

#[cfg(test)]
mod tests {

    use super::*;

    fn testing(t: i32, k: i32, ls: &Vec<i32>, exp: i32) -> () {
        assert_eq!(choose_best_sum(t, k, ls), exp)
    }
        
    #[test]
    fn basics_choose_best_sum() {
        
        let ts = &vec![50, 55, 56, 57, 58];
        testing(163, 3, ts, 163);
        let ts = &vec![50];
        testing(163, 3, ts, -1);
        let ts = &vec![91, 74, 73, 85, 73, 81, 87];
        testing(230, 3, ts, 228);
        testing(331, 2, ts, 178);
        
    }

}
