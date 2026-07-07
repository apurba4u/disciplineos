import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/habit_log.dart';
import '../repositories/habit_repository.dart';

class LogHabitCompletionUseCase {
  final HabitRepository _repository;

  LogHabitCompletionUseCase(this._repository);

  Future<Either<Failure, HabitLog>> call(
    String habitId,
    int count,
    String? notes,
  ) {
    return _repository.logHabitCompletion(habitId, count, notes);
  }
}
