import strutils, sequtils, sets, algorithm

proc inArray*(array1, array2: seq[string]): seq[string] =
    
    var s: HashSet[string]
    
    for a1 in array1:
        if array2.anyIt(it.contains(a1)):
            s.incl a1 

    s.toSeq.sorted()


import random, strutils, algorithm, unittest
randomize()

proc testing(array1, array2: seq[string], exp: seq[string]) =
    echo "array1: ", array1
    echo "array2: ", array2
    let actual: seq[string] = inArray(array1, array2)
    echo "Exp: ", exp
    echo "Got: ", actual
    echo actual == exp
    check(actual == exp)
    echo "-"

suite "inArray":
  test "fixed tests":
    var a1: seq[string] = @["live", "arp", "strong"] 
    var a2: seq[string] = @["lively", "alive", "harp", "sharp", "armstrong"]
    var r: seq[string] = @["arp", "live", "strong"]
    testing(a1, a2, r)
       
    a1 = @["arp", "mice", "bull"] 
    a2 = @["lively", "alive", "harp", "sharp", "armstrong"]
    r = @["arp"]
    testing(a1, a2, r)

    a1 = @["cod", "code", "wars", "ewar", "ar"] 
    a2 = @[]
    r = @[]
    testing(a1, a2, r)
    
    a2 = @["cod", "code", "wars", "ewar", "ar"] 
    a1 = @[]
    r = @[]
    testing(a1, a2, r)