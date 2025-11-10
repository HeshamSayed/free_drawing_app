import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/achievement_service.dart';
import '../models/achievement.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
      ),
      body: Consumer<AchievementService>(
        builder: (context, achievementService, _) {
          final achievements = achievementService.achievements;
          final unlockedCount = achievementService.unlockedCount;
          final totalCount = achievementService.totalAchievements;

          return Column(
            children: [
              // Progress Card
              Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Your Progress',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$unlockedCount / $totalCount',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      LinearProgressIndicator(
                        value: unlockedCount / totalCount,
                        minHeight: 10,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${((unlockedCount / totalCount) * 100).toStringAsFixed(0)}% Complete',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Achievements List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: achievements.length,
                  itemBuilder: (context, index) {
                    final achievement = achievements[index];
                    return _AchievementCard(achievement: achievement);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final Achievement achievement;

  const _AchievementCard({required this.achievement});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: achievement.isUnlocked
                ? achievement.color.withOpacity(0.2)
                : Colors.grey.shade200,
            shape: BoxShape.circle,
          ),
          child: Icon(
            achievement.icon,
            size: 32,
            color: achievement.isUnlocked ? achievement.color : Colors.grey,
          ),
        ),
        title: Text(
          achievement.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: achievement.isUnlocked ? null : Colors.grey,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              achievement.description,
              style: TextStyle(
                color: achievement.isUnlocked
                    ? Colors.grey.shade600
                    : Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 12),
            // Progress bar
            LinearProgressIndicator(
              value: achievement.progressPercentage,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation(
                achievement.isUnlocked ? achievement.color : Colors.grey,
              ),
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
            const SizedBox(height: 4),
            Text(
              achievement.isUnlocked
                  ? 'Unlocked!'
                  : '${achievement.currentProgress} / ${achievement.targetValue}',
              style: TextStyle(
                fontSize: 12,
                color: achievement.isUnlocked
                    ? achievement.color
                    : Colors.grey.shade600,
                fontWeight: achievement.isUnlocked ? FontWeight.bold : null,
              ),
            ),
          ],
        ),
        trailing: achievement.isUnlocked
            ? Icon(
                Icons.check_circle,
                color: achievement.color,
                size: 32,
              )
            : Icon(
                Icons.lock_outline,
                color: Colors.grey.shade400,
                size: 32,
              ),
      ),
    );
  }
}
