import strutils, sequtils, algorithm

proc thirt*(n: int64): int64 =
  let s = $n
  let ds = s.mapIt(ord(it)-48).toSeq.reversed()
  let rems = [1, 10, 9, 12, 3, 4].cycle(s.len div 6 + 1)
  let tot = ds.zip(rems).foldl(a + (b[0] * b[1]), 0)
  
  if tot == n:
    return tot
  else:
    return thirt(tot)
  

import strutils, unittest

proc testequal(n: int64, exp: int64) =
    echo n
    let actual: int64 = thirt(n)
    echo "Exp: $1\ngot: $2\n".format(exp, actual)
    check(actual == exp)
    echo "-"

suite "thirt":
  test "fixed tests":
    testequal(1234567, 87)
    testequal(8529, 79)
    testequal(85299258, 31)
    testequal(5634, 57)
    


