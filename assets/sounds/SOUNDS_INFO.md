# ArtJoy Sound Effects

This directory contains sound effect files for the app.

## Available Sounds

The following sound effects are used throughout the app:

1. **draw.mp3** - Played when starting to draw
2. **erase.mp3** - Played when using eraser
3. **undo.mp3** - Played on undo action
4. **save.mp3** - Played when saving a drawing
5. **achievement.mp3** - Played when unlocking an achievement
6. **button_tap.mp3** - Played on button taps
7. **page_turn.mp3** - Played when changing screens

## Usage in Code

Sounds are played via the AudioService:

```dart
final audioService = context.read<AudioService>();
audioService.playSound('draw');
```

## Format

- Format: MP3
- Sample Rate: 44100 Hz
- Bitrate: 128 kbps
- Mono audio

## License

All sound effects are either:
- Created specifically for this app
- Licensed from royalty-free sources
- Public domain

## Note for Production

Before publishing, ensure you have:
1. Actual audio files (not placeholders)
2. Proper licensing documentation
3. Appropriate file sizes (< 100KB each)

For now, the app uses silent/placeholder sounds in development mode.
The AudioService gracefully handles missing audio files.
