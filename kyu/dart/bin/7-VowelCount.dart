import 'dart:core';
import 'test.dart';

int getCount(String inputStr) {
  return inputStr.split('').where(['a', 'e', 'i', 'o', 'u'].contains).length;
}

void main() {
  test("Sample tests", () {
    expect(getCount("bcdfghjklmnpqrstvwxy"), equals(0));
    expect(getCount("abcde"), equals(2));
    expect(getCount("aeiou"), equals(5));
    expect(getCount("abracadabra"), equals(5));
  });
}
