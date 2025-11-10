# ArtJoy - Complete Testing Guide

## 🧪 QUICK START

```bash
# 1. Get all dependencies
flutter pub get

# 2. Run the app
flutter run

# 3. (Optional) Run on release mode for better performance
flutter run --release
```

---

## 📝 FEATURE TESTING CHECKLIST

### 1. First Launch Experience

#### Onboarding Flow
- [ ] App shows splash screen on launch
- [ ] Onboarding tutorial displays (5 pages)
- [ ] Can navigate through pages with arrow buttons
- [ ] Can skip onboarding with "Skip" button
- [ ] Page indicators work correctly (dots at bottom)
- [ ] Final page has "Get Started" button
- [ ] After completion, goes to Home Screen
- [ ] On second launch, onboarding is skipped (goes directly to Home)

**Test Command:**
```bash
# Reset onboarding to test again
flutter run
# Then in the app, go to Settings > Data Management > Clear All Drawings
# Or clear app data manually from device settings
```

---

### 2. Home Screen

#### UI Elements
- [ ] Welcome card displays with gradient background
- [ ] Drawing count shows correctly (starts at 0)
- [ ] 6 quick action cards display:
  - Free Draw (purple)
  - Coloring (pink)
  - Gallery (yellow)
  - Achievements (green)
  - Daily Challenge (purple)
  - Premium (orange)
- [ ] Recent drawings section shows "No drawings yet!" when empty
- [ ] Settings icon in app bar works
- [ ] Banner ad displays at bottom (if not premium)

#### Navigation
- [ ] Free Draw button opens Drawing Screen
- [ ] Coloring button opens Coloring Screen
- [ ] Gallery button opens Gallery Screen
- [ ] Achievements button opens Achievements Screen
- [ ] Daily Challenge button opens Daily Challenge Screen
- [ ] Premium button shows Premium dialog
- [ ] Settings button opens Settings Screen

---

### 3. Drawing Screen (Free Draw)

#### Drawing Tools
- [ ] Can draw on canvas with touch
- [ ] Brush size slider works (1-50px)
- [ ] Brush size preview circle updates
- [ ] All 6 brush types work:
  - **Pen:** Solid lines, constant opacity
  - **Marker:** Semi-transparent, blendable
  - **Pencil:** Textured effect
  - **Neon:** Glowing effect
  - **Watercolor:** Soft, flowing effect
  - **Eraser:** Removes strokes

#### Color Picker
- [ ] Color palette opens when tapping color button
- [ ] 20+ preset colors available
- [ ] HSV color picker works (hue slider, saturation-value grid)
- [ ] Opacity slider works (0-100%)
- [ ] Selected color displays in picker button
- [ ] Custom colors can be selected and used

#### Controls
- [ ] Undo button removes last stroke
- [ ] Redo button restores undone stroke
- [ ] Undo button disabled when no strokes
- [ ] Redo button disabled when nothing to redo
- [ ] Clear button shows confirmation dialog
- [ ] Clear confirms and clears canvas
- [ ] Clear cancels and keeps canvas

#### Gestures
- [ ] Pinch to zoom in/out works
- [ ] Two-finger drag to pan works
- [ ] Can zoom in very close
- [ ] Can zoom out to see full canvas
- [ ] Drawing works at any zoom level
- [ ] Pan boundaries prevent infinite scrolling

#### Saving
- [ ] Save dialog appears when tapping save button
- [ ] Can enter custom drawing name
- [ ] Default name is "Drawing_[date]"
- [ ] Save button saves and returns to home
- [ ] Saved drawing appears in "Recent Drawings"
- [ ] Saved drawing count increments

#### Export & Share
- [ ] Export menu (share icon) shows 3 options:
  - Export as PNG
  - Save to Gallery
  - Share Drawing
- [ ] Export as PNG saves to app directory
- [ ] Save to Gallery requests permission (if needed)
- [ ] Save to Gallery adds to device gallery
- [ ] Share Drawing opens system share sheet
- [ ] All export options show success message

---

### 4. Coloring Screen

#### Page Selection
- [ ] Coloring page selection screen displays
- [ ] 3+ coloring pages available (cat, car, flower)
- [ ] Locked pages show lock icon (if not premium)
- [ ] Can preview pages by tapping
- [ ] Selected page opens in coloring mode

#### Coloring Features
- [ ] Pre-drawn outline displays
- [ ] Can color within the outline
- [ ] All drawing tools work (brush, color picker)
- [ ] Undo/Redo works
- [ ] Save works
- [ ] Export/Share works
- [ ] Colored pages save separately from free drawings

