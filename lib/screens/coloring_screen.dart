import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/settings_service.dart';
import '../services/ads_service.dart';
import 'drawing_screen.dart';

class ColoringScreen extends StatefulWidget {
  const ColoringScreen({super.key});

  @override
  State<ColoringScreen> createState() => _ColoringScreenState();
}

class _ColoringScreenState extends State<ColoringScreen> {
  // Predefined coloring pages (all SVG files in assets/coloring_pages/)
  final List<ColoringPage> _coloringPages = [
    // Free pages (unlocked by default)
    ColoringPage(
      id: 'cat',
      name: 'Cute Cat',
      description: 'A friendly cat waiting for colors',
      isLocked: false,
      icon: Icons.pets,
    ),
    ColoringPage(
      id: 'flower',
      name: 'Beautiful Flower',
      description: 'A lovely flower garden',
      isLocked: false,
      icon: Icons.local_florist,
    ),
    ColoringPage(
      id: 'car',
      name: 'Racing Car',
      description: 'A super fast race car',
      isLocked: false,
      icon: Icons.directions_car,
    ),
    // Premium pages (unlock with ads or premium)
    ColoringPage(
      id: 'house',
      name: 'Dream House',
      description: 'A cozy little house',
      isLocked: true,
      icon: Icons.house,
    ),
    ColoringPage(
      id: 'tree',
      name: 'Big Tree',
      description: 'A tall tree with many branches',
      isLocked: true,
      icon: Icons.park,
    ),
    ColoringPage(
      id: 'sun',
      name: 'Happy Sun',
      description: 'A smiling sun in the sky',
      isLocked: true,
      icon: Icons.wb_sunny,
    ),
    ColoringPage(
      id: 'butterfly',
      name: 'Beautiful Butterfly',
      description: 'A colorful butterfly',
      isLocked: true,
      icon: Icons.flutter_dash,
    ),
    ColoringPage(
      id: 'rocket',
      name: 'Space Rocket',
      description: 'A rocket flying to the stars',
      isLocked: true,
      icon: Icons.rocket_launch,
    ),
    ColoringPage(
      id: 'fish',
      name: 'Happy Fish',
      description: 'A fish swimming in the ocean',
      isLocked: true,
      icon: Icons.phishing,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final settingsService = context.watch<SettingsService>();
    final unlockedContent = settingsService.unlockedContent;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Coloring Pages'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: _coloringPages.length,
        itemBuilder: (context, index) {
          final page = _coloringPages[index];
          final isUnlocked = !page.isLocked ||
              unlockedContent.isColoringPageUnlocked(page.id) ||
              settingsService.isPremium;

          return _ColoringPageCard(
            page: page,
            isUnlocked: isUnlocked,
            onTap: () {
              if (isUnlocked) {
                _openColoringPage(page);
              } else {
                _showUnlockDialog(page);
              }
            },
          );
        },
      ),
    );
  }

  void _openColoringPage(ColoringPage page) {
    // In production, this would load the actual coloring page template
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const DrawingScreen(),
      ),
    );
  }

  void _showUnlockDialog(ColoringPage page) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Unlock ${page.name}'),
          content: const Text(
            'Watch a short video ad to unlock this coloring page!',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                Navigator.pop(context);
                await _unlockPage(page);
              },
              icon: const Icon(Icons.play_circle),
              label: const Text('Watch Ad'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _unlockPage(ColoringPage page) async {
    final adsService = context.read<AdsService>();
    final settingsService = context.read<SettingsService>();

    final rewarded = await adsService.showRewardedAd();

    if (rewarded) {
      await settingsService.unlockColoringPage(page.id);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${page.name} unlocked!')),
      );
    } else {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please watch the full ad to unlock')),
      );
    }
  }
}

class ColoringPage {
  final String id;
  final String name;
  final String description;
  final bool isLocked;
  final IconData icon;

  ColoringPage({
    required this.id,
    required this.name,
    required this.description,
    required this.isLocked,
    required this.icon,
  });
}

class _ColoringPageCard extends StatelessWidget {
  final ColoringPage page;
  final bool isUnlocked;
  final VoidCallback onTap;

  const _ColoringPageCard({
    required this.page,
    required this.isUnlocked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Preview Image
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.shade100,
                          Colors.purple.shade100,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        page.icon,
                        size: 64,
                        color: isUnlocked ? Colors.black54 : Colors.grey,
                      ),
                    ),
                  ),
                ),

                // Page Info
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        page.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isUnlocked ? null : Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        page.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: isUnlocked
                              ? Colors.grey.shade600
                              : Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Lock Icon
            if (!isUnlocked)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.lock,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
