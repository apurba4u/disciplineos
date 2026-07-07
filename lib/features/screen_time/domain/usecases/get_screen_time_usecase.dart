import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/app_usage.dart';
import '../repositories/screen_time_repository.dart';

class GetScreenTimeUseCase {
  final ScreenTimeRepository _repository;

  GetScreenTimeUseCase(this._repository);

  Future<Either<Failure, ScreenTimeData>> call() {
    return _repository.getTodayScreenTime();
  }
}
