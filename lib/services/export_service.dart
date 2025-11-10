import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import '../models/drawing.dart';

class ExportService {
  /// Export drawing as PNG image
  Future<File?> exportDrawingAsPNG({
    required GlobalKey canvasKey,
    required String fileName,
    double pixelRatio = 3.0,
  }) async {
    try {
      // Get the render boundary
      RenderRepaintBoundary? boundary =
          canvasKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

      if (boundary == null) {
        throw Exception('Cannot find render boundary');
      }

      // Convert to image
      ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        throw Exception('Failed to convert image to bytes');
      }

      // Save to temp directory
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/$fileName.png';
      final file = File(filePath);
      await file.writeAsBytes(byteData.buffer.asUint8List());

      return file;
    } catch (e) {
      debugPrint('Error exporting PNG: $e');
      return null;
    }
  }

  /// Save drawing to device gallery
  Future<bool> saveToGallery({
    required GlobalKey canvasKey,
    required String fileName,
  }) async {
    try {
      // Request permission
      if (Platform.isAndroid) {
        final status = await Permission.storage.request();
        if (!status.isGranted) {
          // For Android 13+, use photos permission
          final photosStatus = await Permission.photos.request();
          if (!photosStatus.isGranted) {
            return false;
          }
        }
      } else if (Platform.isIOS) {
        final status = await Permission.photos.request();
        if (!status.isGranted) {
          return false;
        }
      }

      // Export image
      final file = await exportDrawingAsPNG(canvasKey: canvasKey, fileName: fileName);
      if (file == null) return false;

      // Save to gallery
      final result = await ImageGallerySaver.saveFile(
        file.path,
        name: fileName,
      );

      return result['isSuccess'] == true;
    } catch (e) {
      debugPrint('Error saving to gallery: $e');
      return false;
    }
  }

  /// Share drawing
  Future<bool> shareDrawing({
    required GlobalKey canvasKey,
    required String fileName,
    String? text,
  }) async {
    try {
      // Export image
      final file = await exportDrawingAsPNG(canvasKey: canvasKey, fileName: fileName);
      if (file == null) return false;

      // Share
      await Share.shareXFiles(
        [XFile(file.path)],
        text: text ?? 'Check out my drawing created with ArtJoy!',
      );

      return true;
    } catch (e) {
      debugPrint('Error sharing drawing: $e');
      return false;
    }
  }

  /// Generate thumbnail for drawing
  Future<File?> generateThumbnail({
    required GlobalKey canvasKey,
    required String fileName,
    double pixelRatio = 1.0,
  }) async {
    return await exportDrawingAsPNG(
      canvasKey: canvasKey,
      fileName: '${fileName}_thumb',
      pixelRatio: pixelRatio,
    );
  }

  /// Export drawing data as JSON
  Map<String, dynamic> exportDrawingAsJSON(Drawing drawing) {
    return {
      'id': drawing.id,
      'name': drawing.name,
      'createdAt': drawing.createdAt.toIso8601String(),
      'modifiedAt': drawing.modifiedAt.toIso8601String(),
      'strokes': drawing.strokes.map((stroke) {
        return stroke.map((point) => point.toJson()).toList();
      }).toList(),
      'isColoringPage': drawing.isColoringPage,
      'coloringPageId': drawing.coloringPageId,
    };
  }

  /// Import drawing from JSON
  Drawing importDrawingFromJSON(Map<String, dynamic> json) {
    return Drawing(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      modifiedAt: DateTime.parse(json['modifiedAt']),
      strokes: (json['strokes'] as List).map((stroke) {
        return (stroke as List).map((point) {
          return DrawingPoint.fromJson(point as Map<String, dynamic>);
        }).toList();
      }).toList(),
      isColoringPage: json['isColoringPage'] ?? false,
      coloringPageId: json['coloringPageId'],
    );
  }
}
