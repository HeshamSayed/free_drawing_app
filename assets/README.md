# Assets Directory

This directory contains all the app assets including images, sounds, animations, and coloring pages.

## Structure

```
assets/
├── images/           # App images and icons
├── sounds/           # Audio files for sound effects
├── animations/       # Rive/Lottie animation files
├── coloring_pages/   # SVG or PNG coloring page templates
└── fonts/            # Custom fonts (Fredoka)
```

## Adding Assets

### Images
Place app images, icons, and graphics in the `images/` folder.
Supported formats: PNG, JPG, SVG

### Sounds
Add sound effect files to the `sounds/` folder.
Recommended format: MP3 or OGG
Files needed:
- brush_stroke.mp3
- success.mp3
- click.mp3
- unlock.mp3

### Animations
Add Rive (.riv) or Lottie (.json) animation files to `animations/`.

### Coloring Pages
Add coloring page templates (SVG or PNG) to `coloring_pages/`.
Name them according to their IDs (e.g., cat.svg, flower.svg, etc.)

### Fonts
The Fredoka font family should be added to the `fonts/` folder:
- Fredoka-Regular.ttf
- Fredoka-Bold.ttf

Download from: https://fonts.google.com/specimen/Fredoka

## Notes

- All assets must be referenced in `pubspec.yaml`
- Optimize images for mobile (use appropriate sizes)
- Keep total asset size under 50MB for faster downloads
- Test all assets on both iOS and Android
