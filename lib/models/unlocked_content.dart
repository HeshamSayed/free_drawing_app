import 'package:hive/hive.dart';
import 'drawing.dart';

part 'unlocked_content.g.dart';

@HiveType(typeId: 4)
class UnlockedContent {
  @HiveField(0)
  final List<BrushType> unlockedBrushes;

  @HiveField(1)
  final List<String> unlockedColoringPages;

  @HiveField(2)
  final Map<String, bool> achievements;

  @HiveField(3)
  final int totalDrawings;

  @HiveField(4)
  final int totalColors;

  UnlockedContent({
    List<BrushType>? unlockedBrushes,
    List<String>? unlockedColoringPages,
    Map<String, bool>? achievements,
    this.totalDrawings = 0,
    this.totalColors = 0,
  }) : unlockedBrushes = unlockedBrushes ?? [BrushType.pen, BrushType.pencil, BrushType.eraser],
       unlockedColoringPages = unlockedColoringPages ?? [],
       achievements = achievements ?? {};

  UnlockedContent copyWith({
    List<BrushType>? unlockedBrushes,
    List<String>? unlockedColoringPages,
    Map<String, bool>? achievements,
    int? totalDrawings,
    int? totalColors,
  }) {
    return UnlockedContent(
      unlockedBrushes: unlockedBrushes ?? this.unlockedBrushes,
      unlockedColoringPages: unlockedColoringPages ?? this.unlockedColoringPages,
      achievements: achievements ?? this.achievements,
      totalDrawings: totalDrawings ?? this.totalDrawings,
      totalColors: totalColors ?? this.totalColors,
    );
  }

  bool isBrushUnlocked(BrushType brush) {
    return unlockedBrushes.contains(brush);
  }

  bool isColoringPageUnlocked(String pageId) {
    return unlockedColoringPages.contains(pageId);
  }
}
