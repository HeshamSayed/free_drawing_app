import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/settings_service.dart';
import '../services/database_service.dart';
import '../services/achievement_service.dart';
import 'achievements_screen.dart';
import 'daily_challenge_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // App Settings Section
          _buildSectionHeader('App Settings'),
          Consumer<SettingsService>(
            builder: (context, settingsService, _) {
              return SwitchListTile(
                title: const Text('Dark Mode'),
                subtitle: const Text('Toggle dark theme'),
                secondary: const Icon(Icons.dark_mode),
                value: settingsService.isDarkMode,
                onChanged: (value) {
                  settingsService.toggleDarkMode();
                },
              );
            },
          ),
          Consumer<SettingsService>(
            builder: (context, settingsService, _) {
              return SwitchListTile(
                title: const Text('Sound Effects'),
                subtitle: const Text('Enable/disable sounds'),
                secondary: const Icon(Icons.volume_up),
                value: settingsService.soundEnabled,
                onChanged: (value) {
                  settingsService.toggleSound();
                },
              );
            },
          ),

          const Divider(),

          // Premium Section
          _buildSectionHeader('Premium'),
          Consumer<SettingsService>(
            builder: (context, settingsService, _) {
              if (settingsService.isPremium) {
                return const ListTile(
                  leading: Icon(Icons.star, color: Colors.amber),
                  title: Text('Premium Active'),
                  subtitle: Text('Thank you for your support!'),
                );
              }

              return ListTile(
                leading: const Icon(Icons.star_outline),
                title: const Text('Upgrade to Premium'),
                subtitle: const Text('Remove ads & unlock all features'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _showPremiumDialog(context),
              );
            },
          ),

          const Divider(),

          // Statistics Section
          _buildSectionHeader('Statistics'),
          Consumer2<DatabaseService, SettingsService>(
            builder: (context, dbService, settingsService, _) {
              return Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.draw),
                    title: const Text('Total Drawings'),
                    trailing: Text(
                      '${dbService.getDrawingsCount()}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.sessions),
                    title: const Text('Sessions'),
                    trailing: Text(
                      '${settingsService.settings.sessionCount}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.brush),
                    title: const Text('Unlocked Brushes'),
                    trailing: Text(
                      '${settingsService.unlockedContent.unlockedBrushes.length}/6',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          const Divider(),

          // Features Section
          _buildSectionHeader('Features'),
          ListTile(
            leading: const Icon(Icons.emoji_events),
            title: const Text('Achievements'),
            subtitle: Consumer<AchievementService>(
              builder: (context, achievementService, _) {
                final unlocked = achievementService.unlockedCount;
                final total = achievementService.totalAchievements;
                return Text('$unlocked / $total unlocked');
              },
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AchievementsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.today),
            title: const Text('Daily Challenge'),
            subtitle: const Text('New challenge every day!'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DailyChallengeScreen()),
              );
            },
          ),

          const Divider(),

          // Data Management Section
          _buildSectionHeader('Data Management'),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text('Clear All Drawings'),
            subtitle: const Text('Delete all saved drawings'),
            onTap: () => _showClearDataDialog(context),
          ),

          const Divider(),

          // About Section
          _buildSectionHeader('About'),
          const ListTile(
            leading: Icon(Icons.info),
            title: Text('Version'),
            trailing: Text('1.0.0'),
          ),
          const ListTile(
            leading: Icon(Icons.palette),
            title: Text('ArtJoy'),
            subtitle: Text('Free Drawing & Coloring Game'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  void _showPremiumDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Go Premium! 🌟'),
          content: const SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Unlock the full ArtJoy experience:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                _PremiumFeature(
                  icon: Icons.block,
                  text: 'Remove all ads',
                ),
                _PremiumFeature(
                  icon: Icons.brush,
                  text: 'All brushes unlocked instantly',
                ),
                _PremiumFeature(
                  icon: Icons.palette,
                  text: 'Access to all coloring pages',
                ),
                _PremiumFeature(
                  icon: Icons.hd,
                  text: 'Export HD quality images',
                ),
                _PremiumFeature(
                  icon: Icons.support_agent,
                  text: 'Priority customer support',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Maybe Later'),
            ),
            ElevatedButton(
              onPressed: () {
                // In production, integrate with in-app purchases
                context.read<SettingsService>().setPremium(true);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Premium activated! (Demo Mode)'),
                  ),
                );
              },
              child: const Text('Upgrade Now'),
            ),
          ],
        );
      },
    );
  }

  void _showClearDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Clear All Drawings?'),
          content: const Text(
            'This will permanently delete all your drawings. This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await context.read<DatabaseService>().deleteAllDrawings();
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('All drawings deleted')),
                  );
                }
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete All'),
            ),
          ],
        );
      },
    );
  }
}

class _PremiumFeature extends StatelessWidget {
  final IconData icon;
  final String text;

  const _PremiumFeature({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
