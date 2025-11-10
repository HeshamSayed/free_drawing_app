import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/drawing.dart';

class DatabaseService extends ChangeNotifier {
  static const String _drawingsBoxName = 'drawings';
  Box<Drawing>? _drawingsBox;

  Future<void> initialize() async {
    _drawingsBox = await Hive.openBox<Drawing>(_drawingsBoxName);
    notifyListeners();
  }

  // Get all drawings
  List<Drawing> getAllDrawings() {
    return _drawingsBox?.values.toList() ?? [];
  }

  // Get drawing by ID
  Drawing? getDrawing(String id) {
    return _drawingsBox?.get(id);
  }

  // Save or update drawing
  Future<void> saveDrawing(Drawing drawing) async {
    await _drawingsBox?.put(drawing.id, drawing);
    notifyListeners();
  }

  // Delete drawing
  Future<void> deleteDrawing(String id) async {
    await _drawingsBox?.delete(id);
    notifyListeners();
  }

  // Delete all drawings
  Future<void> deleteAllDrawings() async {
    await _drawingsBox?.clear();
    notifyListeners();
  }

  // Get drawings count
  int getDrawingsCount() {
    return _drawingsBox?.length ?? 0;
  }

  // Get recent drawings
  List<Drawing> getRecentDrawings({int limit = 10}) {
    final drawings = getAllDrawings();
    drawings.sort((a, b) => b.modifiedAt.compareTo(a.modifiedAt));
    return drawings.take(limit).toList();
  }

  // Search drawings by name
  List<Drawing> searchDrawings(String query) {
    final drawings = getAllDrawings();
    return drawings.where((drawing) {
      return drawing.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
