import 'package:flutter_test/flutter_test.dart';
import 'package:artjoy/services/database_service.dart';

void main() {
  group('DatabaseService Tests', () {
    late DatabaseService service;

    setUp(() {
      service = DatabaseService();
    });

    test('DatabaseService should be created', () {
      expect(service, isNotNull);
    });

    test('getAllDrawings should return empty list initially', () {
      final drawings = service.getAllDrawings();
      expect(drawings, isEmpty);
    });

    test('getDrawingsCount should return 0 initially', () {
      final count = service.getDrawingsCount();
      expect(count, 0);
    });
  });
}
