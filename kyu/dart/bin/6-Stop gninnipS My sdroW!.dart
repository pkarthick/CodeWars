import 'test.dart';

String spinWords(String input) {
  return input
      .split(' ')
      .map((e) => e.length >= 5 ? e.split('').reversed.join('') : e)
      .join(' ');
}

void main() {
  group('Fixed tests', () {
    test('Testing for Welcome', () {
      expect(spinWords('Welcome'), equals('emocleW'));
    });
    test('Testing for Hey fellow warriors', () {
      expect(spinWords('Hey fellow warriors'), equals('Hey wollef sroirraw'));
    });
    test('Testing for This is a test', () {
      expect(spinWords('This is a test'), equals('This is a test'));
    });
    test('Testing for This is another test', () {
      expect(spinWords('This is another test'), equals('This is rehtona test'));
    });
    test('Testing for You are almost to the last test', () {
      expect(spinWords('You are almost to the last test'),
          equals('You are tsomla to the last test'));
    });
    test('Testing for Just kidding there is still one more', () {
      expect(spinWords('Just kidding there is still one more'),
          equals('Just gniddik ereht is llits one more'));
    });
    test('Testing for Seriously this is the last one', () {
      expect(spinWords('Seriously this is the last one'),
          equals('ylsuoireS this is the last one'));
    });
  });
}
