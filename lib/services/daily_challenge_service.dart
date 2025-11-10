import 'package:flutter/material.dart';
import 'dart:math';

/// Daily challenge service
class DailyChallengeService extends ChangeNotifier {
  DailyChallenge? _currentChallenge;
  DateTime? _lastChallengeDate;
  bool _isChallengeCompleted = false;

  DailyChallenge? get currentChallenge => _currentChallenge;
  bool get hasChallengeToday => _isChallengeToday();
  bool get isChallengeCompleted => _isChallengeCompleted;

  DailyChallengeService() {
    _generateDailyChallenge();
  }

  /// Check if challenge is for today
  bool _isChallengeToday() {
    if (_lastChallengeDate == null) return false;
    final now = DateTime.now();
    return _lastChallengeDate!.year == now.year &&
        _lastChallengeDate!.month == now.month &&
        _lastChallengeDate!.day == now.day;
  }

  /// Generate daily challenge
  void _generateDailyChallenge() {
    final now = DateTime.now();

    // Check if we already have today's challenge
    if (_isChallengeToday()) return;

    // Generate new challenge
    final seed = now.year * 10000 + now.month * 100 + now.day;
    final random = Random(seed);
    final challengeIndex = random.nextInt(DailyChallenges.challenges.length);

    _currentChallenge = DailyChallenges.challenges[challengeIndex];
    _lastChallengeDate = now;
    _isChallengeCompleted = false;
    notifyListeners();
  }

  /// Complete challenge
  void completeChallenge() {
    if (_isChallengeToday()) {
      _isChallengeCompleted = true;
      notifyListeners();
    }
  }

  /// Reset challenge (for testing)
  void resetChallenge() {
    _lastChallengeDate = null;
    _isChallengeCompleted = false;
    _generateDailyChallenge();
  }

  /// Check if challenge requirements are met
  bool checkChallengeProgress(Map<String, dynamic> drawingData) {
    if (_currentChallenge == null) return false;

    switch (_currentChallenge!.type) {
      case ChallengeType.drawSubject:
        // Manual completion (user decides)
        return false;

      case ChallengeType.useColors:
        final colorsUsed = drawingData['colorsUsed'] as int? ?? 0;
        return colorsUsed >= _currentChallenge!.targetValue;

      case ChallengeType.drawStrokes:
        final strokeCount = drawingData['strokeCount'] as int? ?? 0;
        return strokeCount >= _currentChallenge!.targetValue;

      case ChallengeType.useBrush:
        final brushUsed = drawingData['brushUsed'] as String? ?? '';
        return brushUsed == _currentChallenge!.requirement;
    }
  }
}

/// Daily challenge model
class DailyChallenge {
  final String title;
  final String description;
  final IconData icon;
  final ChallengeType type;
  final int targetValue;
  final String? requirement;
  final int reward;

  DailyChallenge({
    required this.title,
    required this.description,
    required this.icon,
    required this.type,
    this.targetValue = 1,
    this.requirement,
    this.reward = 10,
  });
}

/// Challenge types
enum ChallengeType {
  drawSubject, // Draw specific subject
  useColors, // Use X colors
  drawStrokes, // Draw X strokes
  useBrush, // Use specific brush
}

/// Predefined daily challenges
class DailyChallenges {
  static final List<DailyChallenge> challenges = [
    DailyChallenge(
      title: 'Draw a Cat',
      description: 'Create a drawing of a cat!',
      icon: Icons.pets,
      type: ChallengeType.drawSubject,
    ),
    DailyChallenge(
      title: 'Draw a Tree',
      description: 'Create a beautiful tree drawing!',
      icon: Icons.park,
      type: ChallengeType.drawSubject,
    ),
    DailyChallenge(
      title: 'Draw a House',
      description: 'Design your dream house!',
      icon: Icons.house,
      type: ChallengeType.drawSubject,
    ),
    DailyChallenge(
      title: 'Rainbow Creation',
      description: 'Use at least 5 different colors!',
      icon: Icons.color_lens,
      type: ChallengeType.useColors,
      targetValue: 5,
    ),
    DailyChallenge(
      title: 'Color Maestro',
      description: 'Use 10 or more colors in one drawing!',
      icon: Icons.palette,
      type: ChallengeType.useColors,
      targetValue: 10,
    ),
    DailyChallenge(
      title: 'Detailed Artist',
      description: 'Create a drawing with 50+ strokes!',
      icon: Icons.draw,
      type: ChallengeType.drawStrokes,
      targetValue: 50,
    ),
    DailyChallenge(
      title: 'Neon Night',
      description: 'Create something using the neon brush!',
      icon: Icons.auto_awesome,
      type: ChallengeType.useBrush,
      requirement: 'neon',
    ),
    DailyChallenge(
      title: 'Watercolor Wonder',
      description: 'Paint with the watercolor brush!',
      icon: Icons.water_drop,
      type: ChallengeType.useBrush,
      requirement: 'watercolor',
    ),
    DailyChallenge(
      title: 'Draw a Flower',
      description: 'Create a beautiful flower!',
      icon: Icons.local_florist,
      type: ChallengeType.drawSubject,
    ),
    DailyChallenge(
      title: 'Draw a Sun',
      description: 'Draw a bright, happy sun!',
      icon: Icons.wb_sunny,
      type: ChallengeType.drawSubject,
    ),
    DailyChallenge(
      title: 'Draw a Star',
      description: 'Create a shining star!',
      icon: Icons.star,
      type: ChallengeType.drawSubject,
    ),
    DailyChallenge(
      title: 'Draw a Heart',
      description: 'Spread love with a heart drawing!',
      icon: Icons.favorite,
      type: ChallengeType.drawSubject,
    ),
  ];
}
