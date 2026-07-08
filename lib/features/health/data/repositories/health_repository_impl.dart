import 'package:dartz/dartz.dart' show Either, Right, Left;
import '../../../../core/errors/failures.dart';
import '../../domain/entities/step_log.dart';
import '../../domain/entities/sleep_log.dart';
import '../../domain/entities/water_log.dart';
import '../../domain/entities/workout_log.dart';
import '../../domain/entities/mood_log.dart';
import '../../domain/repositories/health_repository.dart';
import '../datasources/health_remote_datasource.dart';
import '../models/step_log_model.dart';
import '../models/water_log_model.dart';
import '../models/sleep_log_model.dart';
import '../models/workout_log_model.dart';
import '../models/mood_log_model.dart';

class HealthRepositoryImpl implements HealthRepository {
  final HealthRemoteDataSource _remoteDataSource;

  HealthRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, StepLog>> getTodaySteps() async {
    try {
      final steps = await _remoteDataSource.getTodaySteps();
      if (steps == null) {
        return Right(StepLog(
          id: '',
          userId: '',
          steps: 0,
          distance: 0,
          calories: 0,
          goal: 10000,
          date: DateTime.now(),
          createdAt: DateTime.now(),
        ));
      }
      return Right(steps);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StepLog>>> getWeeklySteps() async {
    try {
      final steps = await _remoteDataSource.getTodaySteps();
      return Right(steps != null ? [steps] : []);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, StepLog>> logSteps(StepLog log) async {
    try {
      final model = StepLogModel(
        id: log.id,
        userId: log.userId,
        steps: log.steps,
        distance: log.distance,
        calories: log.calories,
        goal: log.goal,
        date: log.date,
        createdAt: DateTime.now(),
      );
      final result = await _remoteDataSource.logSteps(model);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SleepLog>> getTodaySleep() async {
    try {
      final sleep = await _remoteDataSource.getTodaySleep();
      if (sleep == null) {
        return Right(SleepLog(
          id: '',
          userId: '',
          sleepStart: DateTime.now(),
          sleepEnd: DateTime.now(),
          durationMinutes: 0,
          quality: SleepQuality.good,
          source: 'manual',
          date: DateTime.now(),
        ));
      }
      return Right(sleep);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SleepLog>>> getWeeklySleep() async {
    try {
      final sleep = await _remoteDataSource.getTodaySleep();
      return Right(sleep != null ? [sleep] : []);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SleepLog>> logSleep(SleepLog log) async {
    try {
      final model = SleepLogModel(
        id: log.id,
        userId: log.userId,
        sleepStart: log.sleepStart,
        sleepEnd: log.sleepEnd,
        durationMinutes: log.durationMinutes,
        quality: log.quality,
        source: log.source,
        date: log.date,
      );
      final result = await _remoteDataSource.logSleep(model);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getTodayWaterIntake() async {
    try {
      final intake = await _remoteDataSource.getTodayWaterIntake();
      return Right(intake);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<WaterLog>>> getTodayWaterLogs() async {
    try {
      final logs = await _remoteDataSource.getTodayWaterLogs();
      return Right(logs);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, WaterLog>> logWater(WaterLog log) async {
    try {
      final model = WaterLogModel(
        id: log.id,
        userId: log.userId,
        amountMl: log.amountMl,
        goalMl: log.goalMl,
        loggedAt: log.loggedAt,
      );
      final result = await _remoteDataSource.logWater(model);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<WorkoutLog>>> getWorkoutHistory({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final workouts = await _remoteDataSource.getWorkoutHistory(
        startDate: startDate,
        endDate: endDate,
      );
      return Right(workouts);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, WorkoutLog>> logWorkout(WorkoutLog log) async {
    try {
      final model = WorkoutLogModel(
        id: log.id,
        userId: log.userId,
        workoutName: log.workoutName,
        durationMinutes: log.durationMinutes,
        calories: log.calories,
        muscleGroup: log.muscleGroup,
        notes: log.notes,
        loggedAt: log.loggedAt,
      );
      final result = await _remoteDataSource.logWorkout(model);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MoodLog>>> getMoodHistory({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final moods = await _remoteDataSource.getMoodHistory(
        startDate: startDate,
        endDate: endDate,
      );
      return Right(moods);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MoodLog>> logMood(MoodLog log) async {
    try {
      final model = MoodLogModel(
        id: log.id,
        userId: log.userId,
        mood: log.mood,
        journal: log.journal,
        createdAt: log.createdAt,
      );
      final result = await _remoteDataSource.logMood(model);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Stream<List<WaterLog>> watchTodayWaterLogs() {
    return Stream.value([]);
  }
}
