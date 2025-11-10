import 'package:flutter_test/flutter_test.dart';
import 'package:artjoy/utils/validators.dart';

void main() {
  group('Drawing Name Validation', () {
    test('Valid drawing names', () {
      expect(Validators.validateDrawingName('My Drawing'), null);
      expect(Validators.validateDrawingName('Drawing 123'), null);
      expect(Validators.validateDrawingName('test_drawing'), null);
    });

    test('Invalid - null or empty', () {
      expect(Validators.validateDrawingName(null), isNotNull);
      expect(Validators.validateDrawingName(''), isNotNull);
      expect(Validators.validateDrawingName('   '), isNotNull);
    });

    test('Invalid - too short', () {
      expect(Validators.validateDrawingName('a'), isNotNull);
    });

    test('Invalid - too long', () {
      final longName = 'a' * 51;
      expect(Validators.validateDrawingName(longName), isNotNull);
    });

    test('Invalid - invalid characters', () {
      expect(Validators.validateDrawingName('test<>'), isNotNull);
      expect(Validators.validateDrawingName('test:name'), isNotNull);
      expect(Validators.validateDrawingName('test/name'), isNotNull);
    });
  });

  group('Hex Color Validation', () {
    test('Valid hex colors', () {
      expect(Validators.isValidHexColor('#FF0000'), true);
      expect(Validators.isValidHexColor('FF0000'), true);
      expect(Validators.isValidHexColor('#00FF00AA'), true);
      expect(Validators.isValidHexColor('00FF00AA'), true);
    });

    test('Invalid hex colors', () {
      expect(Validators.isValidHexColor('red'), false);
      expect(Validators.isValidHexColor('#GG0000'), false);
      expect(Validators.isValidHexColor('#FF'), false);
      expect(Validators.isValidHexColor(''), false);
    });
  });

  group('Brush Size Validation', () {
    test('Valid brush sizes', () {
      expect(Validators.validateBrushSize(1), null);
      expect(Validators.validateBrushSize(25), null);
      expect(Validators.validateBrushSize(50), null);
    });

    test('Invalid - null', () {
      expect(Validators.validateBrushSize(null), isNotNull);
    });

    test('Invalid - out of range', () {
      expect(Validators.validateBrushSize(0), isNotNull);
      expect(Validators.validateBrushSize(51), isNotNull);
    });
  });

  group('Opacity Validation', () {
    test('Valid opacity values', () {
      expect(Validators.validateOpacity(0), null);
      expect(Validators.validateOpacity(0.5), null);
      expect(Validators.validateOpacity(1), null);
    });

    test('Invalid opacity values', () {
      expect(Validators.validateOpacity(null), isNotNull);
      expect(Validators.validateOpacity(-0.1), isNotNull);
      expect(Validators.validateOpacity(1.1), isNotNull);
    });
  });

  group('Email Validation', () {
    test('Valid emails', () {
      expect(Validators.isValidEmail('test@example.com'), true);
      expect(Validators.isValidEmail('user.name@domain.co.uk'), true);
      expect(Validators.isValidEmail('user+tag@example.com'), true);
    });

    test('Invalid emails', () {
      expect(Validators.isValidEmail('invalid'), false);
      expect(Validators.isValidEmail('invalid@'), false);
      expect(Validators.isValidEmail('@example.com'), false);
      expect(Validators.isValidEmail(''), false);
    });
  });

  group('Range Validation', () {
    test('Values in range', () {
      expect(Validators.isInRange(5, 0, 10), true);
      expect(Validators.isInRange(0, 0, 10), true);
      expect(Validators.isInRange(10, 0, 10), true);
    });

    test('Values out of range', () {
      expect(Validators.isInRange(-1, 0, 10), false);
      expect(Validators.isInRange(11, 0, 10), false);
    });
  });

  group('Input Sanitization', () {
    test('Sanitize removes harmful characters', () {
      expect(Validators.sanitizeInput('test<script>'), 'testscript');
      expect(Validators.sanitizeInput('hello\nworld'), 'hello world');
      expect(Validators.sanitizeInput('  spaced  '), 'spaced');
    });
  });

  group('Null or Empty Check', () {
    test('Null or empty strings', () {
      expect(Validators.isNullOrEmpty(null), true);
      expect(Validators.isNullOrEmpty(''), true);
      expect(Validators.isNullOrEmpty('   '), true);
    });

    test('Non-empty strings', () {
      expect(Validators.isNullOrEmpty('text'), false);
      expect(Validators.isNullOrEmpty(' text '), false);
    });
  });
}
