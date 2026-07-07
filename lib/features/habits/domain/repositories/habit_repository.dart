import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/habit.dart';
import '../entities/habit_log.dart';

abstract class HabitRepository {
  Future<Either<Failure, List<Habit>>> getHabits({
    bool? activeOnly,
    String? category,
  });

  Future<Either<Failure, Habit>> getHabitById(String id);

  Future<Either<Failure, Habit>> createHabit(Habit habit);

  Future<Either<Failure, Habit>> updateHabit(Habit habit);

  Future<Either<Failure, void>> deleteHabit(String id);

  Future<Either<Failure, Habit>> pauseHabit(String id);

  Future<Either<Failure, Habit>> resumeHabit(String id);

  Future<Either<Failure, HabitLog>> logHabitCompletion(
    String habitId,
    int count,
    String? notes,
  );

  Future<Either<Failure, List<HabitLog>>> getHabitLogs(
    String habitId,
    DateTime startDate,
    DateTime endDate,
  );

  Stream<List<Habit>> watchHabits();
}
