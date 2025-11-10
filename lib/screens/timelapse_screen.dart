import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/drawing.dart';
import '../services/timelapse_service.dart';
import '../widgets/drawing_canvas.dart';

/// Screen for playing back time-lapse of a drawing
class TimelapseScreen extends StatefulWidget {
  final Drawing drawing;

  const TimelapseScreen({
    super.key,
    required this.drawing,
  });

  @override
  State<TimelapseScreen> createState() => _TimelapseScreenState();
}

class _TimelapseScreenState extends State<TimelapseScreen>
    with SingleTickerProviderStateMixin {
  late TimelapseService _timelapseService;
  late AnimationController _controller;
  bool _isPlaying = false;
  double _playbackSpeed = 1.0;
  int _currentStrokeIndex = 0;

  @override
  void initState() {
    super.initState();
    _timelapseService = context.read<TimelapseService>();

    // Create animation controller
    final duration = _timelapseService.calculateDuration(widget.drawing);
    _controller = AnimationController(
      vsync: this,
      duration: duration,
    );

    _controller.addListener(() {
      if (mounted) {
        setState(() {
          _currentStrokeIndex = (_controller.value * widget.drawing.strokes.length).floor();
        });
      }
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _controller.stop();
      } else {
        if (_controller.isCompleted) {
          _controller.reset();
        }
        _controller.forward();
      }
      _isPlaying = !_isPlaying;
    });
  }

  void _restart() {
    _controller.reset();
    setState(() {
      _isPlaying = false;
      _currentStrokeIndex = 0;
    });
  }

  void _changeSpeed(double speed) {
    setState(() {
      _playbackSpeed = speed;
      final newDuration = _timelapseService.calculateDuration(widget.drawing);
      _controller.duration = Duration(
        milliseconds: (newDuration.inMilliseconds / speed).round(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get strokes up to current index
    final displayStrokes = _currentStrokeIndex == 0
        ? <List<DrawingPoint>>[]
        : widget.drawing.strokes.sublist(0, _currentStrokeIndex);

    return Scaffold(
      appBar: AppBar(
        title: Text('Time-lapse: ${widget.drawing.name}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showInfo,
            tooltip: 'Info',
          ),
        ],
      ),
      body: Column(
        children: [
          // Canvas displaying the replay
          Expanded(
            child: Container(
              color: Colors.white,
              child: DrawingCanvas(
                strokes: displayStrokes,
                currentStroke: null,
                onPanStart: null,
                onPanUpdate: null,
                onPanEnd: null,
              ),
            ),
          ),

          // Progress bar
          _buildProgressBar(),

          // Controls
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                _formatDuration(
                  Duration(
                    milliseconds:
                        (_controller.value * _controller.duration!.inMilliseconds)
                            .round(),
                  ),
                ),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Expanded(
                child: Slider(
                  value: _controller.value,
                  onChanged: (value) {
                    _controller.value = value;
                  },
                ),
              ),
              Text(
                _formatDuration(_controller.duration ?? Duration.zero),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          Text(
            'Stroke $_currentStrokeIndex / ${widget.drawing.strokes.length}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Playback speed selector
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Speed:'),
              const SizedBox(width: 8),
              ...[0.5, 1.0, 2.0, 4.0].map((speed) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text('${speed}x'),
                    selected: _playbackSpeed == speed,
                    onSelected: (selected) {
                      if (selected) _changeSpeed(speed);
                    },
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 16),

          // Play controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Restart button
              IconButton.filled(
                onPressed: _restart,
                icon: const Icon(Icons.replay),
                tooltip: 'Restart',
              ),
              const SizedBox(width: 16),

              // Play/Pause button
              IconButton.filled(
                onPressed: _togglePlayPause,
                iconSize: 32,
                icon: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                ),
                tooltip: _isPlaying ? 'Pause' : 'Play',
              ),
              const SizedBox(width: 16),

              // Export button
              IconButton.filled(
                onPressed: _exportTimelapse,
                icon: const Icon(Icons.video_library),
                tooltip: 'Export Video',
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Time-lapse Info'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Drawing', widget.drawing.name),
            _buildInfoRow('Total Strokes', '${widget.drawing.strokes.length}'),
            _buildInfoRow(
              'Created',
              '${widget.drawing.createdAt.toLocal()}'.split('.')[0],
            ),
            _buildInfoRow(
              'Duration',
              _formatDuration(_controller.duration ?? Duration.zero),
            ),
            _buildInfoRow('Playback Speed', '${_playbackSpeed}x'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  void _exportTimelapse() {
    // In production, this would export to video
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Time-lapse'),
        content: const Text(
          'Time-lapse video export is coming soon!\n\n'
          'This feature will allow you to:\n'
          '• Export as MP4 video\n'
          '• Choose video quality\n'
          '• Add background music\n'
          '• Share on social media',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
