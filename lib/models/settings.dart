import 'package:hive/hive.dart';

part 'settings.g.dart';

@HiveType(typeId: 3)
class AppSettings {
  @HiveField(0)
  final bool isDarkMode;

  @HiveField(1)
  final bool soundEnabled;

  @HiveField(2)
  final double defaultBrushSize;

  @HiveField(3)
  final int defaultColor;

  @HiveField(4)
  final int sessionCount;

  @HiveField(5)
  final DateTime? lastInterstitialAdTime;

  @HiveField(6)
  final int drawingsCompleted;

  @HiveField(7)
  final bool isPremium;

  AppSettings({
    this.isDarkMode = false,
    this.soundEnabled = true,
    this.defaultBrushSize = 5.0,
    this.defaultColor = 0xFF000000,
    this.sessionCount = 0,
    this.lastInterstitialAdTime,
    this.drawingsCompleted = 0,
    this.isPremium = false,
  });

  AppSettings copyWith({
    bool? isDarkMode,
    bool? soundEnabled,
    double? defaultBrushSize,
    int? defaultColor,
    int? sessionCount,
    DateTime? lastInterstitialAdTime,
    int? drawingsCompleted,
    bool? isPremium,
  }) {
    return AppSettings(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      defaultBrushSize: defaultBrushSize ?? this.defaultBrushSize,
      defaultColor: defaultColor ?? this.defaultColor,
      sessionCount: sessionCount ?? this.sessionCount,
      lastInterstitialAdTime: lastInterstitialAdTime ?? this.lastInterstitialAdTime,
      drawingsCompleted: drawingsCompleted ?? this.drawingsCompleted,
      isPremium: isPremium ?? this.isPremium,
    );
  }
}
