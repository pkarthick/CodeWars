let romanPairs = [(1000, 'M'), (500, 'D'), (100, 'C'), (50, 'L'), (10, 'X'), (5, 'V'), (1, 'I')]

proc solution*(number: int64): string =
  
    result = ""
    var num = number
    var ind = 0

    while num > 0:
        
        let (tenval, tenletter) = romanPairs[ind]
        let (fiveval, fiveletter) = romanPairs[ind+1]
        let (oneval, oneletter) = romanPairs[ind+2]
        
        if num >= tenval:
            num -= tenval
            result &= tenletter
            continue

        elif num >= tenval - oneval:
            num -= tenval - oneval
            result &= oneletter & tenletter

        elif num >= fiveval:
            num -= fiveval
            result &= fiveletter
            continue
        
        elif num >= fiveval - oneval:
            num -= fiveval - oneval
            result &= oneletter & fiveletter

        elif num >= oneval:
            while num >= oneval:
                num -= oneval
                result &= oneletter

        inc ind, 2

import unittest

suite "Sample Test Cases":
  test "simple cases":
    check(solution(1) == "I")
    check(solution(4) == "IV") #, "4 should == \"IV\"")
    check(solution(9) == "IX")
    check(solution(11) == "XI")
    check(solution(41) == "XLI")
    check(solution(51) == "LI")
    check(solution(81) == "LXXXI")
    check(solution(101) == "CI")
    check(solution(110) == "CX")
    check(solution(201) == "CCI")
    check(solution(421) == "CDXXI")
    check(solution(541) == "DXLI")
    check(solution(861) == "DCCCLXI")
    check(solution(1934) == "MCMXXXIV")
    check(solution(1938) == "MCMXXXVIII")
    check(solution(1939) == "MCMXXXIX")
    check(solution(1000) == "M") #, "1000 should == \"M\"")
    check(solution(1990) == "MCMXC") #, "1990 should == \"MCMXC\"")
    check(solution(2007) == "MMVII") #, "2007 should == \"MMVII\"")
    check(solution(1490) == "MCDXC")
    check(solution(1590) == "MDXC")
    check(solution(1790) == "MDCCXC")