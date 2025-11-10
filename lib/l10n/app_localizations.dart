import 'package:flutter/material.dart';

/// Localization strings for ArtJoy
/// This class provides all user-facing strings in the app
///
/// Usage:
/// ```dart
/// final l10n = AppLocalizations.of(context);
/// Text(l10n.appName);
/// ```
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // App Name
  String get appName => 'ArtJoy';
  String get appTagline => 'Free Drawing & Coloring';

  // Home Screen
  String get welcomeTitle => '🎨 Welcome to ArtJoy!';
  String get welcomeSubtitle => 'Unleash your creativity with amazing drawing tools!';
  String get drawingsCreated => 'drawings created';
  String get quickActions => 'Quick Actions';
  String get recentDrawings => 'Recent Drawings';
  String get noDrawingsYet => 'No drawings yet!';
  String get startCreating => 'Start creating your first masterpiece';

  // Actions
  String get freeDraw => 'Free Draw';
  String get coloring => 'Coloring';
  String get gallery => 'Gallery';
  String get achievements => 'Achievements';
  String get dailyChallenge => 'Daily Challenge';
  String get premium => 'Premium';
  String get settings => 'Settings';

  // Drawing Screen
  String get brushSize => 'Brush Size';
  String get color => 'Color';
  String get undo => 'Undo';
  String get redo => 'Redo';
  String get clear => 'Clear';
  String get save => 'Save';
  String get share => 'Share';
  String get export => 'Export';

  // Brush Types
  String get pen => 'Pen';
  String get marker => 'Marker';
  String get pencil => 'Pencil';
  String get neon => 'Neon';
  String get watercolor => 'Watercolor';
  String get eraser => 'Eraser';

  // Coloring Screen
  String get coloringPages => 'Coloring Pages';
  String get unlockPage => 'Unlock Page';
  String get watchAdToUnlock => 'Watch a short video ad to unlock this coloring page!';
  String get pageUnlocked => 'unlocked!';

  // Gallery Screen
  String get searchDrawings => 'Search drawings...';
  String get deleteDrawing => 'Delete Drawing';
  String get confirmDelete => 'Are you sure you want to delete this drawing? This action cannot be undone.';
  String get delete => 'Delete';
  String get cancel => 'Cancel';

  // Achievements
  String get achievementsTitle => 'Achievements';
  String get unlocked => 'unlocked';
  String get achievementUnlocked => 'Achievement Unlocked!';

  // Daily Challenge
  String get dailyChallengeTitle => 'Daily Challenge';
  String get challengeOfTheDay => 'Challenge of the Day';
  String get completedToday => 'Already completed today!';
  String get startChallenge => 'Start Challenge';

  // Settings
  String get settingsTitle => 'Settings';
  String get appSettings => 'App Settings';
  String get darkMode => 'Dark Mode';
  String get toggleDarkTheme => 'Toggle dark theme';
  String get soundEffects => 'Sound Effects';
  String get enableDisableSounds => 'Enable/disable sounds';
  String get premiumSection => 'Premium';
  String get premiumActive => 'Premium Active';
  String get thankYouForSupport => 'Thank you for your support!';
  String get upgradeToPremium => 'Upgrade to Premium';
  String get removeAdsUnlockFeatures => 'Remove ads & unlock all features';
  String get statistics => 'Statistics';
  String get totalDrawings => 'Total Drawings';
  String get sessions => 'Sessions';
  String get unlockedBrushes => 'Unlocked Brushes';
  String get features => 'Features';
  String get dataManagement => 'Data Management';
  String get clearAllDrawings => 'Clear All Drawings';
  String get deleteAllSaved => 'Delete all saved drawings';
  String get about => 'About';
  String get version => 'Version';

  // Premium Dialog
  String get goPremium => 'Go Premium! 🌟';
  String get unlockFullExperience => 'Unlock the full ArtJoy experience:';
  String get removeAllAds => 'Remove all ads';
  String get allBrushesUnlocked => 'All brushes unlocked instantly';
  String get allColoringPages => 'Access to all coloring pages';
  String get hdExports => 'Export HD quality images';
  String get prioritySupport => 'Priority customer support';
  String get maybeLater => 'Maybe Later';
  String get upgradeNow => 'Upgrade Now';
  String get premiumActivated => 'Premium activated! (Demo Mode)';

  // Clear Data Dialog
  String get clearAllQuestion => 'Clear All Drawings?';
  String get permanentDeleteWarning =>
      'This will permanently delete all your drawings. This action cannot be undone.';
  String get deleteAll => 'Delete All';
  String get allDrawingsDeleted => 'All drawings deleted';

  // Save Drawing Dialog
  String get saveDrawing => 'Save Drawing';
  String get enterName => 'Enter a name for your drawing';
  String get drawingName => 'Drawing Name';
  String get pleaseEnterName => 'Please enter a name for your drawing';

  // Export Options
  String get exportAsPNG => 'Export as PNG';
  String get saveToGallery => 'Save to Gallery';
  String get shareDrawing => 'Share Drawing';
  String get exportSuccess => 'Successfully exported!';
  String get exportFailed => 'Export failed';
  String get savedToGallery => 'Saved to gallery!';
  String get shareFailed => 'Sharing failed';

  // Onboarding
  String get skip => 'Skip';
  String get next => 'Next';
  String get getStarted => 'Get Started';
  String get onboarding1Title => 'Welcome to ArtJoy! 🎨';
  String get onboarding1Desc =>
      'Unleash your creativity with amazing drawing and coloring tools!';
  String get onboarding2Title => 'Draw Freely';
  String get onboarding2Desc =>
      'Choose from 6 brush types and unlimited colors to create your masterpiece.';
  String get onboarding3Title => 'Colorful Creations';
  String get onboarding3Desc =>
      'Pick any color you like or create custom colors with our advanced picker.';
  String get onboarding4Title => 'Fun Coloring Pages';
  String get onboarding4Desc =>
      'Enjoy coloring beautiful pre-drawn images with your favorite colors.';
  String get onboarding5Title => 'Save & Share';
  String get onboarding5Desc =>
      'Save your artwork and share it with friends and family!';

  // Time-lapse
  String get timelapse => 'Time-lapse';
  String get playbackSpeed => 'Speed';
  String get stroke => 'Stroke';
  String get restart => 'Restart';
  String get play => 'Play';
  String get pause => 'Pause';
  String get exportVideo => 'Export Video';

  // Errors
  String get error => 'Error';
  String get somethingWentWrong => 'Something went wrong';
  String get tryAgain => 'Try again';
  String get loadingFailed => 'Failed to load';
  String get permissionDenied => 'Permission denied';
  String get noInternetConnection => 'No internet connection';

  // Success Messages
  String get success => 'Success';
  String get saved => 'Saved';
  String get deleted => 'Deleted';
  String get completed => 'Completed';

  // Common
  String get ok => 'OK';
  String get yes => 'Yes';
  String get no => 'No';
  String get done => 'Done';
  String get close => 'Close';
  String get confirm => 'Confirm';
  String get loading => 'Loading...';
  String get pleaseWait => 'Please wait...';
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Currently only English, but can be expanded
    return ['en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
