import 'package:flutter/material.dart';

/// Achievement model
class Achievement {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final int targetValue;
  final Color color;
  final bool isUnlocked;
  final int currentProgress;
  final DateTime? unlockedAt;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.targetValue,
    this.color = Colors.amber,
    this.isUnlocked = false,
    this.currentProgress = 0,
    this.unlockedAt,
  });

  Achievement copyWith({
    String? id,
    String? title,
    String? description,
    IconData? icon,
    int? targetValue,
    Color? color,
    bool? isUnlocked,
    int? currentProgress,
    DateTime? unlockedAt,
  }) {
    return Achievement(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      targetValue: targetValue ?? this.targetValue,
      color: color ?? this.color,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      currentProgress: currentProgress ?? this.currentProgress,
      unlockedAt: unlockedAt ?? this.unlockedAt,
    );
  }

  double get progressPercentage {
    if (targetValue == 0) return 0.0;
    return (currentProgress / targetValue).clamp(0.0, 1.0);
  }

  bool get isCompleted => currentProgress >= targetValue;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'targetValue': targetValue,
        'isUnlocked': isUnlocked,
        'currentProgress': currentProgress,
        'unlockedAt': unlockedAt?.toIso8601String(),
      };

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      icon: Icons.star,
      targetValue: json['targetValue'],
      isUnlocked: json['isUnlocked'] ?? false,
      currentProgress: json['currentProgress'] ?? 0,
      unlockedAt: json['unlockedAt'] != null
          ? DateTime.parse(json['unlockedAt'])
          : null,
    );
  }
}
