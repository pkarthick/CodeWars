import 'test.dart';

class SequenceSum {
  static String showSequence(num n) {
    if (n == 0) {
      return '0=0';
    } else if (n < 0) {
      return '$n<0';
    } else {
      var ns = List.generate(n + 1 as int, (index) => index);
      return '${ns.map((e) => e.toString()).join('+')} = ${ns.reduce((value, element) => value + element)}';
    }
  }
}

List<int> rowWeights(List<int> arr) {
  var f = 0, s = 0;
  arr.asMap().forEach((key, value) {
    if (key % 2 == 0) {
      f += value;
    } else {
      s += value;
    }
  });
  return [f, s];
}

void main() {
  test('Basic tests', () {
    expect(SequenceSum.showSequence(0), equals("0=0"));
    expect(SequenceSum.showSequence(6), equals("0+1+2+3+4+5+6 = 21"));
  });
}
