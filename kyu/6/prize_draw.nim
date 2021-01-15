import strutils
import sequtils
import algorithm

proc nthRank*(st: string, we: seq[int], n: int): string =  


    if st.len == 0:
        "No participants"
    else:
        let ps = st.split(',')

        proc winningNumber(i: int): int =

            proc rank(c: char): int =
                case c:
                    of 'A' .. 'Z': result = ord(c) - 64
                    of 'a' .. 'z': result = ord(c) - 96
                    else: discard

            let som = ps[i].len + ps[i].mapIt(it.rank).foldl(a + b)
            we[i] * som

        proc compare(i1, i2: int): int = 
            let wn1 = i1.winningNumber
            let wn2 = i2.winningNumber
            if wn1 == wn2:
                ps[i2].cmpIgnoreCase(ps[i1])
            else: 
                wn1.cmp(wn2) #winning numbers are descending

        if n > ps.len():
            "Not enough participants"
        else:
            
            var sorted = (0 ..< ps.len).toSeq.sorted(compare, SortOrder.Descending)
            echo sorted.mapIt((it.winningNumber, ps[it], it))
            
            ps[sorted[n-1]]


import strutils, unittest

suite "nthRank":
  test "fixed tests":
    proc testing(st: string, we: seq[int], n: int, exp: string) =
      echo "st ", st
      echo "we ", we
      echo "n ", n
      let actual = nthRank(st, we, n)
      echo "Exp: $1\ngot: $2".format(exp, actual)
      check(actual == exp)
      echo "-"
    
    testing("COLIN,AMANDBA,AMANDAB,CAROL,PauL,JOSEPH", @[1, 4, 4, 5, 2, 1], 4, "PauL")
    testing("Addison,Jayden,Sofia,Michael,Andrew,Lily,Benjamin", @[4, 2, 1, 4, 3, 1, 2], 4, "Benjamin")
    testing("Elijah,Chloe,Elizabeth,Matthew,Natalie,Jayden", @[1, 3, 5, 5, 3, 6], 2, "Matthew")    
    testing("Aubrey,Olivai,Abigail,Chloe,Andrew,Elizabeth", @[3, 1, 4, 4, 3, 2], 4, "Abigail")    
      
          