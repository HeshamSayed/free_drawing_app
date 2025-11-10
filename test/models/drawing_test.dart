import 'package:flutter_test/flutter_test.dart';
import 'package:artjoy/models/drawing.dart';

void main() {
  group('Drawing Model Tests', () {
    test('DrawingPoint should be created correctly', () {
      final point = DrawingPoint(
        x: 10.0,
        y: 20.0,
        color: 0xFF000000,
        strokeWidth: 5.0,
        brushType: BrushType.pen,
        opacity: 1.0,
      );

      expect(point.x, 10.0);
      expect(point.y, 20.0);
      expect(point.color, 0xFF000000);
      expect(point.strokeWidth, 5.0);
      expect(point.brushType, BrushType.pen);
      expect(point.opacity, 1.0);
    });

    test('Drawing should be created correctly', () {
      final now = DateTime.now();
      final drawing = Drawing(
        id: 'test-id',
        name: 'Test Drawing',
        createdAt: now,
        modifiedAt: now,
        strokes: [],
      );

      expect(drawing.id, 'test-id');
      expect(drawing.name, 'Test Drawing');
      expect(drawing.strokes, isEmpty);
    });

    test('Drawing copyWith should work correctly', () {
      final now = DateTime.now();
      final drawing = Drawing(
        id: 'test-id',
        name: 'Test Drawing',
        createdAt: now,
        modifiedAt: now,
        strokes: [],
      );

      final updated = drawing.copyWith(name: 'Updated Name');

      expect(updated.id, drawing.id);
      expect(updated.name, 'Updated Name');
      expect(updated.createdAt, drawing.createdAt);
    });
  });
}
