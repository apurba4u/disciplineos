import 'package:flutter_test/flutter_test.dart';
import 'package:discipline_os/shared/validators/task_validator.dart';

void main() {
  group('TaskValidator', () {
    group('validateTitle', () {
      test('returns null for valid title', () {
        expect(TaskValidator.validateTitle('Complete project'), isNull);
      });

      test('returns error for empty title', () {
        expect(TaskValidator.validateTitle(''), isNotNull);
      });

      test('returns error for null title', () {
        expect(TaskValidator.validateTitle(null), isNotNull);
      });
    });

    group('validateDeadline', () {
      test('returns null for future deadline', () {
        final futureDate = DateTime.now().add(const Duration(days: 1));
        expect(TaskValidator.validateDeadline(futureDate), isNull);
      });

      test('returns error for null deadline', () {
        expect(TaskValidator.validateDeadline(null), isNotNull);
      });
    });

    group('validateEstimatedDuration', () {
      test('returns null for positive duration', () {
        expect(TaskValidator.validateEstimatedDuration(30), isNull);
      });

      test('returns error for zero duration', () {
        expect(TaskValidator.validateEstimatedDuration(0), isNotNull);
      });

      test('returns error for negative duration', () {
        expect(TaskValidator.validateEstimatedDuration(-1), isNotNull);
      });

      test('returns error for null duration', () {
        expect(TaskValidator.validateEstimatedDuration(null), isNotNull);
      });
    });
  });
}
