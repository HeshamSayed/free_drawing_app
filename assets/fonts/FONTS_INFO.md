# ArtJoy Fonts

This directory contains custom fonts for the app.

## Primary Font: Fredoka

**Fredoka** is a fun, rounded sans-serif font perfect for a kid-friendly drawing app.

### Files Included:
- `Fredoka-Regular.ttf` - Regular weight (400)
- `Fredoka-Bold.ttf` - Bold weight (700)

### Usage in Code:

```dart
Text(
  'ArtJoy',
  style: TextStyle(
    fontFamily: 'Fredoka',
    fontWeight: FontWeight.bold,
  ),
)
```

## Font Configuration

Fonts are configured in `pubspec.yaml`:

```yaml
fonts:
  - family: Fredoka
    fonts:
      - asset: assets/fonts/Fredoka-Regular.ttf
      - asset: assets/fonts/Fredoka-Bold.ttf
        weight: 700
```

## License

Fredoka is available under the SIL Open Font License (OFL).
- Free for commercial use
- Can be bundled with applications
- Must include license file

## Alternative Fonts

If Fredoka is not available, the app falls back to system fonts:
- iOS: San Francisco
- Android: Roboto

## Download Source

Fredoka can be downloaded from:
- Google Fonts: https://fonts.google.com/specimen/Fredoka
- Font Squirrel: https://www.fontsquirrel.com/

## Installation Instructions

1. Download Fredoka font files
2. Place `.ttf` files in this directory
3. Run `flutter pub get` to update font assets
4. Restart the app to see changes

## Current Status

⚠️ **Placeholder fonts** - For production, download and add actual font files.
The app currently uses system default fonts as fallback.
