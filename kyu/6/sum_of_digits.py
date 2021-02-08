def digital_root(n):

    def sum_of_digits(q):
        s = 0
        while q >= 10:
            q, r = divmod(q, 10)
            s += r
        s += q
        return s

    return n if n < 10 else digital_root(sum_of_digits(n))

assert digital_root(16) == 7
assert digital_root(942) == 6
assert digital_root(132189) == 6
assert digital_root(493193) == 2

print("Done!")
