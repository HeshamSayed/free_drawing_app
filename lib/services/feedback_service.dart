import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Service for handling user feedback and app ratings
class FeedbackService {
  static const String _ratingPromptKey = 'rating_prompt_shown';
  static const String _launchCountKey = 'app_launch_count';
  static const String _lastRatingPromptKey = 'last_rating_prompt';

  // Configuration
  static const int _launchesBeforePrompt = 5;
  static const int _daysBeforeReminder = 7;

  /// Check if we should show rating dialog
  static Future<bool> shouldShowRatingDialog() async {
    final prefs = await SharedPreferences.getInstance();

    // Get launch count
    final launchCount = prefs.getInt(_launchCountKey) ?? 0;

    // Check if already shown
    final hasShown = prefs.getBool(_ratingPromptKey) ?? false;

    // Get last prompt time
    final lastPromptTime = prefs.getString(_lastRatingPromptKey);

    // If never shown and enough launches
    if (!hasShown && launchCount >= _launchesBeforePrompt) {
      return true;
    }

    // If shown before, check if enough time has passed
    if (hasShown && lastPromptTime != null) {
      final lastPrompt = DateTime.parse(lastPromptTime);
      final daysSince = DateTime.now().difference(lastPrompt).inDays;

      if (daysSince >= _daysBeforeReminder) {
        return true;
      }
    }

    return false;
  }

  /// Increment launch count
  static Future<void> incrementLaunchCount() async {
    final prefs = await SharedPreferences.getInstance();
    final count = prefs.getInt(_launchCountKey) ?? 0;
    await prefs.setInt(_launchCountKey, count + 1);
  }

  /// Mark rating dialog as shown
  static Future<void> markRatingShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_ratingPromptKey, true);
    await prefs.setString(_lastRatingPromptKey, DateTime.now().toIso8601String());
  }

  /// Show rating dialog
  static Future<void> showRatingDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 32),
            SizedBox(width: 8),
            Text('Enjoying ArtJoy?'),
          ],
        ),
        content: const Text(
          'Your feedback helps us improve! Would you like to rate us on the store?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              markRatingShown();
              Navigator.pop(context);
            },
            child: const Text('Not Now'),
          ),
          TextButton(
            onPressed: () {
              markRatingShown();
              Navigator.pop(context);
              openStoreReview();
            },
            child: const Text('Rate Now'),
          ),
        ],
      ),
    );
  }

  /// Open store review page
  static Future<void> openStoreReview() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final packageName = packageInfo.packageName;

    // Android - Google Play Store
    final androidUrl = Uri.parse('market://details?id=$packageName');
    final androidFallback = Uri.parse(
      'https://play.google.com/store/apps/details?id=$packageName',
    );

    // iOS - App Store
    // Replace with your actual App Store ID
    final iosUrl = Uri.parse('itms-apps://apps.apple.com/app/idYOUR_APP_ID');
    final iosFallback = Uri.parse(
      'https://apps.apple.com/app/idYOUR_APP_ID',
    );

    try {
      // Try to launch the app store
      if (Theme.of(NavigationService.navigatorKey.currentContext!).platform ==
          TargetPlatform.android) {
        if (!await launchUrl(androidUrl)) {
          await launchUrl(androidFallback);
        }
      } else if (Theme.of(NavigationService.navigatorKey.currentContext!).platform ==
          TargetPlatform.iOS) {
        if (!await launchUrl(iosUrl)) {
          await launchUrl(iosFallback);
        }
      }
    } catch (e) {
      debugPrint('Error opening store: $e');
    }
  }

  /// Send feedback email
  static Future<void> sendFeedbackEmail() async {
    final packageInfo = await PackageInfo.fromPlatform();

    final emailUrl = Uri(
      scheme: 'mailto',
      path: 'support@artjoyapp.com',
      query: _encodeQueryParameters({
        'subject': 'ArtJoy Feedback',
        'body': '\n\n---\nApp Version: ${packageInfo.version}\nBuild: ${packageInfo.buildNumber}\n',
      }),
    );

    try {
      if (!await launchUrl(emailUrl)) {
        throw Exception('Could not launch email');
      }
    } catch (e) {
      debugPrint('Error launching email: $e');
    }
  }

  /// Open support page
  static Future<void> openSupportPage() async {
    final url = Uri.parse('https://artjoyapp.com/support');

    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch support page');
      }
    } catch (e) {
      debugPrint('Error opening support: $e');
    }
  }

  /// Share app with friends
  static Future<void> shareApp() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final packageName = packageInfo.packageName;

    final playStoreUrl = 'https://play.google.com/store/apps/details?id=$packageName';

    final shareText = 'Check out ArtJoy - the best drawing and coloring app! $playStoreUrl';

    // TODO: Use share_plus package
    debugPrint('Sharing: $shareText');
  }

  /// Show feedback dialog
  static Future<void> showFeedbackDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Send Feedback'),
        content: const Text(
          'How would you like to send feedback?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              sendFeedbackEmail();
            },
            child: const Text('Email'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openSupportPage();
            },
            child: const Text('Support Site'),
          ),
        ],
      ),
    );
  }

  /// Encode query parameters for URL
  static String _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}

/// Global navigation service for accessing context
class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
}
