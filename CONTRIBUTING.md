# Contributing to ArtJoy

Thank you for your interest in contributing to ArtJoy! This document provides guidelines for contributing to the project.

## Getting Started

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/yourusername/free_drawing_app.git
   cd free_drawing_app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Create a new branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## Development Guidelines

### Code Style

- Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused
- Use const constructors where possible

### Project Structure

```
lib/
├── models/          # Data models
├── services/        # Business logic
├── screens/         # UI screens
├── widgets/         # Reusable widgets
└── utils/           # Utilities and helpers
```

### Testing

- Write tests for new features
- Ensure existing tests pass:
  ```bash
  flutter test
  ```
- Aim for good test coverage

### Commit Messages

Use clear, descriptive commit messages:
- `feat: Add new brush type`
- `fix: Correct color picker selection`
- `docs: Update README`
- `refactor: Improve drawing performance`
- `test: Add tests for DrawingController`

## Pull Request Process

1. Update documentation for any new features
2. Add tests for new functionality
3. Ensure all tests pass
4. Update CHANGELOG.md
5. Submit pull request with clear description

### PR Description Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
How has this been tested?

## Checklist
- [ ] Code follows project style
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] CHANGELOG.md updated
```

## Feature Requests

We welcome feature requests! Please:
1. Check if the feature already exists or is planned
2. Open an issue with the `enhancement` label
3. Clearly describe the feature and use case
4. Include mockups or examples if applicable

## Bug Reports

When reporting bugs, please include:
1. Clear title and description
2. Steps to reproduce
3. Expected vs actual behavior
4. Screenshots if applicable
5. Device/OS information
6. App version

## Code of Conduct

### Our Standards

- Be respectful and inclusive
- Accept constructive criticism
- Focus on what's best for the project
- Show empathy towards others

### Unacceptable Behavior

- Harassment or discrimination
- Trolling or insulting comments
- Personal or political attacks
- Publishing others' private information

## Questions?

Feel free to:
- Open an issue for questions
- Reach out to maintainers
- Check existing documentation

Thank you for contributing! 🎨
