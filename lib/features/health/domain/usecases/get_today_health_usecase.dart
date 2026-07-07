import 'package:dartz/dartz.dart' show Either, Right;
import '../../../../core/errors/failures.dart';
import '../entities/step_log.dart';
import '../entities/sleep_log.dart';
import '../repositories/health_repository.dart';

class TodayHealthData {
  final StepLog? steps;
  final SleepLog? sleep;
  final int waterIntake;

  const TodayHealthData({
    this.steps,
    this.sleep,
    this.waterIntake = 0,
  });
}

class GetTodayHealthUseCase {
  final HealthRepository _repository;

  GetTodayHealthUseCase(this._repository);

  Future<Either<Failure, TodayHealthData>> call() async {
    final stepsResult = await _repository.getTodaySteps();
    final sleepResult = await _repository.getTodaySleep();
    final waterResult = await _repository.getTodayWaterIntake();

    StepLog? steps;
    stepsResult.fold(
      (_) {},
      (s) => steps = s,
    );

    SleepLog? sleep;
    sleepResult.fold(
      (_) {},
      (s) => sleep = s,
    );

    int water = 0;
    waterResult.fold(
      (_) {},
      (w) => water = w,
    );

    return Right(TodayHealthData(
      steps: steps,
      sleep: sleep,
      waterIntake: water,
    ));
  }
}
