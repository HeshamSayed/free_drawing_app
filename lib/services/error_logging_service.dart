import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../utils/analytics.dart';

/// Comprehensive error logging and crash reporting service
/// In production, integrate with Firebase Crashlytics, Sentry, or similar
class ErrorLoggingService {
  static final ErrorLoggingService _instance = ErrorLoggingService._internal();
  factory ErrorLoggingService() => _instance;
  ErrorLoggingService._internal();

  bool _initialized = false;

  /// Initialize error logging
  Future<void> initialize() async {
    if (_initialized) return;

    // Setup Flutter error handler
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      logFlutterError(details);
    };

    // Setup platform error handler (for non-Flutter errors)
    PlatformDispatcher.instance.onError = (error, stack) {
      logError(error, stackTrace: stack);
      return true;
    };

    _initialized = true;
    debugPrint('✅ Error logging initialized');
  }

  /// Log a Flutter framework error
  void logFlutterError(FlutterErrorDetails details) {
    if (kDebugMode) {
      debugPrint('🔴 Flutter Error:');
      debugPrint(details.toString());
    }

    // In production, send to crash reporting service
    Analytics.logError(
      details.exception.toString(),
      stackTrace: details.stack.toString(),
    );

    // TODO: Send to Firebase Crashlytics or similar
    // FirebaseCrashlytics.instance.recordFlutterError(details);
  }

  /// Log a general error
  void logError(
    dynamic error, {
    StackTrace? stackTrace,
    String? context,
    Map<String, dynamic>? additionalInfo,
  }) {
    if (kDebugMode) {
      debugPrint('🔴 Error: $error');
      if (context != null) {
        debugPrint('Context: $context');
      }
      if (stackTrace != null) {
        debugPrint('Stack trace:\n$stackTrace');
      }
      if (additionalInfo != null) {
        debugPrint('Additional info: $additionalInfo');
      }
    }

    // Log to analytics
    Analytics.logError(
      error.toString(),
      stackTrace: stackTrace?.toString(),
    );

    // TODO: Send to crash reporting service
    // FirebaseCrashlytics.instance.recordError(error, stackTrace, reason: context);
  }

  /// Log a warning (non-fatal)
  void logWarning(
    String message, {
    Map<String, dynamic>? additionalInfo,
  }) {
    if (kDebugMode) {
      debugPrint('⚠️  Warning: $message');
      if (additionalInfo != null) {
        debugPrint('Additional info: $additionalInfo');
      }
    }

    // TODO: Log to analytics service
  }

  /// Log an info message
  void logInfo(String message) {
    if (kDebugMode) {
      debugPrint('ℹ️  Info: $message');
    }
  }

  /// Log a debug message
  void logDebug(String message) {
    if (kDebugMode) {
      debugPrint('🐛 Debug: $message');
    }
  }

  /// Set user identifier for crash reports
  void setUserId(String userId) {
    if (kDebugMode) {
      debugPrint('👤 User ID set: $userId');
    }

    // TODO: Set in crash reporting service
    // FirebaseCrashlytics.instance.setUserIdentifier(userId);
  }

  /// Set custom key-value pairs for crash reports
  void setCustomKey(String key, dynamic value) {
    if (kDebugMode) {
      debugPrint('🔑 Custom key set: $key = $value');
    }

    // TODO: Set in crash reporting service
    // FirebaseCrashlytics.instance.setCustomKey(key, value);
  }

  /// Log a breadcrumb (trail of events leading to error)
  void logBreadcrumb(String message, {Map<String, dynamic>? data}) {
    if (kDebugMode) {
      debugPrint('🍞 Breadcrumb: $message');
      if (data != null) {
        debugPrint('Data: $data');
      }
    }

    // TODO: Log to crash reporting service
    // Sentry.addBreadcrumb(Breadcrumb(message: message, data: data));
  }

  /// Catch and log errors from async operations
  Future<T?> catchAsync<T>(
    Future<T> Function() operation, {
    String? context,
    T? fallback,
  }) async {
    try {
      return await operation();
    } catch (error, stackTrace) {
      logError(
        error,
        stackTrace: stackTrace,
        context: context,
      );
      return fallback;
    }
  }

  /// Wrap a function with error handling
  T? catchSync<T>(
    T Function() operation, {
    String? context,
    T? fallback,
  }) {
    try {
      return operation();
    } catch (error, stackTrace) {
      logError(
        error,
        stackTrace: stackTrace,
        context: context,
      );
      return fallback;
    }
  }

  /// Force a test crash (for testing error reporting)
  /// Only available in debug mode
  void testCrash() {
    if (!kDebugMode) {
      debugPrint('Test crash only available in debug mode');
      return;
    }

    throw Exception('Test crash - This is intentional for testing error reporting');
  }

  /// Check if error logging is initialized
  bool get isInitialized => _initialized;
}

/// Global error logging instance
final errorLogger = ErrorLoggingService();

/// Extension to easily log errors from anywhere
extension ErrorLoggingExtension on Object {
  void logAsError({StackTrace? stackTrace, String? context}) {
    errorLogger.logError(this, stackTrace: stackTrace, context: context);
  }
}

/// Widget that catches and logs errors in its subtree
class ErrorBoundary extends StatelessWidget {
  final Widget child;
  final Widget Function(FlutterErrorDetails)? errorBuilder;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }

  static Widget defaultErrorBuilder(FlutterErrorDetails details) {
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Oops! Something went wrong',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                kDebugMode
                    ? details.exception.toString()
                    : 'Please try again or restart the app',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
