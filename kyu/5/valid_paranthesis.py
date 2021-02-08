from collections import deque

def valid_parentheses(string):
    
    brackets = deque([])
    
    for c in string:
        if c == "(":
            brackets.append("(")
        elif c == ")":  
            if len(brackets) > 0:
                brackets.pop()
            else:
                return False

    return len(brackets) == 0

assert valid_parentheses("  (") == False
assert valid_parentheses(")test") == False
assert valid_parentheses("")
assert valid_parentheses("hi())(") == False
assert valid_parentheses("hi(hi)()")
assert valid_parentheses("hi(hi)")
assert valid_parentheses("hihi()")
assert valid_parentheses("")

print("Done!")