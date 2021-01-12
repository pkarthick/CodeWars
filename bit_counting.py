def count_bits(n):

    c = 0

    while n > 1:
        (n, r) = divmod(n, 2)
        if r == 1: c += 1

    if n == 1: c += 1

    return c

assert count_bits(0) == 0
assert count_bits(4) == 1
assert count_bits(7) == 3
assert count_bits(9) == 2
assert count_bits(10) == 2
assert count_bits(1234) == 5

print("Success!")