#!/bin/bash

# ArtJoy - Project Clean Script
# Cleans build artifacts and caches

echo "🧹 ArtJoy Project Cleaner"
echo "================================"
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

echo "This will clean:"
echo "• Flutter build cache"
echo "• Generated files"
echo "• iOS Pods"
echo "• Android build artifacts"
echo ""

read -p "Continue? (y/n): " confirm

if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo "Cancelled"
    exit 0
fi

echo ""

# Clean Flutter
echo "🧹 Cleaning Flutter build..."
flutter clean
print_success "Flutter clean complete"
echo ""

# Remove generated files
echo "🧹 Removing generated files..."
rm -rf .dart_tool/
rm -rf build/
rm -rf .flutter-plugins
rm -rf .flutter-plugins-dependencies
print_success "Generated files removed"
echo ""

# Clean iOS
if [ -d "ios" ]; then
    echo "🧹 Cleaning iOS..."
    rm -rf ios/Pods/
    rm -rf ios/Podfile.lock
    rm -rf ios/.symlinks/
    rm -rf ios/Flutter/Flutter.framework
    rm -rf ios/Flutter/Flutter.podspec
    print_success "iOS cleaned"
    echo ""
fi

# Clean Android
if [ -d "android" ]; then
    echo "🧹 Cleaning Android..."
    cd android
    ./gradlew clean 2>/dev/null || print_warning "Gradle clean failed (may not be set up yet)"
    cd ..
    rm -rf android/.gradle
    rm -rf android/app/build
    print_success "Android cleaned"
    echo ""
fi

# Remove coverage
echo "🧹 Removing coverage files..."
rm -rf coverage/
print_success "Coverage files removed"
echo ""

echo "================================"
print_success "Clean complete!"
echo ""
echo "Run './scripts/setup_project.sh' to set up again"
echo ""
