import unittest
import mymacros

const omnibool* = 0

proc `==`*(op1: int, op2: bool): bool = true

macro check*(value: untyped): untyped = 
  discard

let k = 10
inspect k

test "Equals both":
  check(omnibool == true)
  check(omnibool == false)