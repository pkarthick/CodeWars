import math

proc solEqua*(n: int): seq[seq[int]] =

    let limit = n.toFloat.sqrt.toInt

    if limit * limit == n:
        result.add(@[limit, 0])
    
    for a in 1..limit:
        if n %% a == 0:
            let 
                b = n div a
                twox = a + b
                foury = b - a

            if twox %% 2 == 0 and foury %% 4 == 0:
                result.add(@[twox div 2, foury div 4])

import strutils, unittest

proc testing(n: int, exp: seq[seq[int]]) =
    echo "n: $1".format(n)
    let actual = solEqua(n)
    echo "Exp: $1\ngot: $2".format(exp, actual)
    echo actual == exp
    check(actual == exp)
    echo "-"

suite "solEqua":
  test "fixed tests":
    testing(5, @[@[3, 1]])
    testing(12, @[@[4, 1]])
    testing(90002, @[])
    testing(90005, @[@[45003, 22501], @[9003, 4499], @[981, 467], @[309, 37]])
    testing(9000001, @[@[4500001, 2250000], @[73801, 36870]])