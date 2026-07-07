import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/habit.dart';
import '../repositories/habit_repository.dart';

class CreateHabitUseCase {
  final HabitRepository _repository;

  CreateHabitUseCase(this._repository);

  Future<Either<Failure, Habit>> call(Habit habit) {
    return _repository.createHabit(habit);
  }
}
