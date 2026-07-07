import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/habit.dart';
import '../repositories/habit_repository.dart';

class GetHabitsUseCase {
  final HabitRepository _repository;

  GetHabitsUseCase(this._repository);

  Future<Either<Failure, List<Habit>>> call({
    bool? activeOnly,
    String? category,
  }) {
    return _repository.getHabits(
      activeOnly: activeOnly,
      category: category,
    );
  }
}
