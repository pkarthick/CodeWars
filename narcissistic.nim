import math

proc narcissistic*(value: int): bool =
  
  let digits = ($value).len() # better way to find out the number of digits? other than division
  
  var 
      total = 0
      v = value

  while v > 0:
      let last = v %% 10
      total = total + (last ^ digits)
      v = v div 10
  
  value == total


assert narcissistic 153

assert not narcissistic 1652
