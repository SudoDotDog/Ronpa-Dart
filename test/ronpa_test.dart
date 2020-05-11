import 'package:ronpa/ronpa.dart';
import 'package:test/test.dart';

void main() {
  group('Ronpa Class', () {
    test('test creation', () {
      final Ronpa ronpa = Ronpa();

      expect(ronpa, isA<Ronpa>());
    });
  });
}
