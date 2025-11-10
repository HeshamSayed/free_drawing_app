# 🎨 ArtJoy - Free Drawing & Coloring Game

<div align="center">
  <h3>A fun and colorful drawing app for kids and families!</h3>
  <p>Built with Flutter • Fully Offline • Smart Monetization</p>
</div>

---

## 📱 Features

### Core Features
- ✏️ **Free Drawing Canvas** - Draw freely with multiple brush types
- 🎨 **Multiple Brush Types** - Pen, Marker, Pencil, Neon, Watercolor, Eraser
- 🌈 **Color Picker** - Palette with 20+ colors + custom color picker
- 📏 **Adjustable Brush Size** - 1-50px with live preview
- 🔄 **Undo/Redo** - Full drawing history management
- 💾 **Local Storage** - All data saved offline using Hive
- 🖼️ **Gallery** - View, edit, and manage saved drawings
- 🎨 **Coloring Pages** - 8+ preloaded coloring pages
- 🌓 **Dark Mode** - Beautiful dark and light themes
- 🔊 **Sound Effects** - Optional audio feedback

### Monetization Features
- 📊 **Banner Ads** - Non-intrusive bottom banners
- 🎁 **Rewarded Ads** - Unlock brushes and coloring pages
- ⏰ **Smart Interstitials** - Frequency-capped (every 3-5 sessions)
- 💎 **Premium Upgrade** - Remove ads and unlock everything

### Technical Features
- 📦 **Offline-First** - Works completely offline
- 🗄️ **Hive Database** - Fast local storage
- 🎯 **Clean Architecture** - Models, Services, Screens, Widgets
- 📱 **Responsive UI** - Works on phones and tablets
- 🔧 **State Management** - Provider for reactive updates

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or later)
- Dart SDK (3.0.0 or later)
- Android Studio / VS Code
- Android SDK (API 21+) or Xcode (iOS 12+)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/free_drawing_app.git
   cd free_drawing_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

---

## 🔧 Configuration

### AdMob Setup

**✅ AdMob App ID is already configured:** `ca-app-pub-6976864649919972~8450614936`

The app currently uses **test Ad Unit IDs**. To use real ads in production:

