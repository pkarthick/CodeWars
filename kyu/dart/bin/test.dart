library test;

void group(String groupName, Function func) {
  func();
}

void test(String testName, Function testFunc) {
  testFunc();
}

void expect<T>(T actual, T expected) {
  if (actual != expected) {
    throw 'Not Equal!';
  }
}

T equals<T>(T input) => input;
