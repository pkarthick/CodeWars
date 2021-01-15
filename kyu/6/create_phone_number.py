from functools import reduce
from operator import add

def create_phone_number(numbers):
    def format(nums):
        return reduce(add, map(lambda x: chr(x+48), nums))
    return '(' + format(numbers[0:3]) + ') ' + format(numbers[3:6]) + '-' + format(numbers[6:])

print(create_phone_number([1, 2, 3, 4, 5, 6, 7, 8, 9, 0]) == "(123) 456-7890")
print(create_phone_number([1, 1, 1, 1, 1, 1, 1, 1, 1, 1]) == "(111) 111-1111")
print(create_phone_number([1, 2, 3, 4, 5, 6, 7, 8, 9, 9]) == "(123) 456-7899")

print("Success!")