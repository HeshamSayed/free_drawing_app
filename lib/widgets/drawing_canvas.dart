import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../models/drawing.dart';

class DrawingCanvas extends StatelessWidget {
  final List<List<DrawingPoint>> strokes;
  final List<DrawingPoint>? currentStroke;
  final Size canvasSize;
  final Color backgroundColor;
  final double scale;
  final Offset offset;

  const DrawingCanvas({
    super.key,
    required this.strokes,
    this.currentStroke,
    required this.canvasSize,
    this.backgroundColor = Colors.white,
    this.scale = 1.0,
    this.offset = Offset.zero,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: canvasSize,
      painter: DrawingPainter(
        strokes: strokes,
        currentStroke: currentStroke,
        backgroundColor: backgroundColor,
        scale: scale,
        offset: offset,
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<List<DrawingPoint>> strokes;
  final List<DrawingPoint>? currentStroke;
  final Color backgroundColor;
  final double scale;
  final Offset offset;

  DrawingPainter({
    required this.strokes,
    this.currentStroke,
    required this.backgroundColor,
    this.scale = 1.0,
    this.offset = Offset.zero,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = backgroundColor,
    );

    // Apply transformations
    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    canvas.scale(scale);

    // Draw all completed strokes
    for (final stroke in strokes) {
      _drawStroke(canvas, stroke);
    }

    // Draw current stroke being drawn
    if (currentStroke != null && currentStroke!.isNotEmpty) {
      _drawStroke(canvas, currentStroke!);
    }

    canvas.restore();
  }

  void _drawStroke(Canvas canvas, List<DrawingPoint> stroke) {
    if (stroke.isEmpty) return;

    for (int i = 0; i < stroke.length - 1; i++) {
      final point1 = stroke[i];
      final point2 = stroke[i + 1];

      final paint = _getPaintForBrush(point1);

      canvas.drawLine(
        Offset(point1.x, point1.y),
        Offset(point2.x, point2.y),
        paint,
      );

      // Draw circle at each point for smoother appearance
      canvas.drawCircle(
        Offset(point1.x, point1.y),
        point1.strokeWidth / 2,
        paint,
      );
    }

    // Draw last point
    if (stroke.isNotEmpty) {
      final lastPoint = stroke.last;
      final paint = _getPaintForBrush(lastPoint);
      canvas.drawCircle(
        Offset(lastPoint.x, lastPoint.y),
        lastPoint.strokeWidth / 2,
        paint,
      );
    }
  }

  Paint _getPaintForBrush(DrawingPoint point) {
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = point.strokeWidth
      ..isAntiAlias = true;

    final color = Color(point.color).withOpacity(point.opacity);

    switch (point.brushType) {
      case BrushType.pen:
        paint.color = color;
        paint.style = PaintingStyle.stroke;
        break;

      case BrushType.marker:
        paint.color = color.withOpacity(0.6);
        paint.style = PaintingStyle.stroke;
        paint.strokeWidth = point.strokeWidth * 1.5;
        break;

      case BrushType.pencil:
        paint.color = color;
        paint.style = PaintingStyle.stroke;
        paint.strokeWidth = point.strokeWidth * 0.8;
        break;

      case BrushType.neon:
        paint.color = color;
        paint.style = PaintingStyle.stroke;
        paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
        paint.strokeWidth = point.strokeWidth * 1.2;
        break;

      case BrushType.watercolor:
        paint.color = color.withOpacity(0.4);
        paint.style = PaintingStyle.stroke;
        paint.strokeWidth = point.strokeWidth * 2;
        paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
        break;

      case BrushType.eraser:
        paint.color = backgroundColor;
        paint.style = PaintingStyle.stroke;
        paint.strokeWidth = point.strokeWidth * 2;
        paint.blendMode = BlendMode.src;
        break;
    }

    return paint;
  }

  @override
  bool shouldRepaint(covariant DrawingPainter oldDelegate) {
    return oldDelegate.strokes != strokes ||
        oldDelegate.currentStroke != currentStroke ||
        oldDelegate.scale != scale ||
        oldDelegate.offset != offset;
  }
}
