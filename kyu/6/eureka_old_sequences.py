from collections import deque

class Digits:

  def __init__(self, start, end):
    self.cur = start
    self.start = start
    self.end = end
    self.eureka = 0
    self.ds = []

    
  def __iter__(self):

    q = self.cur 

    if q > 10:

        self.ds = []

        while q > 10:
            q, r = divmod(q, 10)
            self.ds.append(r)

        self.ds.append(q)
        self.ds.reverse()
        self.reset()

    else:
        self.ds.append(self.start)
        self.eureka = self.start

    return self

  def sum(self):
        s = 0
        ds = self.ds

        for e in range(1, len(ds)+1):
            s += pow(ds[e-1], e)

        return s

  def __next__(self):

    if self.cur < self.end:

        cur = self.cur
        eureka = self.eureka

        self.cur += 1

        d = self.ds.pop()
        c = 0

        while d == 9:
            c += 1

            if len(self.ds) > 0:
                d = self.ds.pop()
            else:
                d = 0

        d += 1
        self.ds.append(d)

        for _ in range(1, c+1):
            self.ds.append(0)

        if c == 0:
            l = len(self.ds)
            if l > 1:
                self.eureka = self.eureka + pow(self.ds[l-1], l)
            else:
                self.eureka = self.ds[0]
        else:
            self.reset()
            

        return (cur, eureka)
    else:
        raise StopIteration


def sum_dig_pow(a, b): # range(a, b + 1) will be studied by the function
    
    print("a,b", a, b)

    result = []
    digits = Digits(a, b)

    for (n, eur) in digits:
        print(n, eur)
        if eur == n:
            result.append(n)
    
    print("result", result)

    return result

assert sum_dig_pow(1, 10) == [1, 2, 3, 4, 5, 6, 7, 8, 9]
assert sum_dig_pow(1, 100) == [1, 2, 3, 4, 5, 6, 7, 8, 9, 89]

# assert sum_dig_pow(10, 89) ==  [89]
# assert sum_dig_pow(10, 100) ==  [89]
# assert sum_dig_pow(90, 100) == []

# assert sum_dig_pow(89, 135) == [89, 135]
# assert sum_dig_pow(1, 135) == [1, 2, 3, 4, 5, 6, 7, 8, 9, 89, 135]

print("Done!")

