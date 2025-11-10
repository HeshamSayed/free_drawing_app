import 'package:flutter/material.dart';

/// App-wide constants
class AppConstants {
  // App Information
  static const String appName = 'ArtJoy';
  static const String appFullName = 'ArtJoy – Free Drawing & Coloring Game';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Unleash your creativity with amazing drawing tools!';

  // AdMob IDs
  static const String admobAppId = 'ca-app-pub-6976864649919972~8450614936';

  // Drawing Defaults
  static const double defaultBrushSize = 5.0;
  static const double minBrushSize = 1.0;
  static const double maxBrushSize = 50.0;
  static const double defaultOpacity = 1.0;
  static const Color defaultColor = Colors.black;

  // Canvas
  static const double minScale = 0.5;
  static const double maxScale = 3.0;
  static const Color canvasBackgroundColor = Colors.white;

  // Ad Frequency
  static const int interstitialFrequencySession = 4; // Every 4 sessions
  static const int interstitialCooldownMinutes = 10; // 10 minutes between ads

  // Hive Box Names
  static const String drawingsBoxName = 'drawings';
  static const String settingsBoxName = 'settings';
  static const String unlockedContentBoxName = 'unlocked_content';
  static const String achievementsBoxName = 'achievements';

  // Gallery
  static const int recentDrawingsLimit = 10;
  static const int galleryGridColumns = 2;

  // Achievements
  static const int achievementFirstDrawing = 1;
  static const int achievementDrawings10 = 10;
  static const int achievementDrawings50 = 50;
  static const int achievementDrawings100 = 100;
  static const int achievementColors5 = 5;
  static const int achievementColors10 = 10;
  static const int achievementAllBrushes = 6;

  // Coloring Pages
  static const int freeColoringPages = 3;
  static const int totalColoringPages = 8;

  // Premium
  static const String premiumSku = 'artjoy_premium';
  static const double premiumPrice = 2.99;

  // Support
  static const String supportEmail = 'support@artjoy.app';
  static const String privacyPolicyUrl = 'https://artjoy.app/privacy';
  static const String termsOfServiceUrl = 'https://artjoy.app/terms';
  static const String websiteUrl = 'https://artjoy.app';

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // Timeouts
  static const Duration saveDebounceDuration = Duration(seconds: 2);
  static const Duration searchDebounceDuration = Duration(milliseconds: 500);
}

/// App Colors (matching theme.dart)
class AppColors {
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color secondaryColor = Color(0xFFFF6584);
  static const Color accentColor = Color(0xFFFFC947);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFE74C3C);
  static const Color warningColor = Color(0xFFF39C12);
  static const Color infoColor = Color(0xFF3498DB);

  // Brush Colors Palette
  static const List<Color> brushPalette = [
    Colors.black,
    Colors.white,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
  ];

  // Background Colors
  static const Color lightBackground = Color(0xFFF5F7FA);
  static const Color darkBackground = Color(0xFF1A1A2E);
  static const Color lightCard = Colors.white;
  static const Color darkCard = Color(0xFF16213E);
}

/// App Text Strings
class AppStrings {
  // Home Screen
  static const String welcomeTitle = '🎨 Welcome to ArtJoy!';
  static const String welcomeSubtitle = 'Unleash your creativity with amazing drawing tools!';
  static const String quickActions = 'Quick Actions';
  static const String recentDrawings = 'Recent Drawings';
  static const String noDrawingsYet = 'No drawings yet!';
  static const String startCreating = 'Start creating your first masterpiece';
  static const String drawingsCreated = 'drawings created';

  // Actions
  static const String freeDraw = 'Free Draw';
  static const String coloring = 'Coloring';
  static const String gallery = 'Gallery';
  static const String premium = 'Premium';
  static const String settings = 'Settings';

  // Drawing Screen
  static const String draw = 'Draw';
  static const String save = 'Save';
  static const String clear = 'Clear';
  static const String undo = 'Undo';
  static const String redo = 'Redo';
  static const String brush = 'Brush';
  static const String color = 'Color';
  static const String opacity = 'Opacity';
  static const String size = 'Size';

  // Dialogs
  static const String clearCanvas = 'Clear Canvas';
  static const String clearCanvasMessage = 'Are you sure you want to clear the canvas? This cannot be undone.';
  static const String saveDrawing = 'Save Drawing';
  static const String drawingName = 'Drawing Name';
  static const String myDrawing = 'My Drawing';
  static const String cancel = 'Cancel';
  static const String confirm = 'Confirm';
  static const String delete = 'Delete';
  static const String share = 'Share';

  // Success Messages
  static const String drawingSaved = 'Drawing saved!';
  static const String drawingDeleted = 'Drawing deleted';
  static const String achievementUnlocked = 'Achievement unlocked!';
  static const String brushUnlocked = 'Brush unlocked!';
  static const String pageUnlocked = 'Page unlocked!';

  // Error Messages
  static const String nothingToSave = 'Nothing to save!';
  static const String errorSaving = 'Error saving drawing';
  static const String errorLoading = 'Error loading drawing';
  static const String errorDeleting = 'Error deleting drawing';

  // Premium
  static const String goPremium = 'Go Premium! 🌟';
  static const String premiumFeatures = 'Unlock all features:\n\n'
      '✅ Remove all ads\n'
      '✅ All brushes unlocked\n'
      '✅ All coloring pages\n'
      '✅ Priority support';
  static const String upgradNow = 'Upgrade Now';
  static const String maybeLater = 'Maybe Later';

  // Achievements
  static const String firstDrawingAchievement = 'First Masterpiece';
  static const String firstDrawingDesc = 'Create your first drawing';
  static const String drawings10Achievement = 'Creative Explorer';
  static const String drawings10Desc = 'Create 10 drawings';
  static const String drawings50Achievement = 'Art Enthusiast';
  static const String drawings50Desc = 'Create 50 drawings';
  static const String drawings100Achievement = 'Master Artist';
  static const String drawings100Desc = 'Create 100 drawings';
  static const String colors5Achievement = 'Color Explorer';
  static const String colors5Desc = 'Use 5 different colors';
  static const String colors10Achievement = 'Rainbow Master';
  static const String colors10Desc = 'Use 10 different colors';
  static const String allBrushesAchievement = 'Brush Collector';
  static const String allBrushesDesc = 'Unlock all brush types';
}

/// Achievement IDs
class AchievementIds {
  static const String firstDrawing = 'first_drawing';
  static const String drawings10 = 'drawings_10';
  static const String drawings50 = 'drawings_50';
  static const String drawings100 = 'drawings_100';
  static const String colors5 = 'colors_5';
  static const String colors10 = 'colors_10';
  static const String allBrushes = 'all_brushes';
}
