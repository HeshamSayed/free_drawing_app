import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:artjoy/utils/drawing_controller.dart';
import 'package:artjoy/models/drawing.dart';

void main() {
  group('DrawingController Tests', () {
    late DrawingController controller;

    setUp(() {
      controller = DrawingController();
    });

    tearDown(() {
      controller.dispose();
    });

    test('Controller initializes with correct defaults', () {
      expect(controller.strokes, isEmpty);
      expect(controller.currentStroke, isEmpty);
      expect(controller.selectedColor, Colors.black);
      expect(controller.strokeWidth, 5.0);
      expect(controller.opacity, 1.0);
      expect(controller.selectedBrush, BrushType.pen);
      expect(controller.scale, 1.0);
      expect(controller.canUndo, false);
    });

    test('setColor should update selected color', () {
      controller.setColor(Colors.red);
      expect(controller.selectedColor, Colors.red);
    });

    test('setStrokeWidth should update stroke width', () {
      controller.setStrokeWidth(10.0);
      expect(controller.strokeWidth, 10.0);
    });

    test('setBrush should update selected brush', () {
      controller.setBrush(BrushType.marker);
      expect(controller.selectedBrush, BrushType.marker);
    });

    test('startStroke should create new stroke', () {
      controller.startStroke(const Offset(10, 20));
      expect(controller.currentStroke, isNotEmpty);
      expect(controller.currentStroke.length, 1);
    });

    test('clear should empty strokes', () {
      controller.startStroke(const Offset(10, 20));
      controller.endStroke();
      expect(controller.strokes, isNotEmpty);

      controller.clear();
      expect(controller.strokes, isEmpty);
    });
  });
}
