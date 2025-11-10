# ArtJoy Build Scripts

This directory contains automated scripts to help with development, testing, and deployment.

## 📜 Available Scripts

### 1. setup_project.sh
**Sets up the project for first-time use**

```bash
./scripts/setup_project.sh
```

**What it does:**
- ✅ Checks Flutter installation
- ✅ Runs Flutter doctor
- ✅ Gets all dependencies
- ✅ Runs code generation
- ✅ Sets up iOS CocoaPods (macOS only)
- ✅ Verifies project structure
- ✅ Checks for connected devices
- ✅ Makes all scripts executable

**When to use:**
- First time setting up the project
- After cloning the repository
- When dependencies are out of sync

---

### 2. build_android.sh
**Builds Android APK or App Bundle**

```bash
./scripts/build_android.sh
```

**Interactive menu options:**
1. Debug APK (for testing)
2. Release APK (for distribution)
3. Release App Bundle (for Play Store)
4. All (builds both APK and Bundle)

**Additional options:**
```bash
./scripts/build_android.sh --clean  # Clean build
```

**What it does:**
- ✅ Cleans build (if --clean flag)
- ✅ Gets dependencies
- ✅ Runs code generation
- ✅ Analyzes code
- ✅ Builds selected variant
- ✅ Shows build output location
- ✅ Displays APK/Bundle size

**When to use:**
- Creating test builds
- Preparing for distribution
- Submitting to Google Play Store

**Requirements:**
- Android SDK configured
- For release builds: signing key configured (optional)
- For App Bundle: signing key required

---

### 3. build_ios.sh
**Builds iOS app** (macOS only)

```bash
./scripts/build_ios.sh
```

**Interactive menu options:**
1. Debug build (for simulator)
2. Release build (for device)
3. Archive (for App Store)

**Additional options:**
```bash
./scripts/build_ios.sh --clean  # Clean build including Pods
```

**What it does:**
- ✅ Checks macOS and Xcode
- ✅ Cleans build (if --clean flag)
- ✅ Gets dependencies
- ✅ Installs CocoaPods
- ✅ Runs code generation
- ✅ Analyzes code
- ✅ Builds selected variant
- ✅ Shows next steps for archiving

**When to use:**
- Creating iOS builds
- Testing on iOS simulator/device
- Preparing for App Store submission

**Requirements:**
- macOS operating system
- Xcode installed
- CocoaPods installed
- iOS signing configured in Xcode

---

### 4. run_tests.sh
**Runs all tests with optional coverage**

```bash
# Run tests
./scripts/run_tests.sh

# Run with coverage
./scripts/run_tests.sh --coverage
```

**What it does:**
- ✅ Gets dependencies
- ✅ Runs code analysis
- ✅ Runs all tests
- ✅ Generates coverage report (if --coverage)
- ✅ Creates HTML coverage report (if genhtml installed)

**When to use:**
- Before committing code
- As part of CI/CD pipeline
- When verifying test coverage

**Coverage report location:**
- LCOV: `coverage/lcov.info`
- HTML: `coverage/html/index.html`

---

### 5. clean_project.sh
**Cleans all build artifacts and caches**

```bash
./scripts/clean_project.sh
```

**What it does:**
- ✅ Runs Flutter clean
- ✅ Removes generated files
- ✅ Cleans iOS Pods
- ✅ Cleans Android Gradle build
- ✅ Removes coverage files

**When to use:**
- When builds are failing mysteriously
- After updating Flutter or dependencies
- To free up disk space
- When switching between branches with different dependencies

**Warning:** This will require running setup again.

---

## 🚀 Quick Workflows

### First Time Setup
```bash
# 1. Setup project
./scripts/setup_project.sh

# 2. Run the app
flutter run
```

### Before Committing
```bash
# Run tests
./scripts/run_tests.sh

# If tests pass, commit
git add .
git commit -m "Your message"
```

### Creating a Release Build

**Android:**
```bash
# Build release APK
./scripts/build_android.sh
# Select option 2 or 3

# Install on device
adb install build/app/outputs/flutter-apk/app-release.apk
```

**iOS:**
```bash
# Build release
./scripts/build_ios.sh
# Select option 3

# Follow Xcode instructions to archive and upload
```

### When Things Go Wrong
```bash
# Clean everything
./scripts/clean_project.sh

# Setup again
./scripts/setup_project.sh

# Try building again
```

---

## 📋 Script Requirements

### All Scripts
- Flutter SDK installed and in PATH
- Git (for version control)

### build_android.sh
- Android SDK
- Java JDK
- (Optional) Signing key for release builds

### build_ios.sh
- macOS operating system
- Xcode
- CocoaPods
- Valid iOS signing certificates

### run_tests.sh
- Flutter test dependencies
- (Optional) lcov for HTML coverage reports

---

## 🛠️ Customization

You can customize these scripts by:

1. **Editing the scripts directly**
   - Scripts are in `/scripts` directory
   - Use any text editor

2. **Adding new scripts**
   - Create new `.sh` file in `scripts/` directory
   - Make it executable: `chmod +x scripts/your_script.sh`
   - Follow the same structure as existing scripts

3. **Creating aliases**
   ```bash
   # Add to ~/.bashrc or ~/.zshrc
   alias artjoy-build="cd /path/to/artjoy && ./scripts/build_android.sh"
   alias artjoy-test="cd /path/to/artjoy && ./scripts/run_tests.sh"
   ```

---

## 🐛 Troubleshooting

### "Permission denied" error
```bash
chmod +x scripts/*.sh
```

### "Flutter command not found"
Add Flutter to your PATH:
```bash
export PATH="$PATH:/path/to/flutter/bin"
```

### Android build fails
1. Check Android SDK is installed
2. Run `flutter doctor`
3. Clean project: `./scripts/clean_project.sh`
4. Try again

### iOS build fails
1. Make sure you're on macOS
2. Check Xcode is installed: `xcode-select --install`
3. Install CocoaPods: `sudo gem install cocoapods`
4. Clean project and try again

### Tests fail
1. Make sure all dependencies are installed: `flutter pub get`
2. Check test files in `test/` directory
3. Run with verbose output: `flutter test --verbose`

---

## 💡 Best Practices

1. **Always run tests before building release**
   ```bash
   ./scripts/run_tests.sh && ./scripts/build_android.sh
   ```

2. **Clean build for major releases**
   ```bash
   ./scripts/clean_project.sh
   ./scripts/setup_project.sh
   ./scripts/build_android.sh --clean
   ```

3. **Check code analysis warnings**
   - Scripts automatically run `flutter analyze`
   - Fix warnings before releasing

4. **Test on physical devices**
   - Emulators don't always catch all issues
   - Test performance on real hardware

5. **Keep scripts updated**
   - As project evolves, update scripts
   - Add new build variants as needed

---

## 📚 Additional Resources

- **Flutter Build Docs**: https://docs.flutter.dev/deployment
- **Android Signing**: https://docs.flutter.dev/deployment/android
- **iOS Deployment**: https://docs.flutter.dev/deployment/ios
- **CI/CD**: https://docs.flutter.dev/deployment/cd

---

## ✨ Contributing

When adding new scripts:
1. Follow the existing naming convention
2. Add comprehensive comments
3. Include error handling
4. Update this README
5. Test on different systems if possible

---

Last Updated: 2025-11-10