#### Unlocking Pages
- [ ] Locked page shows "Watch Ad to Unlock" button
- [ ] Rewarded ad plays (test ad in debug mode)
- [ ] After ad completes, page unlocks
- [ ] Unlocked page stays unlocked permanently
- [ ] Premium users see all pages unlocked

---

### 5. Gallery Screen

#### Display
- [ ] All saved drawings display in grid
- [ ] Each card shows drawing preview (icon for now)
- [ ] Drawing name displays
- [ ] Creation date displays
- [ ] Grid is scrollable
- [ ] Empty gallery shows "No drawings yet"

#### Search
- [ ] Search bar at top works
- [ ] Can search by drawing name
- [ ] Results filter in real-time
- [ ] Clear search shows all drawings again

#### Actions
- [ ] Tap drawing card opens it in Drawing Screen
- [ ] Can edit existing drawing
- [ ] Changes save to same drawing (not duplicate)
- [ ] Delete button on drawing card works
- [ ] Delete confirmation dialog appears
- [ ] Delete removes drawing from gallery

#### Ads
- [ ] Banner ad displays at bottom (if not premium)
- [ ] Ad doesn't interfere with scrolling
- [ ] Premium users see no ads

---

### 6. Achievements Screen

#### Display
- [ ] Achievement progress card shows X/7 unlocked
- [ ] All 7 achievements display:
  1. First Drawing (Create your first drawing)
  2. Artist in the Making (Create 10 drawings)
  3. Drawing Master (Create 50 drawings)
  4. Colorful Creator (Use 10 unique colors)
  5. Rainbow Master (Use 20 unique colors)
  6. Speed Painter (Complete a drawing in under 2 minutes)
  7. Perfectionist (Use undo/redo 50 times)

#### Achievement Cards
- [ ] Locked achievements show gray/disabled state
- [ ] Unlocked achievements show colored with checkmark
- [ ] Progress bar shows current progress
- [ ] Progress percentage displays (e.g., "5/10 - 50%")
- [ ] Unlock date shows for completed achievements

#### Unlocking
- [ ] Create first drawing unlocks "First Drawing"
- [ ] Achievement dialog pops up on unlock
- [ ] Dialog shows achievement icon, title, description
- [ ] Multiple achievements can unlock simultaneously
- [ ] Unlocks persist after app restart

---

### 7. Daily Challenge Screen

#### Challenge Display
- [ ] Current daily challenge displays
- [ ] Challenge icon shows
- [ ] Challenge title and description display
- [ ] Difficulty indicator shows (Easy/Medium/Hard)
- [ ] Reward points display
- [ ] Tips section shows 2-3 helpful tips

#### Challenge Rotation
- [ ] Same challenge shows for entire day
- [ ] Challenge changes at midnight
- [ ] All users see same challenge each day
- [ ] Can complete challenge once per day

#### Completion
- [ ] "Start Challenge" button opens Drawing Screen
- [ ] Completing challenge marks it as complete
- [ ] Completed state shows checkmark
- [ ] "Already completed today!" message shows
- [ ] Reward points add to user's total (if tracked)

---

### 8. Settings Screen

#### App Settings Section
- [ ] Dark Mode toggle works
  - Toggles between light and dark theme
  - Theme persists after app restart
  - All screens respect theme setting
- [ ] Sound Effects toggle works
  - Enables/disables sound effects
  - Setting persists after app restart

#### Premium Section
- [ ] Shows "Upgrade to Premium" if not premium
- [ ] Shows "Premium Active" if premium
- [ ] Tap upgrade opens premium dialog
- [ ] Premium dialog lists all benefits:
  - Remove all ads
  - All brushes unlocked instantly
  - Access to all coloring pages
  - Export HD quality images
  - Priority customer support
- [ ] "Upgrade Now" activates premium (demo mode)
- [ ] After upgrade, ads disappear app-wide

#### Statistics Section
- [ ] Total Drawings count is accurate
- [ ] Sessions count increments on each launch
- [ ] Unlocked Brushes shows X/6
- [ ] Counts update in real-time

#### Features Section
- [ ] Achievements link opens Achievements Screen
- [ ] Shows progress (X/7 unlocked)
- [ ] Daily Challenge link opens Daily Challenge Screen

#### Data Management Section
- [ ] "Clear All Drawings" shows confirmation
- [ ] Confirmation warns about permanent deletion
- [ ] Cancel preserves drawings
- [ ] Delete removes all drawings
- [ ] Gallery becomes empty after deletion
- [ ] Drawing count resets to 0

