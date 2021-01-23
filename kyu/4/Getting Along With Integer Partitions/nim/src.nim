import mymacros

import tables, sequtils

type
    Partition = tuple[count: int, product: int]

var maxProduct: Table[int, Partition]

maxProduct[1] = (1, 1)
maxProduct[2] = (2, 2)
maxProduct[3] = (3, 3)
maxProduct[4] = (5, 4)

proc initialize() =
  
    for num in 5 .. 10:
        var count = 3

        echo ""
        inspect num

        for f in 2 .. num-2:

            inspect f
            
            let times = num div f - 1
            let rem = num mod f

            if rem == 0:
                inspect maxProduct[f].count
                inc count, maxProduct[f].count
            elif rem == 1:
                inspect 1
                inc count, 1
            else:
                inspect maxProduct[rem].count
                inc count, maxProduct[rem].count
            

            inc count, times * maxProduct[f].count
                
            
            inspect f, times, rem, count

        # let count = (2 .. num-1).foldl(a + maxProduct[num - b].count, 1)
        let prod = 2 * maxProduct[num-2].product
        inspect num, count, prod

        maxProduct[num] = (count, prod)

proc part*(n: int): string =

    let rng = maxProduct[n][1] - 1
    let avg = 3.50
    let med = 3.50

    initialize()

    return "Range: " & $rng & " Average: " & $avg & " Median: " & $med

import random, strutils, unittest
randomize()

proc dotest(n: int, exp: string) =
    echo "n: $1".format(n)
    let actual = part(n)
    echo "Exp: $1\ngot: $2".format(exp, actual)
    echo actual == exp
    check(actual == exp)
    echo "-"
    
suite "part":
  test "fixed tests":
    dotest(3, "Range: 2 Average: 2.00 Median: 2.00")
    dotest(4, "Range: 3 Average: 2.50 Median: 2.50")
    dotest(5, "Range: 5 Average: 3.50 Median: 3.50")
    

