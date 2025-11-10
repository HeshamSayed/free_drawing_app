import 'package:flutter/material.dart';
import '../models/drawing.dart';

class DrawingController extends ChangeNotifier {
  List<List<DrawingPoint>> _strokes = [];
  List<DrawingPoint> _currentStroke = [];
  List<List<List<DrawingPoint>>> _undoStack = [];

  // Drawing properties
  Color _selectedColor = Colors.black;
  double _strokeWidth = 5.0;
  double _opacity = 1.0;
  BrushType _selectedBrush = BrushType.pen;

  // Canvas properties
  double _scale = 1.0;
  Offset _offset = Offset.zero;
  final double _minScale = 0.5;
  final double _maxScale = 3.0;

  // Getters
  List<List<DrawingPoint>> get strokes => _strokes;
  List<DrawingPoint> get currentStroke => _currentStroke;
  Color get selectedColor => _selectedColor;
  double get strokeWidth => _strokeWidth;
  double get opacity => _opacity;
  BrushType get selectedBrush => _selectedBrush;
  double get scale => _scale;
  Offset get offset => _offset;

  bool get canUndo => _undoStack.isNotEmpty;
  bool get hasDrawing => _strokes.isNotEmpty;

  // Start a new stroke
  void startStroke(Offset position) {
    _currentStroke = [
      DrawingPoint(
        x: (position.dx - _offset.dx) / _scale,
        y: (position.dy - _offset.dy) / _scale,
        color: _selectedColor.value,
        strokeWidth: _strokeWidth,
        brushType: _selectedBrush,
        opacity: _opacity,
      ),
    ];
    notifyListeners();
  }

  // Add point to current stroke
  void addPoint(Offset position) {
    if (_currentStroke.isEmpty) return;

    _currentStroke.add(
      DrawingPoint(
        x: (position.dx - _offset.dx) / _scale,
        y: (position.dy - _offset.dy) / _scale,
        color: _selectedColor.value,
        strokeWidth: _strokeWidth,
        brushType: _selectedBrush,
        opacity: _opacity,
      ),
    );
    notifyListeners();
  }

  // End current stroke
  void endStroke() {
    if (_currentStroke.isNotEmpty) {
      _undoStack.add(List.from(_strokes));
      _strokes.add(List.from(_currentStroke));
      _currentStroke = [];
      notifyListeners();
    }
  }

  // Undo last stroke
  void undo() {
    if (_undoStack.isNotEmpty) {
      _strokes = _undoStack.removeLast();
      notifyListeners();
    }
  }

  // Clear canvas
  void clear() {
    _undoStack.add(List.from(_strokes));
    _strokes = [];
    _currentStroke = [];
    notifyListeners();
  }

  // Load drawing
  void loadDrawing(Drawing drawing) {
    _strokes = List.from(drawing.strokes);
    _currentStroke = [];
    _undoStack = [];
    notifyListeners();
  }

  // Set color
  void setColor(Color color) {
    _selectedColor = color;
    notifyListeners();
  }

  // Set stroke width
  void setStrokeWidth(double width) {
    _strokeWidth = width;
    notifyListeners();
  }

  // Set opacity
  void setOpacity(double opacity) {
    _opacity = opacity;
    notifyListeners();
  }

  // Set brush type
  void setBrush(BrushType brush) {
    _selectedBrush = brush;
    notifyListeners();
  }

  // Zoom and pan
  void updateScale(double newScale) {
    _scale = newScale.clamp(_minScale, _maxScale);
    notifyListeners();
  }

  void updateOffset(Offset newOffset) {
    _offset = newOffset;
    notifyListeners();
  }

  void resetTransform() {
    _scale = 1.0;
    _offset = Offset.zero;
    notifyListeners();
  }

  // Get drawing for saving
  Drawing toDrawing({String? id, String? name}) {
    return Drawing(
      id: id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: name ?? 'Drawing ${DateTime.now()}',
      createdAt: DateTime.now(),
      modifiedAt: DateTime.now(),
      strokes: List.from(_strokes),
    );
  }
}
