import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/water_log.dart';
import '../repositories/health_repository.dart';

class LogWaterUseCase {
  final HealthRepository _repository;

  LogWaterUseCase(this._repository);

  Future<Either<Failure, WaterLog>> call(WaterLog log) {
    return _repository.logWater(log);
  }
}
