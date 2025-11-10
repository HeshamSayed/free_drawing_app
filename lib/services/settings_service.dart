import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/settings.dart';
import '../models/unlocked_content.dart';

class SettingsService extends ChangeNotifier {
  static const String _settingsBoxName = 'settings';
  static const String _unlockedContentBoxName = 'unlocked_content';
  static const String _settingsKey = 'app_settings';
  static const String _unlockedContentKey = 'unlocked_content';

  Box<AppSettings>? _settingsBox;
  Box<UnlockedContent>? _unlockedBox;
  AppSettings? _settings;
  UnlockedContent? _unlockedContent;

  AppSettings get settings => _settings ?? AppSettings();
  UnlockedContent get unlockedContent => _unlockedContent ?? UnlockedContent();

  bool get isDarkMode => settings.isDarkMode;
  bool get soundEnabled => settings.soundEnabled;
  bool get isPremium => settings.isPremium;

  Future<void> initialize() async {
    _settingsBox = await Hive.openBox<AppSettings>(_settingsBoxName);
    _unlockedBox = await Hive.openBox<UnlockedContent>(_unlockedContentBoxName);

    _settings = _settingsBox?.get(_settingsKey) ?? AppSettings();
    _unlockedContent = _unlockedBox?.get(_unlockedContentKey) ?? UnlockedContent();

    // Save initial values if not exist
    if (_settingsBox?.get(_settingsKey) == null) {
      await _saveSettings(_settings!);
    }
    if (_unlockedBox?.get(_unlockedContentKey) == null) {
      await _saveUnlockedContent(_unlockedContent!);
    }

    notifyListeners();
  }

  Future<void> _saveSettings(AppSettings settings) async {
    await _settingsBox?.put(_settingsKey, settings);
    _settings = settings;
    notifyListeners();
  }

  Future<void> _saveUnlockedContent(UnlockedContent content) async {
    await _unlockedBox?.put(_unlockedContentKey, content);
    _unlockedContent = content;
    notifyListeners();
  }

  // Toggle dark mode
  Future<void> toggleDarkMode() async {
    final newSettings = settings.copyWith(isDarkMode: !settings.isDarkMode);
    await _saveSettings(newSettings);
  }

  // Toggle sound
  Future<void> toggleSound() async {
    final newSettings = settings.copyWith(soundEnabled: !settings.soundEnabled);
    await _saveSettings(newSettings);
  }

  // Set premium status
  Future<void> setPremium(bool isPremium) async {
    final newSettings = settings.copyWith(isPremium: isPremium);
    await _saveSettings(newSettings);
  }

  // Update session count
  Future<void> incrementSessionCount() async {
    final newSettings = settings.copyWith(sessionCount: settings.sessionCount + 1);
    await _saveSettings(newSettings);
  }

  // Update last interstitial ad time
  Future<void> updateLastInterstitialAdTime() async {
    final newSettings = settings.copyWith(lastInterstitialAdTime: DateTime.now());
    await _saveSettings(newSettings);
  }

  // Increment drawings completed
  Future<void> incrementDrawingsCompleted() async {
    final newSettings = settings.copyWith(drawingsCompleted: settings.drawingsCompleted + 1);
    await _saveSettings(newSettings);
  }

  // Unlock brush
  Future<void> unlockBrush(BrushType brush) async {
    if (!unlockedContent.isBrushUnlocked(brush)) {
      final newBrushes = List<BrushType>.from(unlockedContent.unlockedBrushes)..add(brush);
      final newContent = unlockedContent.copyWith(unlockedBrushes: newBrushes);
      await _saveUnlockedContent(newContent);
    }
  }

  // Unlock coloring page
  Future<void> unlockColoringPage(String pageId) async {
    if (!unlockedContent.isColoringPageUnlocked(pageId)) {
      final newPages = List<String>.from(unlockedContent.unlockedColoringPages)..add(pageId);
      final newContent = unlockedContent.copyWith(unlockedColoringPages: newPages);
      await _saveUnlockedContent(newContent);
    }
  }

  // Update achievement
  Future<void> unlockAchievement(String achievementId) async {
    if (unlockedContent.achievements[achievementId] != true) {
      final newAchievements = Map<String, bool>.from(unlockedContent.achievements);
      newAchievements[achievementId] = true;
      final newContent = unlockedContent.copyWith(achievements: newAchievements);
      await _saveUnlockedContent(newContent);
    }
  }

  // Increment total drawings
  Future<void> incrementTotalDrawings() async {
    final newContent = unlockedContent.copyWith(
      totalDrawings: unlockedContent.totalDrawings + 1,
    );
    await _saveUnlockedContent(newContent);
  }
}
