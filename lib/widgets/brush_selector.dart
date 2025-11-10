import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/drawing.dart';
import '../services/settings_service.dart';
import '../services/ads_service.dart';

class BrushSelector extends StatelessWidget {
  final BrushType selectedBrush;
  final Function(BrushType) onBrushSelected;

  const BrushSelector({
    super.key,
    required this.selectedBrush,
    required this.onBrushSelected,
  });

  @override
  Widget build(BuildContext context) {
    final settingsService = context.watch<SettingsService>();
    final unlockedContent = settingsService.unlockedContent;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Select Brush',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: BrushType.values.map((brush) {
              final isUnlocked = unlockedContent.isBrushUnlocked(brush);
              final isSelected = selectedBrush == brush;

              return _BrushCard(
                brush: brush,
                isSelected: isSelected,
                isUnlocked: isUnlocked,
                onTap: () {
                  if (isUnlocked) {
                    onBrushSelected(brush);
                  } else {
                    _showUnlockDialog(context, brush);
                  }
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _showUnlockDialog(BuildContext context, BrushType brush) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Unlock ${_getBrushName(brush)}'),
          content: const Text('Watch a short video to unlock this brush!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                await _unlockBrush(context, brush);
              },
              child: const Text('Watch Ad'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _unlockBrush(BuildContext context, BrushType brush) async {
    final adsService = context.read<AdsService>();
    final settingsService = context.read<SettingsService>();

    final rewarded = await adsService.showRewardedAd();

    if (rewarded) {
      await settingsService.unlockBrush(brush);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${_getBrushName(brush)} unlocked!')),
      );
    }
  }

  String _getBrushName(BrushType brush) {
    switch (brush) {
      case BrushType.pen:
        return 'Pen';
      case BrushType.marker:
        return 'Marker';
      case BrushType.pencil:
        return 'Pencil';
      case BrushType.neon:
        return 'Neon';
      case BrushType.watercolor:
        return 'Watercolor';
      case BrushType.eraser:
        return 'Eraser';
    }
  }

  IconData _getBrushIcon(BrushType brush) {
    switch (brush) {
      case BrushType.pen:
        return Icons.create;
      case BrushType.marker:
        return Icons.edit;
      case BrushType.pencil:
        return Icons.brush;
      case BrushType.neon:
        return Icons.auto_awesome;
      case BrushType.watercolor:
        return Icons.water_drop;
      case BrushType.eraser:
        return Icons.backspace;
    }
  }
}

class _BrushCard extends StatelessWidget {
  final BrushType brush;
  final bool isSelected;
  final bool isUnlocked;
  final VoidCallback onTap;

  const _BrushCard({
    required this.brush,
    required this.isSelected,
    required this.isUnlocked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getBrushIcon(brush),
                    size: 40,
                    color: isUnlocked ? null : Colors.grey,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getBrushName(brush),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isUnlocked ? null : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            if (!isUnlocked)
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.lock, size: 16, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getBrushName(BrushType brush) {
    switch (brush) {
      case BrushType.pen:
        return 'Pen';
      case BrushType.marker:
        return 'Marker';
      case BrushType.pencil:
        return 'Pencil';
      case BrushType.neon:
        return 'Neon';
      case BrushType.watercolor:
        return 'Watercolor';
      case BrushType.eraser:
        return 'Eraser';
    }
  }

  IconData _getBrushIcon(BrushType brush) {
    switch (brush) {
      case BrushType.pen:
        return Icons.create;
      case BrushType.marker:
        return Icons.edit;
      case BrushType.pencil:
        return Icons.brush;
      case BrushType.neon:
        return Icons.auto_awesome;
      case BrushType.watercolor:
        return Icons.water_drop;
      case BrushType.eraser:
        return Icons.backspace;
    }
  }
}
