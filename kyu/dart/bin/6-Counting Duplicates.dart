import 'package:collection/collection.dart';

import 'test.dart';

int duplicateCount(String text) {
  final groups = groupBy(text.toLowerCase().split(''), (ch) => ch);
  return groups.values.where((g) => g.length > 1).length;
}

void main() {
  test("add", () {
    expect(duplicateCount(""), equals(0));
    expect(duplicateCount("abcde"), equals(0));
    expect(duplicateCount("aabbcde"), equals(2));
    expect(duplicateCount("aabBcde"), equals(2));
    expect(duplicateCount("Indivisibility"), equals(1));
  });
}
