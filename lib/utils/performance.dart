import 'package:flutter/foundation.dart';

/// Performance monitoring and optimization utilities
///
/// This file contains functions to help monitor and optimize app performance.

class Performance {
  /// Measures execution time of a function
  /// Useful for debugging and optimization
  static Future<T> measureAsync<T>(
    String label,
    Future<T> Function() function,
  ) async {
    if (!kDebugMode) {
      // In release mode, just execute the function
      return await function();
    }

    final stopwatch = Stopwatch()..start();
    try {
      final result = await function();
      stopwatch.stop();
      debugPrint('⏱️  $label: ${stopwatch.elapsedMilliseconds}ms');
      return result;
    } catch (e) {
      stopwatch.stop();
      debugPrint('❌ $label failed after ${stopwatch.elapsedMilliseconds}ms');
      rethrow;
    }
  }

  /// Measures execution time of a synchronous function
  static T measureSync<T>(String label, T Function() function) {
    if (!kDebugMode) {
      return function();
    }

    final stopwatch = Stopwatch()..start();
    try {
      final result = function();
      stopwatch.stop();
      debugPrint('⏱️  $label: ${stopwatch.elapsedMilliseconds}ms');
      return result;
    } catch (e) {
      stopwatch.stop();
      debugPrint('❌ $label failed after ${stopwatch.elapsedMilliseconds}ms');
      rethrow;
    }
  }

  /// Logs memory usage (debug mode only)
  static void logMemoryUsage(String label) {
    if (kDebugMode) {
      debugPrint('📊 Memory check: $label');
      // Note: Detailed memory profiling requires platform channels
      // This is a placeholder for basic logging
    }
  }

  /// Debounces a function call
  /// Useful for preventing rapid repeated calls (e.g., on text input)
  static void Function() debounce(
    Duration duration,
    void Function() action,
  ) {
    DateTime? lastCall;

    return () {
      final now = DateTime.now();
      if (lastCall == null || now.difference(lastCall!) >= duration) {
        lastCall = now;
        action();
      }
    };
  }

  /// Throttles a function call
  /// Ensures function is called at most once per duration
  static void Function() throttle(
    Duration duration,
    void Function() action,
  ) {
    DateTime? lastRun;

    return () {
      final now = DateTime.now();
      if (lastRun == null || now.difference(lastRun!) >= duration) {
        lastRun = now;
        action();
      }
    };
  }

  /// Batches multiple operations together
  /// Useful for reducing layout recalculations
  static Future<List<T>> batch<T>(List<Future<T>> operations) async {
    return await Future.wait(operations);
  }

  /// Delays execution (for animations or throttling)
  static Future<void> delay(Duration duration) async {
    await Future.delayed(duration);
  }

  /// Checks if running in debug mode
  static bool get isDebugMode => kDebugMode;

  /// Checks if running in release mode
  static bool get isReleaseMode => kReleaseMode;

  /// Checks if running in profile mode
  static bool get isProfileMode => kProfileMode;

  /// Logs performance warning
  static void warnSlow(String operation, int milliseconds) {
    if (kDebugMode && milliseconds > 100) {
      debugPrint('⚠️  Slow operation detected: $operation took ${milliseconds}ms');
    }
  }
}
