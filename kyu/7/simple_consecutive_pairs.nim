proc consecutivePairs*(arr: openarray[int]): int =
  var i = 0
  while i < arr.len - 1:
    let diff = arr[i+1] - arr[i]
    if diff == 1 or diff == -1:
      # echo diff, " ", arr[i], " ", arr[i+1]
      inc result
      
    inc i, 2


import unittest

test "Basic tests":
  check:
    consecutivePairs([1,2,5,8,-4,-3,7,6,5]) == 3
    consecutivePairs([21, 20, 22, 40, 39, -56, 30, -55, 95, 94]) == 2
    consecutivePairs([81, 44, 80, 26, 12, 27, -34, 37, -35]) == 0
    consecutivePairs([-55, -56, -7, -6, 56, 55, 63, 62]) == 4
    consecutivePairs([73, 72, 8, 9, 73, 72]) == 3