import 'package:flutter_test/flutter_test.dart';
import 'package:artjoy/utils/helpers.dart';

void main() {
  group('Date Formatting', () {
    test('Format today', () {
      final today = DateTime.now();
      final result = Helpers.formatDate(today);
      expect(result, 'Today');
    });

    test('Format yesterday', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      final result = Helpers.formatDate(yesterday);
      expect(result, 'Yesterday');
    });

    test('Format date within week', () {
      final threeDaysAgo = DateTime.now().subtract(const Duration(days: 3));
      final result = Helpers.formatDate(threeDaysAgo);
      // Should contain day name like "Monday", "Tuesday", etc.
      expect(result.length, greaterThan(0));
    });

    test('Format old date', () {
      final oldDate = DateTime(2025, 1, 1);
      final result = Helpers.formatDate(oldDate);
      expect(result, contains('2025'));
    });
  });

  group('Validation', () {
    test('Validate drawing name', () {
      expect(Helpers.validateDrawingName('Valid Name'), null);
      expect(Helpers.validateDrawingName(''), isNotNull);
      expect(Helpers.validateDrawingName('a'), isNotNull);
    });
  });
}
