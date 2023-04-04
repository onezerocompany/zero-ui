import 'package:zero_ui/zero_ui.dart';
import 'package:test/test.dart';

void main() {
  group('object matching', () {
    test('empty query', () {
      expect(scoreObject(object: [''], query: ''), 0.0);
    });
    test('one of two words match', () {
      expect(
        scoreObject(object: ['hello', 'world'], query: 'hello'),
        0.5,
      );
    });
    test('two of two words match', () {
      expect(
        scoreObject(
          object: ['hello', 'world'],
          query: 'hello world',
        ),
        1.0,
      );
    });
    test('one of two is a partial match', () {
      expect(
        scoreObject(
          object: ['hello', 'world'],
          query: 'hell',
        ),
        0.4,
      );
    });
    test('nearly complete match', () {
      expect(
        scoreObject(
          object: ['hello', 'world!'],
          query: 'hell world',
        ),
        closeTo(0.9, 0.01),
      );
    });
    test('removes emoji', () {
      expect(
        scoreObject(
          object: ['hello', 'world! 😂'],
          query: 'world',
        ),
        closeTo(0.5, 0.01),
      );
    });
  });
}
