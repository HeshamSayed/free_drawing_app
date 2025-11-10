#!/bin/bash

# ArtJoy - Android Build Script
# This script automates the Android build process

set -e # Exit on error

echo "🤖 ArtJoy Android Build Script"
echo "================================"
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print colored messages
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    print_error "Flutter is not installed or not in PATH"
    exit 1
fi

print_success "Flutter found"

# Get Flutter version
echo "Flutter version:"
flutter --version | head -n 1

echo ""
echo "Select build type:"
echo "1. Debug APK (for testing)"
echo "2. Release APK (for distribution)"
echo "3. Release App Bundle (for Play Store)"
echo "4. All (APK + Bundle)"
read -p "Enter choice [1-4]: " choice

echo ""

# Clean build
if [ "$1" == "--clean" ]; then
    echo "🧹 Cleaning build..."
    flutter clean
    print_success "Clean complete"
    echo ""
fi

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get
print_success "Dependencies fetched"
echo ""

# Run build_runner if needed
if [ -f "pubspec.yaml" ] && grep -q "build_runner" pubspec.yaml; then
    echo "🔨 Running code generation..."
    flutter pub run build_runner build --delete-conflicting-outputs
    print_success "Code generation complete"
    echo ""
fi

# Analyze code
echo "🔍 Analyzing code..."
if flutter analyze; then
    print_success "No analysis issues found"
else
    print_warning "Some analysis issues found. Review before releasing."
fi
echo ""

# Build function
build_debug_apk() {
    echo "🔨 Building debug APK..."
    flutter build apk --debug
    print_success "Debug APK built successfully"
    echo "📁 Location: build/app/outputs/flutter-apk/app-debug.apk"
}

build_release_apk() {
    echo "🔨 Building release APK..."
    if [ ! -f "android/key.properties" ]; then
        print_warning "No signing key configured. Building unsigned APK."
        flutter build apk --release
    else
        flutter build apk --release
    fi
    print_success "Release APK built successfully"
    echo "📁 Location: build/app/outputs/flutter-apk/app-release.apk"

    # Show APK size
    if [ -f "build/app/outputs/flutter-apk/app-release.apk" ]; then
        size=$(du -h build/app/outputs/flutter-apk/app-release.apk | cut -f1)
        echo "📊 APK Size: $size"
    fi
}

build_app_bundle() {
    echo "🔨 Building release App Bundle..."
    if [ ! -f "android/key.properties" ]; then
        print_error "Signing key required for App Bundle. Configure android/key.properties first."
        exit 1
    fi
    flutter build appbundle --release
    print_success "Release App Bundle built successfully"
    echo "📁 Location: build/app/outputs/bundle/release/app-release.aab"

    # Show bundle size
    if [ -f "build/app/outputs/bundle/release/app-release.aab" ]; then
        size=$(du -h build/app/outputs/bundle/release/app-release.aab | cut -f1)
        echo "📊 Bundle Size: $size"
    fi
}

# Execute based on choice
case $choice in
    1)
        build_debug_apk
        ;;
    2)
        build_release_apk
        ;;
    3)
        build_app_bundle
        ;;
    4)
        build_release_apk
        echo ""
        build_app_bundle
        ;;
    *)
        print_error "Invalid choice"
        exit 1
        ;;
esac

echo ""
echo "================================"
print_success "Build complete!"
echo ""

# Show next steps
if [ "$choice" == "2" ] || [ "$choice" == "4" ]; then
    echo "📱 Next steps:"
    echo "1. Test the APK on a device:"
    echo "   adb install build/app/outputs/flutter-apk/app-release.apk"
    echo ""
    echo "2. Or use Flutter:"
    echo "   flutter install"
fi

if [ "$choice" == "3" ] || [ "$choice" == "4" ]; then
    echo "🏪 To upload to Play Store:"
    echo "1. Go to Google Play Console"
    echo "2. Create a new release"
    echo "3. Upload build/app/outputs/bundle/release/app-release.aab"
    echo "4. Complete the release form"
    echo "5. Submit for review"
fi

echo ""
echo "✨ Happy building!"
