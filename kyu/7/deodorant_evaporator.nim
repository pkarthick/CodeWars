import strutils
proc evaporator*(content: float64, evapPerDay: int, threshold: int): int =

    let 
        thresholdml = content * float(threshold) * 0.01
        evap = 1 - float(evapPerDay) * 0.01
    
    var 
        content = content
        days = 0

    while content >= thresholdml:
        content *= evap
        inc days

    days

import unittest

proc dotest(content: float64, evapPerDay: int, threshold: int, exp: int) =
    echo "content: $1 evapPerDay: $2 threshold: $3".format(content, evapPerDay, threshold)
    let actual = evaporator(content, evapPerDay, threshold)
    echo "Exp: $1\ngot: $2".format(exp, actual)
    echo actual == exp
    check(actual == exp)
    echo "-"

suite "evaporator":
  test "fixed tests":
    dotest(10, 10, 10, 22)
    dotest(10, 10, 5, 29)