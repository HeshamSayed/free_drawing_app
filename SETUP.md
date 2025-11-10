# Setup Guide for ArtJoy

This guide will help you set up and configure the ArtJoy app for development and production.

## Quick Start (5 minutes)

1. **Clone and Install**
   ```bash
   git clone <repository-url>
   cd free_drawing_app
   flutter pub get
   ```

2. **Run the App**
   ```bash
   flutter run
   ```

That's it! The app will run with test ads.

---

## Production Setup

**✅ IMPORTANT: AdMob App ID is already configured!**
- App ID: `ca-app-pub-6976864649919972~8450614936`
- This is set in both Android and iOS configuration files
- You only need to add your **Ad Unit IDs** (see Step 1 below)

### Step 1: Create Ad Units in AdMob

1. **Login to AdMob**
   - Go to https://admob.google.com
   - Login with your Google account
   - Your app should already be registered

2. **Create Ad Units**
   Create three ad units for your app:
   - **Banner Ad** (320x50)
   - **Interstitial Ad** (Full screen)
   - **Rewarded Ad** (Full screen)

   Note all **Ad Unit IDs** (format: ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY).

### Step 2: Configure Android

1. **App ID is Already Set** ✅

   The AdMob App ID is already configured in `android/app/src/main/AndroidManifest.xml`:
   ```xml
   <meta-data
       android:name="com.google.android.gms.ads.APPLICATION_ID"
       android:value="ca-app-pub-6976864649919972~8450614936"/>
   ```
   No changes needed!

2. **Update Package Name** (Optional)

   Edit `android/app/build.gradle`:
   ```gradle
   defaultConfig {
       applicationId "com.yourcompany.artjoy"
       // ...
   }
   ```

3. **Generate Signing Key**
   ```bash
   keytool -genkey -v -keystore ~/artjoy-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias artjoy
   ```

4. **Create key.properties**

   Create `android/key.properties`:
   ```
   storePassword=your_store_password
   keyPassword=your_key_password
   keyAlias=artjoy
   storeFile=/path/to/artjoy-key.jks
   ```

### Step 3: Configure iOS

1. **App ID is Already Set** ✅

   The AdMob App ID is already configured in `ios/Runner/Info.plist`:
   ```xml
   <key>GADApplicationIdentifier</key>
   <string>ca-app-pub-6976864649919972~8450614936</string>
   ```
   No changes needed!

2. **Open in Xcode**
   ```bash
   open ios/Runner.xcworkspace
   ```

3. **Configure Bundle Identifier**
   - Select Runner in project navigator
   - Change Bundle Identifier to your unique ID
   - Select your Development Team

### Step 4: Update Ad Unit IDs

Edit `lib/services/ads_service.dart`:

```dart
static String get bannerAdUnitId {
  if (Platform.isAndroid) {
    return 'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY'; // Your Android Banner ID
  } else if (Platform.isIOS) {
    return 'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY'; // Your iOS Banner ID
  }
  return '';
}

static String get interstitialAdUnitId {
  if (Platform.isAndroid) {
    return 'ca-app-pub-XXXXXXXXXXXXXXXX/ZZZZZZZZZZ'; // Your Android Interstitial ID
  } else if (Platform.isIOS) {
    return 'ca-app-pub-XXXXXXXXXXXXXXXX/ZZZZZZZZZZ'; // Your iOS Interstitial ID
  }
  return '';
}

static String get rewardedAdUnitId {
  if (Platform.isAndroid) {
    return 'ca-app-pub-XXXXXXXXXXXXXXXX/AAAAAAAAAA'; // Your Android Rewarded ID
  } else if (Platform.isIOS) {
    return 'ca-app-pub-XXXXXXXXXXXXXXXX/AAAAAAAAAA'; // Your iOS Rewarded ID
  }
  return '';
}
```

### Step 5: Add Assets

1. **Download Fredoka Font**
   - Visit https://fonts.google.com/specimen/Fredoka
   - Download font files
   - Place in `assets/fonts/`

2. **Add Sound Effects** (Optional)
   - Add MP3 files to `assets/sounds/`
   - Or comment out audio code if not using

3. **Add Coloring Page Templates** (Optional)
   - Create or download SVG/PNG coloring templates
   - Place in `assets/coloring_pages/`

### Step 6: Test Thoroughly

```bash
# Test on Android
flutter run -d android

# Test on iOS
flutter run -d ios

# Run tests
flutter test
```

### Step 7: Build for Production

**Android:**
```bash
flutter build appbundle --release
```
Output: `build/app/outputs/bundle/release/app-release.aab`

**iOS:**
```bash
flutter build ios --release
```
Then archive in Xcode.

---

## In-App Purchases Setup (Optional)

To enable real premium purchases:

1. **Android (Google Play Billing)**
   - Add `in_app_purchase` package
   - Configure products in Google Play Console
   - Implement purchase logic

2. **iOS (StoreKit)**
   - Configure products in App Store Connect
   - Implement purchase logic
   - Test with sandbox accounts

---

## Troubleshooting

### Ads not showing
- ✅ Verify App ID is correct
- ✅ Check Ad Unit IDs
- ✅ Wait 1-2 hours after creating new ad units
- ✅ Check AdMob dashboard for errors
- ✅ Ensure internet connection

### Build errors
```bash
flutter clean
flutter pub get
cd android && ./gradlew clean
cd ..
flutter build apk
```

### iOS signing issues
- ✅ Select valid development team
- ✅ Ensure unique bundle identifier
- ✅ Check provisioning profiles

---

## Support

For help:
- Check README.md
- Open GitHub issue
- Contact: support@artjoy.app

Good luck! 🎨
