import algorithm

proc chooseBestSum*(t, k: int, ls: seq[int]): int =

    let sls = ls.sorted(SortOrder.Descending)
    
    proc find(d: int, xt: int, s: int, e: int, found: var int): int =

        if xt <= t:
          if d < k:
              for i in s .. e:
                  let total = find(d+1, xt + sls[i], i+1, e+1, found)
                  if total != -1:
                      return total
          elif d == k and xt > found:
              return xt
          
        -1

    if sls.len < k:
        return -1

    var found = -1
    return find(0, 0, 0, sls.len-k, found)

import strutils, unittest

proc dotest(t, k: int, ls: seq[int], exp: int) =
    echo "t ", t
    echo "k ", k
    echo "ls ", ls
    let actual = chooseBestSum(t, k, ls)
    echo "Exp: $1\ngot: $2".format(exp, actual)
    echo actual == exp
    check(actual == exp)
    echo "-"

suite "chooseBestSum":
  test "fixed tests":
    var ts = @[50, 55, 56, 57, 58]
    dotest(163, 3, ts, 163)
    ts = @[50]
    dotest(163, 3, ts, -1)
    ts = @[91, 74, 73, 85, 73, 81, 87]
    dotest(230, 3, ts, 228)
    dotest(331, 5, ts, -1)