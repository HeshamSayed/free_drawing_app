#!/bin/bash

# ArtJoy - Structure Verification Script
# This script verifies that all essential files are present

echo "🔍 ArtJoy Structure Verification"
echo "================================"
echo ""

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counter
passed=0
failed=0

# Function to check file existence
check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✓${NC} $1"
        ((passed++))
    else
        echo -e "${RED}✗${NC} $1 ${RED}[MISSING]${NC}"
        ((failed++))
    fi
}

# Function to check directory existence
check_dir() {
    if [ -d "$1" ]; then
        echo -e "${GREEN}✓${NC} $1/"
        ((passed++))
    else
        echo -e "${RED}✗${NC} $1/ ${RED}[MISSING]${NC}"
        ((failed++))
    fi
}

echo "📁 Core Files:"
check_file "pubspec.yaml"
check_file "lib/main.dart"
check_file "README.md"
check_file "SETUP.md"
echo ""

echo "📱 Models (5 files):"
check_file "lib/models/drawing.dart"
check_file "lib/models/settings.dart"
check_file "lib/models/unlocked_content.dart"
check_file "lib/models/achievement.dart"
echo ""

echo "🔧 Services (7 files):"
check_file "lib/services/database_service.dart"
check_file "lib/services/settings_service.dart"
check_file "lib/services/ads_service.dart"
check_file "lib/services/audio_service.dart"
check_file "lib/services/achievement_service.dart"
check_file "lib/services/daily_challenge_service.dart"
check_file "lib/services/export_service.dart"
echo ""

echo "🖥️  Screens (10 files):"
check_file "lib/screens/home_screen.dart"
check_file "lib/screens/drawing_screen.dart"
check_file "lib/screens/gallery_screen.dart"
check_file "lib/screens/coloring_screen.dart"
check_file "lib/screens/settings_screen.dart"
check_file "lib/screens/achievements_screen.dart"
check_file "lib/screens/daily_challenge_screen.dart"
check_file "lib/screens/onboarding_screen.dart"
check_file "lib/screens/splash_screen.dart"
echo ""

echo "🎨 Widgets:"
check_file "lib/widgets/brush_selector.dart"
check_file "lib/widgets/color_picker_widget.dart"
check_file "lib/widgets/drawing_canvas.dart"
check_file "lib/widgets/achievement_dialog.dart"
check_file "lib/widgets/loading_overlay.dart"
echo ""

echo "🛠️  Utils:"
check_file "lib/utils/constants.dart"
check_file "lib/utils/helpers.dart"
check_file "lib/utils/theme.dart"
check_file "lib/utils/drawing_controller.dart"
echo ""

echo "🤖 Android Config:"
check_file "android/app/src/main/AndroidManifest.xml"
check_file "android/app/build.gradle"
check_file "android/build.gradle"
echo ""

echo "🍎 iOS Config:"
check_file "ios/Runner/Info.plist"
check_file "ios/Podfile"
echo ""

echo "📦 Assets:"
check_dir "assets/images"
check_dir "assets/sounds"
check_dir "assets/fonts"
check_dir "assets/coloring_pages"
echo ""

echo "📚 Documentation:"
check_file "README.md"
check_file "SETUP.md"
check_file "DEPLOYMENT.md"
check_file "PRIVACY_POLICY.md"
check_file "COMPLETE_IMPLEMENTATION.md"
check_file "PRODUCTION_READINESS.md"
check_file "TESTING_GUIDE.md"
echo ""

echo "================================"
echo "Results:"
echo -e "${GREEN}Passed: $passed${NC}"
echo -e "${RED}Failed: $failed${NC}"
echo ""

if [ $failed -eq 0 ]; then
    echo -e "${GREEN}✅ All essential files present!${NC}"
    echo -e "${GREEN}Your ArtJoy app structure is complete.${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Run: flutter pub get"
    echo "2. Run: flutter run"
    echo "3. See PRODUCTION_READINESS.md for launch checklist"
    exit 0
else
    echo -e "${YELLOW}⚠️  Some files are missing.${NC}"
    echo "This might be normal depending on your setup."
    exit 1
fi
