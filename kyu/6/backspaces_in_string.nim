import strutils

proc cleanString*(s: string): string =

    result = s
    result.removePrefix('#')

    if result.len > 0:

        while true:

            var lead = 0
            var i = 0
            
            while i < result.len and result[i] != '#':
                inc lead
                inc i

            if lead == result.len:
                return result

            while i < result.len and result[i] == '#':
                dec lead
                inc i

            if lead <= 0: 

                if i == result.len:
                    return ""
                
                result = result[i .. ^1]
            
            else:
                result[0 ..< i] = result[0 ..< lead]
            
    

import unittest

test "Sample tests":
  check(cleanString("abc#d##c") == "ac")
  check(cleanString("abc####d##c#") == "")
  check(cleanString("abc####c") == "c")
  check(cleanString("abc#######") == "")
  check(cleanString("#######") == "")
  check(cleanString("#######abc") == "abc")
  check(cleanString("#######a#bc#") == "b")
  check(cleanString("#######abc###") == "")
  check(cleanString("") == "")