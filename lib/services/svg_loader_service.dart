import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

/// Service for loading and rendering SVG coloring pages
class SvgLoaderService {
  /// Cache for loaded SVG strings
  static final Map<String, String> _svgCache = {};

  /// Loads an SVG coloring page from assets
  /// Returns the SVG string that can be rendered
  static Future<String> loadColoringPage(String pageId) async {
    // Check cache first
    if (_svgCache.containsKey(pageId)) {
      return _svgCache[pageId]!;
    }

    try {
      final svgString = await rootBundle.loadString(
        'assets/coloring_pages/$pageId.svg',
      );

      // Cache the SVG string
      _svgCache[pageId] = svgString;

      return svgString;
    } catch (e) {
      debugPrint('Error loading SVG $pageId: $e');
      rethrow;
    }
  }

  /// Preloads multiple coloring pages for faster access
  static Future<void> preloadColoringPages(List<String> pageIds) async {
    final futures = pageIds.map((id) => loadColoringPage(id));
    await Future.wait(futures, eagerError: false);
  }

  /// Clears the SVG cache to free memory
  static void clearCache() {
    _svgCache.clear();
  }

  /// Clears a specific SVG from cache
  static void clearFromCache(String pageId) {
    _svgCache.remove(pageId);
  }

  /// Checks if an SVG is in cache
  static bool isCached(String pageId) {
    return _svgCache.containsKey(pageId);
  }

  /// Gets the number of cached SVGs
  static int getCacheSize() {
    return _svgCache.length;
  }

  /// Creates a widget to display an SVG coloring page
  static Widget buildSvgWidget({
    required String svgString,
    BoxFit fit = BoxFit.contain,
    Color? color,
    double? width,
    double? height,
  }) {
    return SvgPicture.string(
      svgString,
      fit: fit,
      color: color,
      width: width,
      height: height,
    );
  }

  /// Creates a preview widget for a coloring page
  static Widget buildPreviewWidget({
    required String pageId,
    double size = 100,
  }) {
    return FutureBuilder<String>(
      future: loadColoringPage(pageId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: size,
            height: size,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return SizedBox(
            width: size,
            height: size,
            child: const Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
          );
        }

        if (!snapshot.hasData) {
          return SizedBox(
            width: size,
            height: size,
            child: const Icon(Icons.image_not_supported),
          );
        }

        return SvgPicture.string(
          snapshot.data!,
          width: size,
          height: size,
          fit: BoxFit.contain,
        );
      },
    );
  }

  /// Validates if an SVG file exists
  static Future<bool> svgExists(String pageId) async {
    try {
      await rootBundle.loadString('assets/coloring_pages/$pageId.svg');
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Gets all available coloring page IDs
  /// Note: This requires the pages to be known in advance
  /// In production, you might load this from a manifest file
  static List<String> getAvailablePages() {
    return [
      'cat',
      'flower',
      'car',
      'house',
      'tree',
      'sun',
      'butterfly',
      'rocket',
      'fish',
    ];
  }

  /// Converts SVG to a widget with error handling
  static Widget safeLoadSvg({
    required String pageId,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    return FutureBuilder<String>(
      future: loadColoringPage(pageId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return placeholder ??
              Center(
                child: SizedBox(
                  width: width ?? 50,
                  height: height ?? 50,
                  child: const CircularProgressIndicator(),
                ),
              );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return errorWidget ??
              Center(
                child: Icon(
                  Icons.error_outline,
                  size: width ?? height ?? 50,
                  color: Colors.red,
                ),
              );
        }

        return SvgPicture.string(
          snapshot.data!,
          width: width,
          height: height,
          fit: fit,
        );
      },
    );
  }
}
