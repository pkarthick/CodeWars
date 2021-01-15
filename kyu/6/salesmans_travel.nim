import unittest
import strutils
import sequtils

proc travel*(r, zipcode: string): string =

    if zipcode.len() == 0:
      ":/"
    else:
      let matches = r
              .splitLines()
              .join()
              .split(",")
              .mapIt(it.strip())
              .filterIt(it.endsWith(zipcode))
              .map(proc (address: string): (string, string) =
                      let segs = address.split(' ', 1)
                      (segs[1][0..^10], segs[0]))
  
      if matches.len() == 0:
          zipcode & ":/"
      else:
          let (street, house) = matches.foldl((a[0] & "," & b[0], a[1] & "," & b[1]))
          zipcode & ":" & street & "/" & house

let ad = """
123 Main Street St. Louisville OH 43071, 432 Main Long Road St. Louisville OH 43071, 786 High Street Pollocksville NY 56432,
54 Holy Grail Street Niagara Town ZP 32908, 3200 Main Rd. Bern AE 56210, 1 Gordon St. Atlanta RE 13000,
10 Pussy Cat Rd. Chicago EX 34342, 10 Gordon St. Atlanta RE 13000, 58 Gordon Road Atlanta RE 13000,
22 Tokyo Av. Tedmondville SW 43098, 674 Paris bd. Abbeville AA 45521, 10 Surta Alley Goodtown GG 30654,
45 Holy Grail Al. Niagara Town ZP 32908, 320 Main Al. Bern AE 56210, 14 Gordon Park Atlanta RE 13000,
100 Pussy Cat Rd. Chicago EX 34342, 2 Gordon St. Atlanta RE 13000, 5 Gordon Road Atlanta RE 13000,
2200 Tokyo Av. Tedmondville SW 43098, 67 Paris St. Abbeville AA 45521, 11 Surta Avenue Goodtown GG 30654,
45 Holy Grail Al. Niagara Town ZP 32918, 320 Main Al. Bern AE 56215, 14 Gordon Park Atlanta RE 13200,
100 Pussy Cat Rd. Chicago EX 34345, 2 Gordon St. Atlanta RE 13222, 5 Gordon Road Atlanta RE 13001,
2200 Tokyo Av. Tedmondville SW 43198, 67 Paris St. Abbeville AA 45522, 11 Surta Avenue Goodville GG 30655,
2222 Tokyo Av. Tedmondville SW 43198, 670 Paris St. Abbeville AA 45522, 114 Surta Avenue Goodville GG 30655,
2 Holy Grail Street Niagara Town ZP 32908, 3 Main Rd. Bern AE 56210, 77 Gordon St. Atlanta RE 13000,
100 Pussy Cat Rd. Chicago OH 13201
"""

proc dotest(r, zipcode: string, exp: string) =
    echo "zipcode ", zipcode
    let actual = travel(r, zipcode)
    echo "Exp: $1\ngot: $2".format(exp, actual)
    echo actual == exp
    check(actual == exp)
    echo "-"

suite "travel":
  test "fixed tests":
    dotest(ad, "AA 45522", "AA 45522:Paris St. Abbeville,Paris St. Abbeville/67,670")
    dotest(ad, "OH 430", "OH 430:/")
    