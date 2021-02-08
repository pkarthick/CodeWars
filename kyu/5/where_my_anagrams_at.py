from typing import Counter

def anagrams(word, words):
    c = Counter(word)
    return list(filter(lambda w: Counter(w) == c, words))

assert anagrams('abba', ['aabb', 'abcd', 'bbaa', 'dada']) == ['aabb', 'bbaa']
assert anagrams('racer', ['crazer', 'carer', 'racar', 'caers', 'racer']) == ['carer', 'racer']

print("Done!")