# ArtJoy Images Directory

This directory contains image assets used throughout the app.

## Recommended Images

For a complete app experience, add these images:

### 1. Onboarding Images
- `onboarding_1.png` - Welcome illustration (800x600)
- `onboarding_2.png` - Drawing features illustration (800x600)
- `onboarding_3.png` - Coloring features illustration (800x600)
- `onboarding_4.png` - Gallery illustration (800x600)
- `onboarding_5.png` - Sharing illustration (800x600)

### 2. Empty State Images
- `empty_gallery.png` - Illustration for empty gallery (400x400)
- `no_drawings.png` - Illustration when no drawings exist (400x400)
- `no_search_results.png` - Illustration for empty search (400x400)

### 3. Feature Illustrations
- `achievement_unlocked.png` - Achievement unlock celebration (300x300)
- `daily_challenge.png` - Daily challenge illustration (400x400)
- `premium_badge.png` - Premium features illustration (200x200)

### 4. UI Elements
- `brush_preview_pen.png` - Pen brush preview (100x100)
- `brush_preview_marker.png` - Marker brush preview (100x100)
- `brush_preview_pencil.png` - Pencil brush preview (100x100)
- `brush_preview_neon.png` - Neon brush preview (100x100)
- `brush_preview_watercolor.png` - Watercolor brush preview (100x100)

### 5. Tutorial/Help
- `gesture_zoom.png` - Pinch to zoom gesture (200x200)
- `gesture_pan.png` - Pan gesture (200x200)
- `gesture_draw.png` - Drawing gesture (200x200)

## Current Status

⚠️ This directory contains placeholder documentation.
For production, add actual image files.

## Image Guidelines

### Format
- Use PNG for images with transparency
- Use JPG for photos/complex illustrations
- Use WebP for smaller file sizes (if supported)

### Size Recommendations
- Keep individual images under 500KB
- Use @2x and @3x variants for iOS
- Compress images before adding to project

### Tools for Creating Images
- **Illustrations**: Figma, Adobe Illustrator, Inkscape
- **Photo editing**: Photoshop, GIMP, Photopea
- **Compression**: TinyPNG, ImageOptim, Squoosh

### Free Illustration Resources
- unDraw: https://undraw.co
- Freepik: https://www.freepik.com
- Icons8 Illustrations: https://icons8.com/illustrations
- Blush: https://blush.design

## Integration in Code

Images are loaded using:

```dart
Image.asset('assets/images/empty_gallery.png')
```

Or with better error handling:

```dart
Image.asset(
  'assets/images/empty_gallery.png',
  width: 200,
  height: 200,
  errorBuilder: (context, error, stackTrace) {
    return Icon(Icons.image_not_supported, size: 200);
  },
)
```

## Optional: Image Caching

For better performance, consider using:
```dart
precacheImage(AssetImage('assets/images/onboarding_1.png'), context);
```

## Notes

- The app currently uses Icons instead of images for most UI elements
- This keeps the app size small and performance high
- Images are optional enhancements for visual appeal
- The app functions fully without custom images
