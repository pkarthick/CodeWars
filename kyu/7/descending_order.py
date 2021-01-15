from functools import reduce

def descending_order(num):
    digits = []

    while num >= 10:
        (num, rem) = divmod(num, 10)
        digits.append(rem)

    digits.append(num)

    digits.sort(reverse=True)

    return reduce(lambda a, x: a * 10 + x, digits, 0)

assert descending_order(42145) == 54421
assert descending_order(145263) == 654321
assert descending_order(123456789) == 987654321

assert descending_order(1021) == 2110

print("Success!")
