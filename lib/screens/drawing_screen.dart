import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:uuid/uuid.dart';
import '../models/drawing.dart';
import '../services/database_service.dart';
import '../services/audio_service.dart';
import '../services/settings_service.dart';
import '../utils/drawing_controller.dart';
import '../widgets/drawing_canvas.dart';
import '../widgets/color_picker_widget.dart';
import '../widgets/brush_selector.dart';

class DrawingScreen extends StatefulWidget {
  final Drawing? existingDrawing;

  const DrawingScreen({super.key, this.existingDrawing});

  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  late DrawingController _controller;
  final ScreenshotController _screenshotController = ScreenshotController();
  bool _showTools = true;

  @override
  void initState() {
    super.initState();
    _controller = DrawingController();

    if (widget.existingDrawing != null) {
      _controller.loadDrawing(widget.existingDrawing!);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _controller,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: const Text('Draw'),
          actions: [
            Consumer<DrawingController>(
              builder: (context, controller, _) {
                return IconButton(
                  icon: const Icon(Icons.undo),
                  onPressed: controller.canUndo ? () => controller.undo() : null,
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: _showClearDialog,
            ),
            IconButton(
              icon: Icon(_showTools ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() => _showTools = !_showTools);
              },
            ),
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveDrawing,
            ),
          ],
        ),
        body: Stack(
          children: [
            // Drawing Canvas
            _buildCanvas(),

            // Tools Panel
            if (_showTools) _buildToolsPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildCanvas() {
    return Center(
      child: Consumer<DrawingController>(
        builder: (context, controller, _) {
          return GestureDetector(
            onPanStart: (details) {
              final audioService = context.read<AudioService>();
              final settingsService = context.read<SettingsService>();

              controller.startStroke(details.localPosition);

              if (settingsService.soundEnabled) {
                audioService.playBrushStroke();
              }
            },
            onPanUpdate: (details) {
              controller.addPoint(details.localPosition);
            },
            onPanEnd: (details) {
              controller.endStroke();
            },
            child: Screenshot(
              controller: _screenshotController,
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: DrawingCanvas(
                    strokes: controller.strokes,
                    currentStroke: controller.currentStroke,
                    canvasSize: Size(
                      MediaQuery.of(context).size.width - 32,
                      MediaQuery.of(context).size.height - 200,
                    ),
                    scale: controller.scale,
                    offset: controller.offset,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildToolsPanel() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Brush Size Slider
            Consumer<DrawingController>(
              builder: (context, controller, _) {
                return Row(
                  children: [
                    const Icon(Icons.brush, size: 16),
                    Expanded(
                      child: Slider(
                        value: controller.strokeWidth,
                        min: 1,
                        max: 50,
                        divisions: 49,
                        label: controller.strokeWidth.round().toString(),
                        onChanged: (value) => controller.setStrokeWidth(value),
                      ),
                    ),
                    const Icon(Icons.brush, size: 32),
                  ],
                );
              },
            ),

            const SizedBox(height: 8),

            // Brush Selector and Color Picker
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Brush Type Selector
                Consumer<DrawingController>(
                  builder: (context, controller, _) {
                    return IconButton(
                      icon: const Icon(Icons.brush),
                      iconSize: 32,
                      onPressed: () => _showBrushSelector(context),
                    );
                  },
                ),

                // Color Indicator
                Consumer<DrawingController>(
                  builder: (context, controller, _) {
                    return GestureDetector(
                      onTap: () => _showColorPicker(context),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: controller.selectedColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: controller.selectedColor.withOpacity(0.5),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // Opacity Slider
                Consumer<DrawingController>(
                  builder: (context, controller, _) {
                    return Row(
                      children: [
                        const Icon(Icons.opacity, size: 20),
                        SizedBox(
                          width: 100,
                          child: Slider(
                            value: controller.opacity,
                            min: 0.1,
                            max: 1.0,
                            onChanged: (value) => controller.setOpacity(value),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showColorPicker(BuildContext context) {
    final controller = context.read<DrawingController>();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ColorPickerWidget(
          selectedColor: controller.selectedColor,
          onColorChanged: (color) => controller.setColor(color),
        );
      },
    );
  }

  void _showBrushSelector(BuildContext context) {
    final controller = context.read<DrawingController>();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BrushSelector(
          selectedBrush: controller.selectedBrush,
          onBrushSelected: (brush) {
            controller.setBrush(brush);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _showClearDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Clear Canvas'),
          content: const Text('Are you sure you want to clear the canvas? This cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _controller.clear();
                Navigator.pop(context);
              },
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveDrawing() async {
    if (!_controller.hasDrawing) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nothing to save!')),
      );
      return;
    }

    final name = await _showNameDialog();
    if (name == null) return;

    final drawing = _controller.toDrawing(
      id: widget.existingDrawing?.id ?? const Uuid().v4(),
      name: name,
    );

    final dbService = context.read<DatabaseService>();
    final settingsService = context.read<SettingsService>();
    final audioService = context.read<AudioService>();

    await dbService.saveDrawing(drawing);
    await settingsService.incrementTotalDrawings();

    if (settingsService.soundEnabled) {
      await audioService.playSuccess();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Drawing saved!')),
    );

    Navigator.pop(context);
  }

  Future<String?> _showNameDialog() async {
    final controller = TextEditingController(
      text: widget.existingDrawing?.name ?? 'My Drawing',
    );

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Save Drawing'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Drawing Name',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
