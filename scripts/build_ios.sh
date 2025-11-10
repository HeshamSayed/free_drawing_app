#!/bin/bash

# ArtJoy - iOS Build Script
# This script automates the iOS build process

set -e # Exit on error

echo "🍎 ArtJoy iOS Build Script"
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

# Check if on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "iOS builds can only be done on macOS"
    exit 1
fi

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    print_error "Flutter is not installed or not in PATH"
    exit 1
fi

print_success "Flutter found"

# Check if Xcode is installed
if ! command -v xcodebuild &> /dev/null; then
    print_error "Xcode is not installed"
    exit 1
fi

print_success "Xcode found"

# Get Flutter version
echo "Flutter version:"
flutter --version | head -n 1

echo ""
echo "Select build type:"
echo "1. Debug build (for testing on simulator)"
echo "2. Release build (for physical device)"
echo "3. Archive (for App Store submission)"
read -p "Enter choice [1-3]: " choice

echo ""

# Clean build
if [ "$1" == "--clean" ]; then
    echo "🧹 Cleaning build..."
    flutter clean
    rm -rf ios/Pods
    rm -rf ios/Podfile.lock
    print_success "Clean complete"
    echo ""
fi

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get
print_success "Dependencies fetched"
echo ""

# Install CocoaPods
echo "📦 Installing CocoaPods dependencies..."
cd ios
pod install --repo-update
cd ..
print_success "CocoaPods installed"
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
build_debug() {
    echo "🔨 Building debug version..."
    flutter build ios --debug --no-codesign
    print_success "Debug build complete"
    echo "📁 To run on simulator: flutter run"
}

build_release() {
    echo "🔨 Building release version..."
    flutter build ios --release
    print_success "Release build complete"
    echo "📁 Location: build/ios/iphoneos/"
    echo ""
    print_warning "To install on device, use Xcode or:"
    echo "flutter install"
}

build_archive() {
    echo "🔨 Building archive for App Store..."
    flutter build ios --release
    print_success "Flutter build complete"
    echo ""
    echo "📦 Creating Xcode archive..."
    echo ""
    print_warning "Next steps:"
    echo "1. Open ios/Runner.xcworkspace in Xcode"
    echo "2. Select 'Any iOS Device' as the target"
    echo "3. Go to Product > Archive"
    echo "4. Wait for archive to complete"
    echo "5. Click 'Distribute App'"
    echo "6. Choose 'App Store Connect'"
    echo "7. Follow the wizard to upload"
    echo ""
    echo "Or run this command:"
    echo "xcodebuild -workspace ios/Runner.xcworkspace -scheme Runner -configuration Release archive -archivePath build/Runner.xcarchive"
}

# Execute based on choice
case $choice in
    1)
        build_debug
        ;;
    2)
        build_release
        ;;
    3)
        build_archive
        ;;
    *)
        print_error "Invalid choice"
        exit 1
        ;;
esac

echo ""
echo "================================"
print_success "Build process complete!"
echo ""

# Show configuration tips
echo "💡 Tips:"
echo "• Ensure signing is configured in Xcode"
echo "• Use a physical device for release testing"
echo "• Test on multiple iOS versions"
echo "• Verify all features work before submission"

echo ""
echo "✨ Happy building!"
