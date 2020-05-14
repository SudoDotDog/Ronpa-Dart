import 'package:ronpa/ronpa.dart';
import 'package:test/test.dart';

import '../mock/simple.dart';

void main() {
  group('Test Ronpa Apply', () {
    test('test apply bullet add thesis change', () {
      final List<Map<String, dynamic>> originalRecords =
          createMockSimpleRecords(
        'storyId',
        'bullet1Id',
        'bullet2Id',
      );

      final Ronpa ronpa = Ronpa.rebuild(originalRecords);

      expect(ronpa.getBulletsCount(), equals(2));

      final ChangeDraft draft = ThesisChangeDraft(
        'username',
        TextContent('content'),
      );

      ronpa.apply(draft);

      expect(ronpa.getBulletsCount(), equals(3));
    });
  });
}
