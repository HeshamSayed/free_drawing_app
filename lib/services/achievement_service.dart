import 'package:flutter/material.dart';
import '../models/achievement.dart';
import '../utils/constants.dart';

class AchievementService extends ChangeNotifier {
  final List<Achievement> _achievements = [];

  List<Achievement> get achievements => _achievements;
  List<Achievement> get unlockedAchievements =>
      _achievements.where((a) => a.isUnlocked).toList();
  int get totalAchievements => _achievements.length;
  int get unlockedCount => unlockedAchievements.length;

  AchievementService() {
    _initializeAchievements();
  }

  void _initializeAchievements() {
    _achievements.addAll([
      Achievement(
        id: AchievementIds.firstDrawing,
        title: AppStrings.firstDrawingAchievement,
        description: AppStrings.firstDrawingDesc,
        icon: Icons.draw,
        targetValue: AppConstants.achievementFirstDrawing,
        color: Colors.blue,
      ),
      Achievement(
        id: AchievementIds.drawings10,
        title: AppStrings.drawings10Achievement,
        description: AppStrings.drawings10Desc,
        icon: Icons.palette,
        targetValue: AppConstants.achievementDrawings10,
        color: Colors.purple,
      ),
      Achievement(
        id: AchievementIds.drawings50,
        title: AppStrings.drawings50Achievement,
        description: AppStrings.drawings50Desc,
        icon: Icons.art_track,
        targetValue: AppConstants.achievementDrawings50,
        color: Colors.orange,
      ),
      Achievement(
        id: AchievementIds.drawings100,
        title: AppStrings.drawings100Achievement,
        description: AppStrings.drawings100Desc,
        icon: Icons.emoji_events,
        targetValue: AppConstants.achievementDrawings100,
        color: Colors.amber,
      ),
      Achievement(
        id: AchievementIds.colors5,
        title: AppStrings.colors5Achievement,
        description: AppStrings.colors5Desc,
        icon: Icons.color_lens,
        targetValue: AppConstants.achievementColors5,
        color: Colors.pink,
      ),
      Achievement(
        id: AchievementIds.colors10,
        title: AppStrings.colors10Achievement,
        description: AppStrings.colors10Desc,
        icon: Icons.gradient,
        targetValue: AppConstants.achievementColors10,
        color: Colors.red,
      ),
      Achievement(
        id: AchievementIds.allBrushes,
        title: AppStrings.allBrushesAchievement,
        description: AppStrings.allBrushesDesc,
        icon: Icons.brush,
        targetValue: AppConstants.achievementAllBrushes,
        color: Colors.green,
      ),
    ]);
  }

  /// Update achievement progress
  Achievement? updateProgress(String achievementId, int progress) {
    final index = _achievements.indexWhere((a) => a.id == achievementId);
    if (index == -1) return null;

    final achievement = _achievements[index];
    if (achievement.isUnlocked) return null;

    final updatedAchievement = achievement.copyWith(
      currentProgress: progress,
      isUnlocked: progress >= achievement.targetValue,
      unlockedAt: progress >= achievement.targetValue ? DateTime.now() : null,
    );

    _achievements[index] = updatedAchievement;
    notifyListeners();

    return updatedAchievement.isUnlocked ? updatedAchievement : null;
  }

  /// Increment achievement progress
  Achievement? incrementProgress(String achievementId, {int amount = 1}) {
    final achievement = _achievements.firstWhere((a) => a.id == achievementId);
    return updateProgress(achievementId, achievement.currentProgress + amount);
  }

  /// Check if achievement is unlocked
  bool isUnlocked(String achievementId) {
    return _achievements
        .firstWhere((a) => a.id == achievementId, orElse: () => _achievements.first)
        .isUnlocked;
  }

  /// Get achievement by ID
  Achievement? getAchievement(String achievementId) {
    try {
      return _achievements.firstWhere((a) => a.id == achievementId);
    } catch (e) {
      return null;
    }
  }

  /// Check and unlock drawing-related achievements
  List<Achievement> checkDrawingAchievements(int totalDrawings) {
    final unlockedAchievements = <Achievement>[];

    // First drawing
    final firstDrawing = updateProgress(AchievementIds.firstDrawing, totalDrawings);
    if (firstDrawing != null) unlockedAchievements.add(firstDrawing);

    // 10 drawings
    final drawings10 = updateProgress(AchievementIds.drawings10, totalDrawings);
    if (drawings10 != null) unlockedAchievements.add(drawings10);

    // 50 drawings
    final drawings50 = updateProgress(AchievementIds.drawings50, totalDrawings);
    if (drawings50 != null) unlockedAchievements.add(drawings50);

    // 100 drawings
    final drawings100 = updateProgress(AchievementIds.drawings100, totalDrawings);
    if (drawings100 != null) unlockedAchievements.add(drawings100);

    return unlockedAchievements;
  }

  /// Check and unlock color-related achievements
  List<Achievement> checkColorAchievements(int uniqueColors) {
    final unlockedAchievements = <Achievement>[];

    // 5 colors
    final colors5 = updateProgress(AchievementIds.colors5, uniqueColors);
    if (colors5 != null) unlockedAchievements.add(colors5);

    // 10 colors
    final colors10 = updateProgress(AchievementIds.colors10, uniqueColors);
    if (colors10 != null) unlockedAchievements.add(colors10);

    return unlockedAchievements;
  }

  /// Check and unlock brush-related achievements
  Achievement? checkBrushAchievements(int unlockedBrushes) {
    return updateProgress(AchievementIds.allBrushes, unlockedBrushes);
  }
}