1. **Create Ad Units in AdMob**
   - Login to your account at [AdMob](https://admob.google.com/)
   - Your app should already be registered
   - Create 3 ad units: Banner, Interstitial, Rewarded
   - Note your Ad Unit IDs

2. **App ID is Already Set** ✅

   Android configuration (`android/app/src/main/AndroidManifest.xml`):
   ```xml
   <meta-data
       android:name="com.google.android.gms.ads.APPLICATION_ID"
       android:value="ca-app-pub-6976864649919972~8450614936"/>
   ```

   iOS configuration (`ios/Runner/Info.plist`):
   ```xml
   <key>GADApplicationIdentifier</key>
   <string>ca-app-pub-6976864649919972~8450614936</string>
   ```

3. **Update Ad Unit IDs**

   Edit `lib/services/ads_service.dart` and replace test IDs:
   ```dart
   static String get bannerAdUnitId {
     if (Platform.isAndroid) {
       return 'YOUR-ANDROID-BANNER-ID';
     } else if (Platform.isIOS) {
       return 'YOUR-IOS-BANNER-ID';
     }
   }
   // Update interstitial and rewarded IDs similarly
   ```

### Permissions

#### Android
Permissions are already configured in `AndroidManifest.xml`:
- Internet (for ads)
- Access Network State (for ads)
- Read/Write External Storage (for saving drawings)

#### iOS
Permissions are configured in `Info.plist`:
- Photo Library Usage (for saving drawings)
- Photo Library Add Usage (for saving drawings)

---

## 📁 Project Structure

```
lib/
├── main.dart                  # App entry point
├── models/                    # Data models
│   ├── drawing.dart          # Drawing and DrawingPoint models
│   ├── settings.dart         # App settings model
│   └── unlocked_content.dart # Unlocked content tracking
├── services/                  # Business logic services
│   ├── database_service.dart # Hive database operations
│   ├── settings_service.dart # Settings management
│   ├── ads_service.dart      # AdMob integration
│   └── audio_service.dart    # Sound effects
├── screens/                   # App screens
│   ├── home_screen.dart      # Main home screen
│   ├── drawing_screen.dart   # Drawing canvas screen
│   ├── gallery_screen.dart   # Gallery view
│   ├── coloring_screen.dart  # Coloring pages
│   └── settings_screen.dart  # Settings
├── widgets/                   # Reusable widgets
│   ├── drawing_canvas.dart   # Custom painter canvas
│   ├── color_picker_widget.dart
│   └── brush_selector.dart
└── utils/                     # Utilities
    ├── theme.dart            # App theme configuration
    └── drawing_controller.dart # Drawing state management
```

---

## 🎨 Features Breakdown

### Drawing Engine
- **Custom Painter** - Smooth, performant drawing using Flutter's CustomPainter
- **Brush Types**:
  - Pen - Standard drawing
  - Marker - Semi-transparent, wider strokes
  - Pencil - Thin, precise lines
  - Neon - Glowing effect with blur
  - Watercolor - Soft, blended strokes
  - Eraser - Remove strokes
- **Stroke History** - Efficient undo/redo with stack-based history
- **Touch Gestures** - Responsive pan and drawing

### Storage System
- **Hive Database** - Lightning-fast NoSQL database
- **Data Models**:
  - Drawings with stroke data
  - User settings and preferences
  - Unlocked content tracking
- **Automatic Persistence** - All changes saved instantly

### Monetization Strategy
- **Non-Intrusive Ads**:
  - Banners only on home/gallery (not while drawing)
  - Interstitials with 10-minute cooldown
  - Frequency capping (every 3-5 sessions)
- **Value-Based Rewards**:
  - Watch ads to unlock premium brushes
  - Unlock coloring pages
  - No fake currency or manipulation

### Premium Features
- Remove all ads
- Instant access to all brushes
- All coloring pages unlocked
- HD export quality
- Priority support

---

## 🔨 Build & Deploy

### Android

1. **Build APK**
   ```bash
   flutter build apk --release
   ```

2. **Build App Bundle** (for Play Store)
   ```bash
   flutter build appbundle --release
   ```

### iOS

1. **Build for iOS**
   ```bash
   flutter build ios --release
   ```

2. **Archive for App Store**
   - Open `ios/Runner.xcworkspace` in Xcode
   - Select "Any iOS Device" as target
   - Product > Archive
   - Follow App Store submission process

---

## 📊 Testing Ads

The app uses **Google AdMob test ad unit IDs** by default. You'll see test ads with "Test Ad" labels.

### Test Ad Unit IDs (Already configured)
- **Banner**: `ca-app-pub-3940256099942544/6300978111`
- **Interstitial**: `ca-app-pub-3940256099942544/1033173712`
- **Rewarded**: `ca-app-pub-3940256099942544/5224354917`

**⚠️ Important**: Replace these with your real Ad Unit IDs before publishing!

---

## 🎯 Performance Optimization

### Drawing Performance
- Uses `RepaintBoundary` for canvas isolation
- Efficient stroke caching
- Optimized paint operations
- Touch sampling for smooth lines

### Memory Management
- Automatic cleanup of disposed resources
- Lazy loading of images
- Efficient Hive storage with minimal overhead

---

## 🐛 Troubleshooting

### Common Issues

**1. Ads not showing**
- Check internet connection
- Verify AdMob App ID is correct
- Wait a few minutes for test ads to load
- Check device date/time settings

**2. Build errors**
- Run `flutter clean && flutter pub get`
- Check Flutter and Dart SDK versions
- Verify all dependencies are compatible

**3. Permission denied errors**
- Request storage permissions on Android 6+
- Check Info.plist for iOS permissions

**4. Drawing lag/stuttering**
- Reduce brush size for complex drawings
- Clear old drawings from gallery
- Close background apps

---

## 📈 Future Enhancements

Potential features for future versions:
- [ ] Layers support
- [ ] Blend modes
- [ ] Pattern fills
- [ ] Text tool
- [ ] Stickers and stamps
- [ ] Cloud sync (optional)
- [ ] Social sharing gallery
- [ ] Drawing challenges
- [ ] Time-lapse video export
- [ ] Collaborative drawing

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 👏 Acknowledgments

- Flutter team for the amazing framework
- AdMob for monetization platform
- Hive for efficient local storage
- All contributors and testers

---

## 📞 Support

For issues, questions, or suggestions:
- Open an issue on GitHub
- Email: support@artjoy.app
- Website: https://artjoy.app

---

<div align="center">
  <p>Made with ❤️ using Flutter</p>
  <p>Happy Drawing! 🎨</p>
</div>
