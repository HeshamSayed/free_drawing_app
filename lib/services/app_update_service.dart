import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

/// Service to check for app updates
/// Compares current version with latest version from server/store
class AppUpdateService {
  static const String _lastCheckKey = 'last_update_check';
  static const String _skipVersionKey = 'skip_version';

  // Check for updates every 24 hours
  static const Duration _checkInterval = Duration(hours: 24);

  /// Check if app update is available
  static Future<AppUpdateInfo?> checkForUpdate() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Check if we've checked recently
      final lastCheck = prefs.getString(_lastCheckKey);
      if (lastCheck != null) {
        final lastCheckTime = DateTime.parse(lastCheck);
        if (DateTime.now().difference(lastCheckTime) < _checkInterval) {
          debugPrint('Update check skipped - checked recently');
          return null;
        }
      }

      // Get current version
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;
      final buildNumber = int.parse(packageInfo.buildNumber);

      // Get latest version from your server
      // Replace with your actual API endpoint
      final latestInfo = await _fetchLatestVersion();

      if (latestInfo == null) return null;

      // Save last check time
      await prefs.setString(_lastCheckKey, DateTime.now().toIso8601String());

      // Compare versions
      if (_isNewerVersion(latestInfo.version, currentVersion) ||
          latestInfo.buildNumber > buildNumber) {
        // Check if user has chosen to skip this version
        final skippedVersion = prefs.getString(_skipVersionKey);
        if (skippedVersion == latestInfo.version) {
          return null;
        }

        return latestInfo;
      }

      return null;
    } catch (e) {
      debugPrint('Error checking for update: $e');
      return null;
    }
  }

  /// Fetch latest version info from server
  static Future<AppUpdateInfo?> _fetchLatestVersion() async {
    try {
      // TODO: Replace with your actual API endpoint
      // Example: https://api.artjoyapp.com/version
      final url = Uri.parse('https://api.artjoyapp.com/version');

      final response = await http.get(url).timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        return AppUpdateInfo(
          version: data['version'],
          buildNumber: data['buildNumber'],
          releaseNotes: data['releaseNotes'] ?? '',
          isForceUpdate: data['forceUpdate'] ?? false,
          downloadUrl: data['downloadUrl'] ?? '',
        );
      }

      return null;
    } catch (e) {
      debugPrint('Error fetching version: $e');

      // Fallback: Try to get info from store metadata
      return _fetchStoreVersion();
    }
  }

  /// Fetch version from app store metadata (fallback)
  static Future<AppUpdateInfo?> _fetchStoreVersion() async {
    // This would require store-specific API calls
    // For Google Play: https://play.google.com/store/apps/details?id=...
    // For App Store: iTunes API

    // Simplified implementation
    return null;
  }

  /// Compare version strings
  static bool _isNewerVersion(String latest, String current) {
    final latestParts = latest.split('.').map(int.parse).toList();
    final currentParts = current.split('.').map(int.parse).toList();

    for (int i = 0; i < latestParts.length && i < currentParts.length; i++) {
      if (latestParts[i] > currentParts[i]) {
        return true;
      } else if (latestParts[i] < currentParts[i]) {
        return false;
      }
    }

    return latestParts.length > currentParts.length;
  }

  /// Show update dialog
  static Future<void> showUpdateDialog(
    BuildContext context,
    AppUpdateInfo updateInfo,
  ) async {
    return showDialog(
      context: context,
      barrierDismissible: !updateInfo.isForceUpdate,
      builder: (context) => WillPopScope(
        onWillPop: () async => !updateInfo.isForceUpdate,
        child: AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.system_update, color: Colors.blue),
              const SizedBox(width: 8),
              Text(updateInfo.isForceUpdate
                  ? 'Update Required'
                  : 'Update Available'),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Version ${updateInfo.version} is now available!'),
                if (updateInfo.releaseNotes.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  const Text(
                    'What\'s New:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(updateInfo.releaseNotes),
                ],
              ],
            ),
          ),
          actions: [
            if (!updateInfo.isForceUpdate)
              TextButton(
                onPressed: () async {
                  // Skip this version
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(_skipVersionKey, updateInfo.version);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: const Text('Skip'),
              ),
            if (!updateInfo.isForceUpdate)
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Later'),
              ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                openStore();
              },
              child: const Text('Update Now'),
            ),
          ],
        ),
      ),
    );
  }

  /// Open app store for update
  static Future<void> openStore() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final packageName = packageInfo.packageName;

    Uri url;

    if (Platform.isAndroid) {
      url = Uri.parse('market://details?id=$packageName');
      try {
        if (!await launchUrl(url)) {
          // Fallback to web version
          url = Uri.parse(
            'https://play.google.com/store/apps/details?id=$packageName',
          );
          await launchUrl(url, mode: LaunchMode.externalApplication);
        }
      } catch (e) {
        debugPrint('Error opening store: $e');
      }
    } else if (Platform.isIOS) {
      // Replace with your actual App Store ID
      url = Uri.parse('itms-apps://apps.apple.com/app/idYOUR_APP_ID');
      try {
        if (!await launchUrl(url)) {
          // Fallback to web version
          url = Uri.parse('https://apps.apple.com/app/idYOUR_APP_ID');
          await launchUrl(url, mode: LaunchMode.externalApplication);
        }
      } catch (e) {
        debugPrint('Error opening store: $e');
      }
    }
  }

  /// Reset update check (for testing)
  static Future<void> resetUpdateCheck() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_lastCheckKey);
    await prefs.remove(_skipVersionKey);
  }
}

/// Model for app update information
class AppUpdateInfo {
  final String version;
  final int buildNumber;
  final String releaseNotes;
  final bool isForceUpdate;
  final String downloadUrl;

  AppUpdateInfo({
    required this.version,
    required this.buildNumber,
    required this.releaseNotes,
    required this.isForceUpdate,
    required this.downloadUrl,
  });
}
