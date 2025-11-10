# ArtJoy App Icon

This directory contains the app icon assets for ArtJoy.

## Icon Design

The app icon features:
- **Paint palette** with colorful paint dots (red, yellow, blue, green, purple)
- **Paintbrush** angled across the palette
- **Purple gradient background** matching the app's color scheme
- **Sparkles** to convey creativity and fun
- **Rounded corners** following modern app design standards

## Files

- `app_icon.svg` - Source SVG file (1024x1024)
- This file can be used to generate all required icon sizes

## Generating Icon Assets

### Option 1: Using flutter_launcher_icons (Recommended)

1. Add the package to `pubspec.yaml`:
```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.13.1

flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icon/app_icon.png"
  adaptive_icon_background: "#6C63FF"
  adaptive_icon_foreground: "assets/icon/app_icon_foreground.png"
```

2. Convert SVG to PNG (1024x1024) using any tool:
   - Inkscape
   - Online converters (e.g., cloudconvert.com)
   - GIMP
   - Adobe Illustrator

3. Run the generator:
```bash
flutter pub get
flutter pub run flutter_launcher_icons
```

### Option 2: Manual Generation

Generate the following sizes manually:

**Android:**
- `mipmap-mdpi/ic_launcher.png` - 48x48
- `mipmap-hdpi/ic_launcher.png` - 72x72
- `mipmap-xhdpi/ic_launcher.png` - 96x96
- `mipmap-xxhdpi/ic_launcher.png` - 144x144
- `mipmap-xxxhdpi/ic_launcher.png` - 192x192

**iOS:**
- Various sizes from 20x20 to 1024x1024 (see AppIcon.appiconset)

### Option 3: Online Tools

Use these free tools:
- **App Icon Generator**: https://appicon.co
- **MakeAppIcon**: https://makeappicon.com
- **Icon Kitchen**: https://icon.kitchen

## Current Status

✅ SVG source file created
⚠️ PNG versions need to be generated
⚠️ Platform-specific assets need to be created

## Design Guidelines

The icon follows:
- **iOS**: 1024x1024, no transparency, rounded corners handled by system
- **Android**: Multiple sizes, supports adaptive icons
- **Safe area**: Important elements kept within 80% of icon area
- **Contrast**: High contrast for visibility at small sizes

## Colors Used

- Background: Purple gradient (#6C63FF to #5A52D5)
- Palette: White (#FFFFFF)
- Paint colors:
  - Red (#FF6B6B)
  - Yellow (#FFE66D)
  - Blue (#4ECDC4)
  - Green (#95E1D3)
  - Purple (#C88CFF)
- Brush handle: Gold gradient (#FFD700 to #FFA500)
- Sparkles: White (#FFFFFF)

## Notes

- The icon is designed to be recognizable at all sizes
- It clearly communicates the app's purpose (drawing/coloring)
- Colors match the app's overall design theme
- Works well on both light and dark backgrounds
