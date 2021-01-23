import sequtils, sets

var primes = @[2, 3, 5, 7].toHashSet
var last = 10

proc isPrime(n: int): bool =
    
    if n > last:
        last = n
    
    if primes.allIt(n %% it != 0):
        primes.incl n
        return true

    false

proc gap*(g, m, n: int): seq[int] =

    for i in last .. m:
        discard i.isPrime

    var prevPrime = 0

    for p in m .. n:
        if (m < last and primes.contains(p)) or p.isPrime:
            if prevPrime == 0:
                prevPrime = p
                continue
            else:
                if p - prevPrime == g:
                    return @[prevPrime, p]
                prevPrime = p

    @[]

import strutils, unittest

proc dotest(g, m, n: int, exp: seq[int]) =
    echo "g: $1 m: $2 n: $3".format(g, m, n)
    let actual = gap(g, m, n)
    echo "Exp: $1\ngot: $2".format(exp, actual)
    echo actual == exp
    check(actual == exp)
    echo "-"

suite "gap":
  test "fixed tests":
    dotest(2,100,110, @[101, 103])
    dotest(4,100,110, @[103, 107])
    dotest(6,100,110, @[])
    dotest(8,300,400, @[359, 367])
    dotest(10,300,400, @[337, 347])