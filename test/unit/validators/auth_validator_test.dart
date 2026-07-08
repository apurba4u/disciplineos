import 'package:flutter_test/flutter_test.dart';
import 'package:discipline_os/shared/validators/auth_validator.dart';

void main() {
  group('AuthValidator', () {
    group('validateEmail', () {
      test('returns null for valid email', () {
        expect(AuthValidator.validateEmail('test@example.com'), isNull);
      });

      test('returns error for empty email', () {
        expect(AuthValidator.validateEmail(''), isNotNull);
      });

      test('returns error for null email', () {
        expect(AuthValidator.validateEmail(null), isNotNull);
      });

      test('returns error for invalid email format', () {
        expect(AuthValidator.validateEmail('invalid'), isNotNull);
        expect(AuthValidator.validateEmail('test@'), isNotNull);
        expect(AuthValidator.validateEmail('@example.com'), isNotNull);
      });
    });

    group('validatePassword', () {
      test('returns null for valid password', () {
        expect(AuthValidator.validatePassword('password123'), isNull);
      });

      test('returns error for empty password', () {
        expect(AuthValidator.validatePassword(''), isNotNull);
      });

      test('returns error for password less than 8 chars', () {
        expect(AuthValidator.validatePassword('short'), isNotNull);
      });
    });

    group('validateConfirmPassword', () {
      test('returns null when passwords match', () {
        expect(
          AuthValidator.validateConfirmPassword('password', 'password'),
          isNull,
        );
      });

      test('returns error when passwords do not match', () {
        expect(
          AuthValidator.validateConfirmPassword('password', 'different'),
          isNotNull,
        );
      });
    });

    group('validateName', () {
      test('returns null for valid name', () {
        expect(AuthValidator.validateName('John'), isNull);
      });

      test('returns error for empty name', () {
        expect(AuthValidator.validateName(''), isNotNull);
      });

      test('returns error for name less than 2 chars', () {
        expect(AuthValidator.validateName('J'), isNotNull);
      });
    });
  });
}
