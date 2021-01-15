def iq_test(numbers):

    odd = even = oddi = eveni = 0
        
    for i, s in enumerate(numbers.split(' ')):

        if int(s) % 2 == 0:
            even += 1
            eveni = i+1
        else:
            odd += 1
            oddi = i+1

        if odd > 1 and even == 1:
            return eveni
        elif even > 1 and odd == 1:
            return oddi

def iq_test_with_list(numbers):

    odds = []
    evens = []
    
    for i, s in enumerate(numbers.split(' ')):

        if int(s) % 2 == 0:
            evens.append(i+1)
        else:
            odds.append(i+1)
            
        if len(evens) > 1 and len(odds) == 1:
            return odds[0]
        elif len(odds) > 1 and len(evens) == 1:
            return evens[0]

assert iq_test("2 4 7 8 10") == 3
assert iq_test("1 2 1 1") == 2
assert iq_test("1 2 2") == 1

print("Success!")