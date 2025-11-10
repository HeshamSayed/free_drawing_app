# App Icon Configuration Guide

This guide explains how to add custom app icons for ArtJoy.

## Option 1: Using flutter_launcher_icons Package (Recommended)

### 1. Install the Package

The package is already added to `pubspec.yaml` as a dev dependency.

### 2. Create Your Icon

Create a 1024x1024 PNG image named `app_icon.png` and place it in the root directory or `assets/images/` folder.

### 3. Add Configuration to pubspec.yaml

Add this configuration:

```yaml
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/images/app_icon.png"
  adaptive_icon_background: "#6C63FF"
  adaptive_icon_foreground: "assets/images/app_icon_foreground.png"
```

### 4. Generate Icons

Run:
```bash
flutter pub get
flutter pub run flutter_launcher_icons
```

## Option 2: Manual Configuration

### Android Icons

Place icons in these folders with corresponding sizes:

```
android/app/src/main/res/
├── mipmap-mdpi/ic_launcher.png (48x48)
├── mipmap-hdpi/ic_launcher.png (72x72)
├── mipmap-xhdpi/ic_launcher.png (96x96)
├── mipmap-xxhdpi/ic_launcher.png (144x144)
└── mipmap-xxxhdpi/ic_launcher.png (192x192)
```

### iOS Icons

1. Create icons at various sizes:
   - 20x20, 29x29, 40x40, 60x60, 76x76, 83.5x83.5, 1024x1024

2. Open `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

3. Replace placeholder icons with your icons

4. Update `Contents.json` with correct filenames

## Recommended Icon Design

For ArtJoy, consider an icon that represents:
- A paintbrush or pencil
- Colorful palette
- Art/drawing theme
- Kid-friendly design
- Bright, attractive colors

### Design Guidelines

**Android:**
- Size: 1024x1024
- Format: PNG with transparency
- Padding: ~20% safe zone
- Style: Flat design, bold colors

**iOS:**
- Size: 1024x1024
- Format: PNG without transparency
- No rounded corners (iOS adds them)
- Style: Clean, simple design

## Free Icon Resources

- [Figma Community](https://www.figma.com/community)
- [Canva](https://www.canva.com/)
- [Adobe Express](https://www.adobe.com/express/)
- [IconKitchen](https://icon.kitchen/)

## Testing Icons

After adding icons:
1. Uninstall the app from your device
2. Run `flutter clean`
3. Rebuild and install the app
4. Check if icons appear correctly on home screen

## Color Scheme Suggestion

Based on ArtJoy's theme:
- Primary: #6C63FF (Purple)
- Secondary: #FF6584 (Pink)
- Accent: #FFC947 (Yellow)
- Background: White or gradient

Create a colorful, fun icon that appeals to both kids and adults!
