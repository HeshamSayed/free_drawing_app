#!/bin/bash

# ArtJoy - Project Setup Script
# Sets up the project for first-time use

set -e

echo "🚀 ArtJoy Project Setup"
echo "================================"
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Check Flutter installation
echo "1️⃣  Checking Flutter installation..."
if ! command -v flutter &> /dev/null; then
    print_error "Flutter is not installed"
    echo ""
    echo "Please install Flutter from: https://flutter.dev/docs/get-started/install"
    exit 1
fi
print_success "Flutter is installed"
flutter --version | head -n 1
echo ""

# Run Flutter doctor
echo "2️⃣  Running Flutter doctor..."
flutter doctor
echo ""

# Get dependencies
echo "3️⃣  Getting Flutter dependencies..."
flutter pub get
print_success "Dependencies installed"
echo ""

# Run code generation
echo "4️⃣  Running code generation..."
if grep -q "build_runner" pubspec.yaml; then
    flutter pub run build_runner build --delete-conflicting-outputs
    print_success "Code generation complete"
else
    print_info "No code generation needed"
fi
echo ""

# Setup iOS (if on macOS)
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "5️⃣  Setting up iOS dependencies..."
    if command -v pod &> /dev/null; then
        cd ios
        pod install --repo-update
        cd ..
        print_success "CocoaPods installed"
    else
        print_warning "CocoaPods not installed. iOS builds will not work."
        echo "Install with: sudo gem install cocoapods"
    fi
    echo ""
fi

# Verify project structure
echo "6️⃣  Verifying project structure..."
if [ -f "verify_structure.sh" ]; then
    chmod +x verify_structure.sh
    ./verify_structure.sh
else
    print_warning "Structure verification script not found"
fi
echo ""

# Check for connected devices
echo "7️⃣  Checking for devices..."
flutter devices
echo ""

# Create useful directories
echo "8️⃣  Creating development directories..."
mkdir -p screenshots
mkdir -p coverage
mkdir -p build_outputs
print_success "Directories created"
echo ""

# Make scripts executable
echo "9️⃣  Making scripts executable..."
chmod +x scripts/*.sh 2>/dev/null || print_info "No scripts to make executable"
print_success "Scripts ready"
echo ""

echo "================================"
print_success "Setup complete!"
echo ""

echo "📱 Next steps:"
echo ""
echo "1. Run the app:"
echo "   flutter run"
echo ""
echo "2. Run tests:"
echo "   ./scripts/run_tests.sh"
echo ""
echo "3. Build for Android:"
echo "   ./scripts/build_android.sh"
echo ""
echo "4. Build for iOS (macOS only):"
echo "   ./scripts/build_ios.sh"
echo ""
echo "5. Read the documentation:"
echo "   cat QUICKSTART.md"
echo ""

print_success "You're all set! Happy coding! ✨"
