import 'package:flutter/material.dart';
import '../models/drawing.dart';

/// Service for recording and playing time-lapse of drawings
class TimelapseService {
  final List<TimelapseFrame> _frames = [];
  bool _isRecording = false;
  DateTime? _recordingStartTime;

  bool get isRecording => _isRecording;
  int get frameCount => _frames.length;
  Duration get totalDuration {
    if (_frames.isEmpty) return Duration.zero;
    return _frames.last.timestamp;
  }

  /// Start recording time-lapse
  void startRecording() {
    _frames.clear();
    _isRecording = true;
    _recordingStartTime = DateTime.now();
  }

  /// Stop recording time-lapse
  void stopRecording() {
    _isRecording = false;
    _recordingStartTime = null;
  }

  /// Record a frame (stroke addition)
  void recordFrame(List<DrawingPoint> stroke) {
    if (!_isRecording || _recordingStartTime == null) return;

    final timestamp = DateTime.now().difference(_recordingStartTime!);
    _frames.add(TimelapseFrame(
      timestamp: timestamp,
      stroke: List.from(stroke),
      action: TimelapseAction.addStroke,
    ));
  }

  /// Record undo action
  void recordUndo() {
    if (!_isRecording || _recordingStartTime == null) return;

    final timestamp = DateTime.now().difference(_recordingStartTime!);
    _frames.add(TimelapseFrame(
      timestamp: timestamp,
      stroke: [],
      action: TimelapseAction.undo,
    ));
  }

  /// Record clear action
  void recordClear() {
    if (!_isRecording || _recordingStartTime == null) return;

    final timestamp = DateTime.now().difference(_recordingStartTime!);
    _frames.add(TimelapseFrame(
      timestamp: timestamp,
      stroke: [],
      action: TimelapseAction.clear,
    ));
  }

  /// Get frames for playback
  List<TimelapseFrame> getFrames() {
    return List.from(_frames);
  }

  /// Clear recorded frames
  void clear() {
    _frames.clear();
    _isRecording = false;
    _recordingStartTime = null;
  }

  /// Export time-lapse data
  Map<String, dynamic> export() {
    return {
      'totalDuration': totalDuration.inMilliseconds,
      'frameCount': frameCount,
      'frames': _frames.map((f) => f.toJson()).toList(),
    };
  }

  /// Import time-lapse data
  void import(Map<String, dynamic> data) {
    _frames.clear();
    final framesData = data['frames'] as List;
    for (final frameData in framesData) {
      _frames.add(TimelapseFrame.fromJson(frameData));
    }
  }
}

/// Time-lapse frame
class TimelapseFrame {
  final Duration timestamp;
  final List<DrawingPoint> stroke;
  final TimelapseAction action;

  TimelapseFrame({
    required this.timestamp,
    required this.stroke,
    required this.action,
  });

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp.inMilliseconds,
        'stroke': stroke.map((p) => p.toJson()).toList(),
        'action': action.index,
      };

  factory TimelapseFrame.fromJson(Map<String, dynamic> json) {
    return TimelapseFrame(
      timestamp: Duration(milliseconds: json['timestamp']),
      stroke: (json['stroke'] as List)
          .map((p) => DrawingPoint.fromJson(p))
          .toList(),
      action: TimelapseAction.values[json['action']],
    );
  }
}

/// Time-lapse actions
enum TimelapseAction {
  addStroke,
  undo,
  clear,
}

/// Time-lapse player widget
class TimelapsePlayer extends StatefulWidget {
  final List<TimelapseFrame> frames;
  final VoidCallback? onComplete;

  const TimelapsePlayer({
    super.key,
    required this.frames,
    this.onComplete,
  });

  @override
  State<TimelapsePlayer> createState() => _TimelapsePlayerState();
}

class _TimelapsePlayerState extends State<TimelapsePlayer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _currentFrame = 0;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    final totalDuration = widget.frames.isEmpty
        ? Duration.zero
        : widget.frames.last.timestamp;

    _controller = AnimationController(
      vsync: this,
      duration: totalDuration,
    );

    _controller.addListener(() {
      final currentTime =
          Duration(milliseconds: (_controller.value * totalDuration.inMilliseconds).toInt());

      // Find current frame
      for (int i = _currentFrame; i < widget.frames.length; i++) {
        if (widget.frames[i].timestamp <= currentTime) {
          setState(() => _currentFrame = i);
        } else {
          break;
        }
      }
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _isPlaying = false);
        widget.onComplete?.call();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _controller.forward();
      } else {
        _controller.stop();
      }
    });
  }

  void _restart() {
    _controller.reset();
    setState(() {
      _currentFrame = 0;
      _isPlaying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Player controls
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: _restart,
              tooltip: 'Restart',
            ),
            IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: _playPause,
              iconSize: 48,
              tooltip: _isPlaying ? 'Pause' : 'Play',
            ),
          ],
        ),

        // Progress bar
        Slider(
          value: _controller.value,
          onChanged: (value) {
            _controller.value = value;
          },
        ),

        // Frame info
        Text(
          'Frame ${_currentFrame + 1} / ${widget.frames.length}',
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
