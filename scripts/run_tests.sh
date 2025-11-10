#!/bin/bash

# ArtJoy - Test Runner Script
# Runs all tests with coverage

set -e

echo "🧪 ArtJoy Test Suite"
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

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Check Flutter
if ! command -v flutter &> /dev/null; then
    print_error "Flutter not found"
    exit 1
fi

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get
print_success "Dependencies ready"
echo ""

# Run code analysis
echo "🔍 Running code analysis..."
if flutter analyze; then
    print_success "Code analysis passed"
else
    print_error "Code analysis found issues"
    exit 1
fi
echo ""

# Run tests
echo "🧪 Running tests..."
if [ "$1" == "--coverage" ]; then
    echo "Running with coverage..."
    flutter test --coverage
    print_success "Tests passed with coverage"
    echo ""
    echo "📊 Coverage report generated: coverage/lcov.info"
    echo ""

    # Generate HTML coverage report if lcov is installed
    if command -v genhtml &> /dev/null; then
        echo "📈 Generating HTML coverage report..."
        genhtml coverage/lcov.info -o coverage/html
        print_success "HTML report generated: coverage/html/index.html"
        echo ""
        echo "To view: open coverage/html/index.html"
    fi
else
    flutter test
    print_success "All tests passed"
fi

echo ""
echo "================================"
print_success "Test suite complete!"
echo ""

# Show statistics
if [ -d "test" ]; then
    test_count=$(find test -name "*_test.dart" | wc -l)
    echo "📊 Test files: $test_count"
fi

echo ""
echo "✨ Great work!"
