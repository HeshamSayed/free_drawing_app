import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../models/achievement.dart';

class AchievementDialog extends StatelessWidget {
  final Achievement achievement;

  const AchievementDialog({
    super.key,
    required this.achievement,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              achievement.color.withOpacity(0.1),
              achievement.color.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Achievement Icon
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: achievement.color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                achievement.icon,
                size: 60,
                color: achievement.color,
              ),
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              'Achievement Unlocked!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: achievement.color,
              ),
            ),
            const SizedBox(height: 12),

            // Achievement Name
            Text(
              achievement.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Description
            Text(
              achievement.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Close Button
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: achievement.color,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
              child: const Text(
                'Awesome!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Show achievement dialog
  static void show(BuildContext context, Achievement achievement) {
    showDialog(
      context: context,
      builder: (context) => AchievementDialog(achievement: achievement),
    );
  }
}
