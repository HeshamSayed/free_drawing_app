# Deployment Guide

This guide covers deploying ArtJoy to Google Play Store and Apple App Store.

## Pre-Deployment Checklist

- [ ] All features tested thoroughly
- [ ] Real AdMob Ad Unit IDs configured
- [ ] App icons added
- [ ] Privacy Policy reviewed and accurate
- [ ] Screenshots prepared (phone + tablet)
- [ ] App description written
- [ ] Signing keys generated
- [ ] Version numbers updated

## Google Play Store Deployment

### 1. Prepare App Bundle

1. **Update Version**

   Edit `pubspec.yaml`:
   ```yaml
   version: 1.0.0+1
   ```

2. **Build Release Bundle**
   ```bash
   flutter build appbundle --release
   ```

   Output: `build/app/outputs/bundle/release/app-release.aab`

### 2. Google Play Console Setup

1. Go to [Google Play Console](https://play.google.com/console)
2. Create new application
3. Fill in app details:
   - Title: **ArtJoy – Free Drawing & Coloring Game**
   - Short description (80 chars)
   - Full description (4000 chars max)
   - Category: Education / Entertainment
   - Tags: drawing, coloring, kids, art, creative

### 3. Store Listing

**Screenshots Required:**
- Phone: 2-8 screenshots (16:9 or 9:16)
- 7" Tablet: 1-8 screenshots
- 10" Tablet: 1-8 screenshots

**Graphic Assets:**
- High-res icon: 512x512 PNG
- Feature graphic: 1024x500 PNG
- (Optional) Promo video

### 4. Content Rating

Complete the questionnaire:
- App type: Drawing/Art app
- Target audience: All ages
- Contains ads: Yes
- Parental controls: No

### 5. App Content

- Privacy Policy URL: (host your PRIVACY_POLICY.md)
- Target audience: Ages 3+
- Ads: Yes (AdMob)

### 6. Upload App Bundle

1. Go to Release > Production
2. Create new release
3. Upload AAB file
4. Add release notes
5. Review and rollout

### 7. Pricing & Distribution

- Free app
- Select countries
- Designed for families: Yes (if applicable)

## Apple App Store Deployment

### 1. Prepare IPA

1. **Update Version**

   Same as Android in `pubspec.yaml`

2. **Build iOS Release**
   ```bash
   flutter build ios --release
   ```

3. **Archive in Xcode**
   - Open `ios/Runner.xcworkspace`
   - Select "Any iOS Device"
   - Product > Archive
   - Distribute App > App Store Connect

### 2. App Store Connect Setup

1. Go to [App Store Connect](https://appstoreconnect.apple.com/)
2. My Apps > + > New App
3. Fill in details:
   - Name: ArtJoy – Free Drawing & Coloring Game
   - Primary Language: English
   - Bundle ID: com.artjoy.free_drawing_app
   - SKU: artjoy-001

### 3. App Information

- Subtitle (30 chars)
- Description (4000 chars max)
- Keywords (100 chars)
- Category: Education / Entertainment
- Age Rating: 4+

### 4. Screenshots

**Required for:**
- iPhone 6.7" display
- iPhone 6.5" display
- iPhone 5.5" display
- iPad Pro (12.9")
- iPad Pro (11")

Use [Screenshot Frames](https://www.appscreenshots.com/) for professional mockups.

### 5. App Review Information

- Demo account (if needed)
- Notes for reviewer
- Contact information

### 6. Submit for Review

- Upload build from Xcode
- Complete all required fields
- Submit for App Review
- Wait 1-3 days for approval

## Post-Deployment

### Monitor Performance

1. **Google Play Console**
   - Crashes & ANRs
   - User reviews
   - Statistics

2. **App Store Connect**
   - Crashes
   - App Analytics
   - Reviews

3. **AdMob Dashboard**
   - Revenue
   - Ad performance
   - Fill rates

### Update Process

1. Fix bugs or add features
2. Increment version number
3. Build new release
4. Upload to stores
5. Add release notes

### Marketing

- Share on social media
- Create demo videos
- Engage with user reviews
- Run ad campaigns (optional)

## Troubleshooting

### Google Play

**Issue: Upload failed**
- Check signing configuration
- Verify version code is incremented
- Ensure target API level meets requirements

**Issue: Rejected due to content**
- Review content policies
- Update age rating if needed
- Provide detailed description

### App Store

**Issue: Binary rejected**
- Check for crashes
- Verify all required permissions explained
- Follow Human Interface Guidelines

**Issue: Metadata rejected**
- Ensure screenshots match actual app
- Remove promotional text from description
- Fix any misleading information

## Important Notes

- **Never** commit signing keys to Git
- Test on real devices before submission
- Keep test accounts for reviewers
- Respond to reviews promptly
- Monitor crash reports daily

## Support

After launch:
- Set up support email
- Monitor app reviews
- Update regularly
- Engage with users

Good luck with your launch! 🚀
