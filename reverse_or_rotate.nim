import sequtils
import math
import algorithm

proc revrot*(s: string, n: int): string =

    if n == 0 or s.len == 0:
        ""
    else:
        var str = s.substr(0, (s.len div n) * n - 1)
        for i in 0 ..< str.len div n:
            let 
                s = i*n 
                e = (i+1)*n-1
                sl = s .. e
        
            if str[sl].mapIt((it.int - 48) ^ 3).foldl(a+b) %% 2 == 0:
                str.reverse(s, e)
            else:
                str.rotateLeft(sl, 1)

        str

assert revrot("123456987654", 6) == "234561876549"
assert revrot("123456987653", 6) == "234561356789"
assert revrot("66443875", 4) == "44668753"
assert revrot("66443875", 8) == "64438756"
assert revrot("664438769", 8) == "67834466"
assert revrot("123456779", 8) == "23456771"
assert revrot("", 8) == ""
assert revrot("123456779", 0) == "" 
assert revrot("563000655734469485", 4) == "0365065073456944"