import unittest
import sequtils

proc sumOfN*(n: int): seq[int] =
    if n >= 0:
        (1 .. n).foldl(a & (a[^1] + b), @[0])
    else:
        (1 .. abs(n)).foldl(a & (a[^1] - b), @[0])

test "Basic tests":
  check:
    sumOfN(3) == @[0, 1, 3, 6]
    sumOfN(-4) == @[0, -1, -3, -6, -10]
    sumOfN(1) == @[0, 1]
    sumOfN(0) == @[0]
    sumOfN(10) == @[0, 1, 3, 6, 10, 15, 21, 28, 36, 45, 55]