# ArtJoy - Quick Start Guide

Get your ArtJoy drawing app up and running in 5 minutes!

## 🚀 Fast Track

```bash
# 1. Install dependencies
flutter pub get

# 2. Run the app
flutter run

# That's it! The app should now be running on your device/emulator.
```

---

## 📋 Prerequisites

Before starting, ensure you have:

- ✅ Flutter SDK installed (3.0+)
- ✅ Android Studio / Xcode (for emulator)
- ✅ A physical device or emulator running
- ✅ Git (for version control)

**Check your Flutter installation:**
```bash
flutter doctor
```

---

## 🎯 Step-by-Step Setup

### Step 1: Verify Your Environment

```bash
# Check Flutter version
flutter --version

# Check connected devices
flutter devices

# Verify setup
./verify_structure.sh
```

### Step 2: Install Dependencies

```bash
# Get all Flutter packages
flutter pub get

# (Optional) Generate Hive adapters if needed
flutter pub run build_runner build --delete-conflicting-outputs
```

### Step 3: Run the App

```bash
# Run in debug mode (hot reload enabled)
flutter run

# Or run in release mode (better performance)
flutter run --release
```

### Step 4: Explore the App

On first launch:
1. **Onboarding** - 5-page tutorial will guide you
2. **Home Screen** - Tap "Free Draw" to start creating
3. **Try Drawing** - Select a brush, pick a color, and draw!
4. **Save Your Art** - Tap the save icon when done

---

## 🎨 Quick Feature Tour

### Drawing
```
Home Screen → Free Draw → Select Brush → Pick Color → Draw!
```

### Coloring
```
Home Screen → Coloring → Choose Page → Color It!
```

### Gallery
```
Home Screen → Gallery → View your creations
```

### Achievements
```
Home Screen → Achievements → Track your progress
```

### Daily Challenge
```
Home Screen → Daily Challenge → Complete today's challenge
```

---

## 🛠️ Troubleshooting

### "MissingPluginException"
```bash
flutter clean
flutter pub get
flutter run
```

### "Unable to locate adb"
```bash
# Add Android SDK platform-tools to PATH
export PATH=$PATH:$HOME/Android/Sdk/platform-tools
```

### "No devices found"
```bash
# Start an Android emulator
flutter emulators --launch <emulator_id>

# Or check connected physical device
adb devices
```

### "Gradle build failed"
```bash
cd android
./gradlew clean
cd ..
flutter run
```

### "CocoaPods error" (iOS)
```bash
cd ios
pod install --repo-update
cd ..
flutter run
```

---

## 📱 Recommended Test Flow

1. **First Launch**
   - Watch onboarding tutorial
   - Skip to home screen

2. **Create First Drawing**
   - Tap "Free Draw"
   - Draw something
   - Save it
   - Check achievement unlocked!

3. **Try Coloring**
   - Tap "Coloring"
   - Select a coloring page
   - Color it in
   - Save and share

4. **Explore Features**
   - View gallery
   - Check achievements
   - Try daily challenge
   - Toggle dark mode in settings

---

## 🔧 Common Commands

```bash
# Run app
flutter run

# Run with specific device
flutter run -d <device-id>

# Hot reload (while app is running)
# Press 'r' in terminal

# Hot restart (while app is running)
# Press 'R' in terminal

# Quit app (while app is running)
# Press 'q' in terminal

# Clear build cache
flutter clean

# Analyze code
flutter analyze

# Format code
flutter format lib/

# Build APK (Android)
flutter build apk

# Build iOS
flutter build ios

# Run tests
flutter test
```

---

## 📚 Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/                      # Data models (5 files)
│   ├── drawing.dart
│   ├── settings.dart
│   ├── unlocked_content.dart
│   └── achievement.dart
├── services/                    # Business logic (7 files)
│   ├── database_service.dart
│   ├── settings_service.dart
│   ├── ads_service.dart
│   ├── audio_service.dart
│   ├── achievement_service.dart
│   ├── daily_challenge_service.dart
│   └── export_service.dart
├── screens/                     # UI screens (10 files)
│   ├── home_screen.dart
│   ├── drawing_screen.dart
│   ├── coloring_screen.dart
│   ├── gallery_screen.dart
│   ├── settings_screen.dart
│   ├── achievements_screen.dart
│   ├── daily_challenge_screen.dart
│   ├── onboarding_screen.dart
│   └── splash_screen.dart
├── widgets/                     # Reusable widgets
│   ├── brush_selector.dart
│   ├── color_picker_widget.dart
│   ├── drawing_canvas.dart
│   ├── achievement_dialog.dart
│   └── loading_overlay.dart
└── utils/                       # Utilities
    ├── constants.dart
    ├── helpers.dart
    ├── theme.dart
    └── drawing_controller.dart
```

---

## 🎯 What's Already Working

### ✅ Core Features
- [x] Free drawing with 6 brush types
- [x] Color picker with 20+ colors
- [x] Undo/Redo functionality
- [x] Zoom and pan gestures
- [x] Save and load drawings
- [x] Export and share

### ✅ Advanced Features
- [x] 7 achievements
- [x] 12 daily challenges
- [x] Time-lapse recording
- [x] Onboarding tutorial
- [x] Gallery with search
- [x] Settings persistence

### ✅ Monetization
- [x] AdMob integration
- [x] Banner ads
- [x] Interstitial ads
- [x] Rewarded ads
- [x] Premium upgrade

---

## 📖 Next Steps

After testing the app locally:

1. **Read Documentation**
   - `PRODUCTION_READINESS.md` - Launch checklist
   - `TESTING_GUIDE.md` - Complete testing guide
   - `DEPLOYMENT.md` - Store submission guide

2. **Replace Test IDs**
   - Update AdMob App IDs in `lib/services/ads_service.dart`
   - Create production ad units

3. **Add App Icon**
   - Create 1024x1024 icon
   - Use `flutter_launcher_icons` package
   - See `APP_ICON_GUIDE.md`

4. **Set Up Signing**
   - Android: Generate keystore
   - iOS: Configure signing in Xcode

5. **Build Release**
   ```bash
   flutter build apk --release        # Android
   flutter build appbundle --release  # Android (for Play Store)
   flutter build ios --release        # iOS
   ```

6. **Submit to Stores**
   - Google Play Store
   - Apple App Store

---

## 🎉 You're Ready!

Your ArtJoy app is fully functional and ready for testing. All features are implemented, integrated, and working.

**Enjoy building with ArtJoy!** 🎨

---

## 📞 Need Help?

- **Documentation:** Check the `docs/` folder for detailed guides
- **Verification:** Run `./verify_structure.sh` to check setup
- **Issues:** Review `TROUBLESHOOTING.md`
- **Flutter Docs:** https://docs.flutter.dev/

---

## 💡 Pro Tips

1. **Hot Reload is Your Friend**
   - Make code changes and press 'r' to see them instantly
   - No need to rebuild the entire app

2. **Use Release Mode for Testing**
   - Performance is much better in release mode
   - Use `flutter run --release` for realistic testing

3. **Test on Real Devices**
   - Emulators are great, but test on actual phones
   - Touch interactions feel different on real devices

4. **Check the Logs**
   - Use `flutter logs` to see detailed logs
   - Helps debug issues quickly

5. **Keep Dependencies Updated**
   - Run `flutter pub outdated` to check for updates
   - Update carefully and test after each update

---

**Last Updated:** 2025-11-10
**Version:** 1.0.0
**Status:** Production Ready ✅