#### About Section
- [ ] Version displays correctly (1.0.0)
- [ ] App name displays: "ArtJoy"
- [ ] Subtitle: "Free Drawing & Coloring Game"

---

### 9. Ads Testing

#### Banner Ads
- [ ] Display on Home Screen (bottom)
- [ ] Display on Gallery Screen (bottom)
- [ ] Don't display on Drawing/Coloring Screen (no interruption)
- [ ] Don't display if premium
- [ ] Respect safe area (don't cover content)

#### Interstitial Ads
- [ ] Show after every 4 app sessions
- [ ] 10-minute cooldown between ads
- [ ] Don't show if premium
- [ ] Don't interrupt active drawing
- [ ] Show between screen transitions

#### Rewarded Ads
- [ ] Available to unlock coloring pages
- [ ] "Watch Ad to Unlock" button shows
- [ ] Ad plays when tapped
- [ ] Reward granted after completion
- [ ] Page unlocks permanently
- [ ] Can skip if premium

**Note:** In debug/test mode, ads use Google's test IDs and show test ads.

---

### 10. State Persistence

#### Test Procedure:
1. Create some drawings
2. Unlock an achievement
3. Complete a daily challenge
4. Change some settings (dark mode, sound)
5. Close the app completely
6. Reopen the app

#### Verify:
- [ ] All drawings still in gallery
- [ ] Achievements still unlocked
- [ ] Settings still applied (dark mode, sound)
- [ ] Daily challenge completion remembered
- [ ] Session count incremented
- [ ] Onboarding doesn't show again

---

### 11. Performance Testing

#### Canvas Performance
- [ ] Drawing is smooth with no lag
- [ ] No dropped frames during drawing
- [ ] Zoom is smooth
- [ ] Pan is responsive
- [ ] Undo/Redo is instant

#### App Launch
- [ ] Splash screen appears immediately
- [ ] App loads in under 3 seconds
- [ ] No white screen flashing
- [ ] Smooth transition to home

#### Memory
- [ ] App doesn't crash with large drawings
- [ ] Can create 50+ drawings without issues
- [ ] Gallery scrolling is smooth
- [ ] No memory leaks over time

---

### 12. Edge Cases & Error Handling

#### Empty States
- [ ] Empty gallery shows helpful message
- [ ] Empty recent drawings shows message
- [ ] No achievements shows 0/7 progress

#### Validation
- [ ] Cannot save drawing without name
- [ ] Invalid characters in name handled
- [ ] Very long names truncated

#### Permissions
- [ ] Gallery save requests permission gracefully
- [ ] Permission denial shows error message
- [ ] App continues working if permission denied

#### Network
- [ ] Ads fail gracefully if no internet
- [ ] App works completely offline
- [ ] No crashes due to network errors

---

## 🐛 COMMON ISSUES & FIXES

### Issue: "MissingPluginException"
**Fix:**
```bash
flutter clean
flutter pub get
flutter run
```

### Issue: Ads not showing
**Possible causes:**
- Using test IDs (expected in debug)
- No internet connection
- AdMob not initialized
- Premium mode active

### Issue: Hive errors
**Fix:**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Issue: Dark theme not applying
**Fix:**
- Check Settings Service initialization
- Verify theme mode in MaterialApp
- Restart app after toggling

---

## 📊 TEST METRICS

Track these metrics during testing:

- **Crash Rate:** 0% target
- **Successful Saves:** 100% target
- **Ad Load Rate:** >80% target
- **Screen Load Time:** <1 second target
- **Drawing Smoothness:** 60 FPS target

---

## ✅ FINAL VERIFICATION

Before launching, ensure:
- [ ] All features work on physical device
- [ ] Tested on Android (minimum 5.0)
- [ ] Tested on iOS (minimum 12.0)
- [ ] No console errors or warnings
- [ ] All ads loading (production IDs)
- [ ] App icon displays correctly
- [ ] Signing works (can install release build)
- [ ] Privacy policy accessible
- [ ] Terms of service accessible (if applicable)

---

## 🎯 AUTOMATED TESTING (Optional)

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

---

## 📱 DEVICE TESTING CHECKLIST

Test on various devices:

- [ ] Small phone (5" screen)
- [ ] Large phone (6.5" screen)
- [ ] Tablet (10" screen)
- [ ] Different Android versions (5.0, 10.0, 13.0)
- [ ] Different iOS versions (12.0, 15.0, 17.0)
- [ ] Both portrait and landscape orientations

---

## ✨ READY TO LAUNCH

When all tests pass:
1. Replace test Ad Unit IDs
2. Build release version
3. Test release build thoroughly
4. Submit to app stores

**Congratulations! Your app is ready! 🎉**
