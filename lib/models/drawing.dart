import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'drawing.g.dart';

@HiveType(typeId: 0)
enum BrushType {
  @HiveField(0)
  pen,
  @HiveField(1)
  marker,
  @HiveField(2)
  pencil,
  @HiveField(3)
  neon,
  @HiveField(4)
  watercolor,
  @HiveField(5)
  eraser,
}

@HiveType(typeId: 1)
class DrawingPoint {
  @HiveField(0)
  final double x;

  @HiveField(1)
  final double y;

  @HiveField(2)
  final int color;

  @HiveField(3)
  final double strokeWidth;

  @HiveField(4)
  final BrushType brushType;

  @HiveField(5)
  final double opacity;

  DrawingPoint({
    required this.x,
    required this.y,
    required this.color,
    required this.strokeWidth,
    required this.brushType,
    this.opacity = 1.0,
  });

  Map<String, dynamic> toJson() => {
    'x': x,
    'y': y,
    'color': color,
    'strokeWidth': strokeWidth,
    'brushType': brushType.index,
    'opacity': opacity,
  };

  factory DrawingPoint.fromJson(Map<String, dynamic> json) => DrawingPoint(
    x: json['x'],
    y: json['y'],
    color: json['color'],
    strokeWidth: json['strokeWidth'],
    brushType: BrushType.values[json['brushType']],
    opacity: json['opacity'] ?? 1.0,
  );
}

@HiveType(typeId: 2)
class Drawing {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  final DateTime modifiedAt;

  @HiveField(4)
  final List<List<DrawingPoint>> strokes;

  @HiveField(5)
  final String? thumbnailPath;

  @HiveField(6)
  final bool isColoringPage;

  @HiveField(7)
  final String? coloringPageId;

  Drawing({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.modifiedAt,
    required this.strokes,
    this.thumbnailPath,
    this.isColoringPage = false,
    this.coloringPageId,
  });

  Drawing copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? modifiedAt,
    List<List<DrawingPoint>>? strokes,
    String? thumbnailPath,
    bool? isColoringPage,
    String? coloringPageId,
  }) {
    return Drawing(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      strokes: strokes ?? this.strokes,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      isColoringPage: isColoringPage ?? this.isColoringPage,
      coloringPageId: coloringPageId ?? this.coloringPageId,
    );
  }
}
