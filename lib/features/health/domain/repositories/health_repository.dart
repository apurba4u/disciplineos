import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/step_log.dart';
import '../entities/sleep_log.dart';
import '../entities/water_log.dart';
import '../entities/workout_log.dart';
import '../entities/mood_log.dart';

abstract class HealthRepository {
  Future<Either<Failure, StepLog>> getTodaySteps();

  Future<Either<Failure, List<StepLog>>> getWeeklySteps();

  Future<Either<Failure, StepLog>> logSteps(StepLog log);

  Future<Either<Failure, SleepLog>> getTodaySleep();

  Future<Either<Failure, List<SleepLog>>> getWeeklySleep();

  Future<Either<Failure, SleepLog>> logSleep(SleepLog log);

  Future<Either<Failure, int>> getTodayWaterIntake();

  Future<Either<Failure, List<WaterLog>>> getTodayWaterLogs();

  Future<Either<Failure, WaterLog>> logWater(WaterLog log);

  Future<Either<Failure, List<WorkoutLog>>> getWorkoutHistory({
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<Either<Failure, WorkoutLog>> logWorkout(WorkoutLog log);

  Future<Either<Failure, List<MoodLog>>> getMoodHistory({
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<Either<Failure, MoodLog>> logMood(MoodLog log);

  Stream<List<WaterLog>> watchTodayWaterLogs();
}
