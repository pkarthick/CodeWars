def validBraces(s):

    stack = []

    for ch in s:

        if ch == '}':
            if len(stack) == 0 or '{' != stack.pop():
                return False

        elif ch == ']':

            if len(stack) == 0 or '[' != stack.pop():
                return False

        elif ch == ')':

            if len(stack) == 0 or '(' != stack.pop():
                return False

        else:
            stack.append(ch),
        
    return len(stack) == 0

assert validBraces("()") == True
assert validBraces("(){}[]") == True
assert validBraces("([{}])") == True
assert validBraces("([{}]))") == False
assert validBraces("(}") == False
assert validBraces("[(])") == False
assert validBraces("[({})](]") == False

print("Success!")
    