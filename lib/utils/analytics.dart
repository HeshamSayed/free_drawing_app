import 'package:flutter/foundation.dart';

/// Analytics and event tracking utilities
///
/// This file provides a simple analytics interface.
/// In production, integrate with Firebase Analytics, Mixpanel, etc.

class Analytics {
  /// Logs an event (for debugging, replace with real analytics in production)
  static void logEvent(String eventName, {Map<String, dynamic>? parameters}) {
    if (kDebugMode) {
      debugPrint('📊 Event: $eventName ${parameters ?? ''}');
    }

    // TODO: In production, send to actual analytics service
    // Example: FirebaseAnalytics.instance.logEvent(name: eventName, parameters: parameters);
  }

  /// Logs a screen view
  static void logScreenView(String screenName) {
    logEvent('screen_view', parameters: {'screen_name': screenName});
  }

  /// Logs when a drawing is created
  static void logDrawingCreated({
    required String brushType,
    required int strokeCount,
    required int colorCount,
  }) {
    logEvent('drawing_created', parameters: {
      'brush_type': brushType,
      'stroke_count': strokeCount,
      'color_count': colorCount,
    });
  }

  /// Logs when a drawing is saved
  static void logDrawingSaved({
    required String drawingId,
    required int strokeCount,
    required bool isColoringPage,
  }) {
    logEvent('drawing_saved', parameters: {
      'drawing_id': drawingId,
      'stroke_count': strokeCount,
      'is_coloring_page': isColoringPage,
    });
  }

  /// Logs when a drawing is shared
  static void logDrawingShared(String method) {
    logEvent('drawing_shared', parameters: {'method': method});
  }

  /// Logs when an achievement is unlocked
  static void logAchievementUnlocked(String achievementId) {
    logEvent('achievement_unlocked', parameters: {'achievement_id': achievementId});
  }

  /// Logs when a daily challenge is completed
  static void logChallengeCompleted(String challengeId) {
    logEvent('challenge_completed', parameters: {'challenge_id': challengeId});
  }

  /// Logs when a coloring page is unlocked
  static void logColoringPageUnlocked({
    required String pageId,
    required String method, // 'ad' or 'premium'
  }) {
    logEvent('coloring_page_unlocked', parameters: {
      'page_id': pageId,
      'unlock_method': method,
    });
  }

  /// Logs when premium is activated
  static void logPremiumActivated(String method) {
    logEvent('premium_activated', parameters: {'method': method});
  }

  /// Logs ad impressions
  static void logAdImpression(String adType) {
    logEvent('ad_impression', parameters: {'ad_type': adType});
  }

  /// Logs ad clicks
  static void logAdClicked(String adType) {
    logEvent('ad_clicked', parameters: {'ad_type': adType});
  }

  /// Logs when a feature is used
  static void logFeatureUsed(String featureName) {
    logEvent('feature_used', parameters: {'feature': featureName});
  }

  /// Logs app crashes or errors
  static void logError(String error, {String? stackTrace}) {
    if (kDebugMode) {
      debugPrint('❌ Error: $error');
      if (stackTrace != null) {
        debugPrint('Stack trace: $stackTrace');
      }
    }

    // TODO: Send to crash reporting service
    // Example: FirebaseCrashlytics.instance.recordError(error, stackTrace);
  }

  /// Logs user properties (for segmentation)
  static void setUserProperty(String propertyName, String value) {
    if (kDebugMode) {
      debugPrint('👤 User property: $propertyName = $value');
    }

    // TODO: Set in analytics service
    // Example: FirebaseAnalytics.instance.setUserProperty(name: propertyName, value: value);
  }

  /// Sets user ID (if applicable)
  static void setUserId(String userId) {
    if (kDebugMode) {
      debugPrint('👤 User ID set: $userId');
    }

    // TODO: Set in analytics service
    // Example: FirebaseAnalytics.instance.setUserId(id: userId);
  }
}
