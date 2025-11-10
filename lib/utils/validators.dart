/// Validation utilities for ArtJoy app
///
/// This file contains validation functions used throughout the app.

class Validators {
  /// Validates drawing name input
  /// Returns error message if invalid, null if valid
  static String? validateDrawingName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a name for your drawing';
    }

    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }

    if (value.length > 50) {
      return 'Name cannot exceed 50 characters';
    }

    // Check for invalid characters
    final invalidChars = RegExp(r'[<>:"/\\|?*]');
    if (invalidChars.hasMatch(value)) {
      return 'Name contains invalid characters';
    }

    return null;
  }

  /// Validates color hex code
  /// Returns true if valid hex color
  static bool isValidHexColor(String hexColor) {
    final hexPattern = RegExp(r'^#?([0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})$');
    return hexPattern.hasMatch(hexColor);
  }

  /// Validates brush size
  /// Returns error message if invalid, null if valid
  static String? validateBrushSize(double? size) {
    if (size == null) {
      return 'Brush size is required';
    }

    if (size < 1) {
      return 'Brush size must be at least 1';
    }

    if (size > 50) {
      return 'Brush size cannot exceed 50';
    }

    return null;
  }

  /// Validates opacity value
  /// Returns error message if invalid, null if valid
  static String? validateOpacity(double? opacity) {
    if (opacity == null) {
      return 'Opacity is required';
    }

    if (opacity < 0 || opacity > 1) {
      return 'Opacity must be between 0 and 1';
    }

    return null;
  }

  /// Sanitizes user input for display
  /// Removes potentially harmful characters
  static String sanitizeInput(String input) {
    return input
        .replaceAll(RegExp(r'[<>]'), '')
        .replaceAll(RegExp(r'[\r\n]+'), ' ')
        .trim();
  }

  /// Checks if string is empty or whitespace
  static bool isNullOrEmpty(String? value) {
    return value == null || value.trim().isEmpty;
  }

  /// Validates email format (for feedback/support)
  static bool isValidEmail(String email) {
    final emailPattern = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailPattern.hasMatch(email);
  }

  /// Validates that a number is within range
  static bool isInRange(num value, num min, num max) {
    return value >= min && value <= max;
  }

  /// Validates file name
  /// Returns error message if invalid, null if valid
  static String? validateFileName(String? fileName) {
    if (fileName == null || fileName.trim().isEmpty) {
      return 'File name is required';
    }

    final invalidChars = RegExp(r'[<>:"/\\|?*]');
    if (invalidChars.hasMatch(fileName)) {
      return 'File name contains invalid characters';
    }

    if (fileName.length > 100) {
      return 'File name is too long';
    }

    return null;
  }
}
