import 'package:dartz/dartz.dart' show Either, Right, Left;
import '../../../../core/errors/failures.dart';
import '../../domain/entities/habit.dart';
import '../../domain/entities/habit_log.dart';
import '../../domain/repositories/habit_repository.dart';
import '../datasources/habit_remote_datasource.dart';
import '../models/habit_model.dart';

class HabitRepositoryImpl implements HabitRepository {
  final HabitRemoteDataSource _remoteDataSource;

  HabitRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<Habit>>> getHabits({
    bool? activeOnly,
    String? category,
  }) async {
    try {
      final habits = await _remoteDataSource.getHabits(
        activeOnly: activeOnly,
        category: category,
      );
      return Right(habits);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Habit>> getHabitById(String id) async {
    try {
      final habit = await _remoteDataSource.getHabitById(id);
      return Right(habit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Habit>> createHabit(Habit habit) async {
    try {
      final model = HabitModel(
        id: habit.id,
        userId: habit.userId,
        title: habit.title,
        description: habit.description,
        category: habit.category,
        frequency: habit.frequency,
        target: habit.target,
        unit: habit.unit,
        reminderTime: habit.reminderTime,
        currentStreak: habit.currentStreak,
        longestStreak: habit.longestStreak,
        completionRate: habit.completionRate,
        isActive: habit.isActive,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final created = await _remoteDataSource.createHabit(model);
      return Right(created);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Habit>> updateHabit(Habit habit) async {
    try {
      final model = HabitModel(
        id: habit.id,
        userId: habit.userId,
        title: habit.title,
        description: habit.description,
        category: habit.category,
        frequency: habit.frequency,
        target: habit.target,
        unit: habit.unit,
        reminderTime: habit.reminderTime,
        currentStreak: habit.currentStreak,
        longestStreak: habit.longestStreak,
        completionRate: habit.completionRate,
        isActive: habit.isActive,
        createdAt: habit.createdAt,
        updatedAt: DateTime.now(),
      );
      final updated = await _remoteDataSource.updateHabit(model);
      return Right(updated);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteHabit(String id) async {
    try {
      await _remoteDataSource.deleteHabit(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Habit>> pauseHabit(String id) async {
    try {
      final existing = await _remoteDataSource.getHabitById(id);
      final updated = HabitModel(
        id: existing.id,
        userId: existing.userId,
        title: existing.title,
        description: existing.description,
        category: existing.category,
        frequency: existing.frequency,
        target: existing.target,
        unit: existing.unit,
        reminderTime: existing.reminderTime,
        currentStreak: existing.currentStreak,
        longestStreak: existing.longestStreak,
        completionRate: existing.completionRate,
        isActive: false,
        createdAt: existing.createdAt,
        updatedAt: DateTime.now(),
      );
      final result = await _remoteDataSource.updateHabit(updated);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Habit>> resumeHabit(String id) async {
    try {
      final existing = await _remoteDataSource.getHabitById(id);
      final updated = HabitModel(
        id: existing.id,
        userId: existing.userId,
        title: existing.title,
        description: existing.description,
        category: existing.category,
        frequency: existing.frequency,
        target: existing.target,
        unit: existing.unit,
        reminderTime: existing.reminderTime,
        currentStreak: existing.currentStreak,
        longestStreak: existing.longestStreak,
        completionRate: existing.completionRate,
        isActive: true,
        createdAt: existing.createdAt,
        updatedAt: DateTime.now(),
      );
      final result = await _remoteDataSource.updateHabit(updated);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, HabitLog>> logHabitCompletion(
    String habitId,
    int count,
    String? notes,
  ) async {
    try {
      final habit = await _remoteDataSource.getHabitById(habitId);
      final newStreak = habit.currentStreak + 1;
      final updated = HabitModel(
        id: habit.id,
        userId: habit.userId,
        title: habit.title,
        description: habit.description,
        category: habit.category,
        frequency: habit.frequency,
        target: habit.target,
        unit: habit.unit,
        reminderTime: habit.reminderTime,
        currentStreak: newStreak,
        longestStreak: newStreak > habit.longestStreak
            ? newStreak
            : habit.longestStreak,
        completionRate: habit.completionRate + 1,
        isActive: habit.isActive,
        createdAt: habit.createdAt,
        updatedAt: DateTime.now(),
      );
      await _remoteDataSource.updateHabit(updated);

      final log = HabitLog(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        habitId: habitId,
        userId: habit.userId,
        completedCount: count,
        completedAt: DateTime.now(),
        notes: notes,
      );
      return Right(log);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HabitLog>>> getHabitLogs(
    String habitId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      return const Right([]);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Stream<List<Habit>> watchHabits() {
    return _remoteDataSource.watchHabits();
  }
}
