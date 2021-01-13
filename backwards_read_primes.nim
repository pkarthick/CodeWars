import math
import sequtils
import strutils
import unicode

func isPrime(num: int): bool =
    num > 1 and (2 .. sqrt(num.toFloat).toInt).allIt(num %% it > 0)

func isReversePrime(num: int): bool =
    if num >= 13 and isPrime(num):
        let revNum = ($num).reversed.parseInt
        result = revNum != num and isPrime(revNum)

func backwardsPrime*(start, stop: int): seq[int] =
    (start .. stop).toSeq.filter(isReversePrime)

import random, strutils, unittest
randomize()

proc testing(start, stop: int, exp: seq[int]) =
    echo "start: $1 stop: $2".format(start, stop)
    let actual = backwardsPrime(start, stop)
    echo "Exp: $1\ngot: $2".format(exp, actual)
    echo actual == exp
    check(actual == exp)
    echo "-"

suite "backwardsPrime":
  test "fixed tests":
    var a: seq[int] = @[13, 17, 31, 37, 71, 73, 79, 97]
    testing(1, 100, a)
    a = @[13, 17, 31]
    testing(1, 31, a)
    a = @[107, 113, 149, 157, 167, 179, 199]
    testing(101, 199, a)
    