import strutils, sequtils, tables

let chs = ('0' .. '9').toSeq & ('A' .. 'Z').toSeq
var ords = (0 .. 35).mapIt((chs[it], it)).toTable

proc dec2FactString*(nb: int64): string =
  result = ""

  var 
    n = nb
    i = 1
    r = 0.int64

  while n > 0:
    r = n mod i
    n = n div i
    inc i
    result = $chs[r] & result


proc factString2Dec*(str: string): int64 =
  
  var 
    l = str.len - 1
    i = 0
    tot = ords[str[i]]
  
  while l > 0:
    tot = (tot * l + ords[str[i+1]])
    dec l
    inc i

  tot


import random, strutils, math, sequtils, unittest
randomize()

proc dotest1(n: int64, exp: string) =
    echo "n ", n
    let actual = dec2FactString(n)
    echo "Exp: $1\ngot: $2".format(exp, actual)
    echo actual == exp
    check(actual == exp)
    echo "-"
proc dotest2(str: string, exp: int64) =
    echo "str ", str
    let actual = factString2Dec(str)
    echo "Exp: $1\ngot: $2".format(exp, actual)
    echo actual == exp
    check(actual == exp)
    echo "-"

suite "dec2FactString":
  test "fixed tests":
    dotest1(36288000, "A0000000000")
    dotest1(2982, "4041000")

suite "factString2Dec":
  test "fixed tests":
    dotest2("341010", 463)
    dotest2("4042100", 2990)    