from collections import deque

def is_eureka(num):
  if num < 10:
    return True
  elif num == 10:
    return False
  else:
    ds = []
    q = num

    while q > 10:
      q, r = divmod(q, 10)
      ds.append(r)

    ds.append(q)
    
    s = 0
    
    for e in range(1, len(ds)+1):
      s += pow(ds[-e], e)

    return s == num

def sum_dig_pow(a, b): # range(a, b + 1) will be studied by the function
    
    result = []

    for n in range(a, b+1, 1):
        if is_eureka(n):
            result.append(n)
    
    return result




assert sum_dig_pow(1, 10) == [1, 2, 3, 4, 5, 6, 7, 8, 9]
assert sum_dig_pow(1, 100) == [1, 2, 3, 4, 5, 6, 7, 8, 9, 89]

assert sum_dig_pow(10, 89) ==  [89]
assert sum_dig_pow(10, 100) ==  [89]
assert sum_dig_pow(90, 100) == []

assert sum_dig_pow(89, 135) == [89, 135]
assert sum_dig_pow(1, 135) == [1, 2, 3, 4, 5, 6, 7, 8, 9, 89, 135]

print("Done!")

