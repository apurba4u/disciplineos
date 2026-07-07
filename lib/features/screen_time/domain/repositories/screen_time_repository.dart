import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/app_usage.dart';

abstract class ScreenTimeRepository {
  Future<Either<Failure, List<AppUsage>>> getTodayAppUsage();

  Future<Either<Failure, List<AppUsage>>> getWeeklyAppUsage();

  Future<Either<Failure, ScreenTimeData>> getTodayScreenTime();

  Future<Either<Failure, List<ScreenTimeData>>> getWeeklyScreenTime();

  Future<Either<Failure, List<AppUsage>>> getTopApps({
    int limit = 10,
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<Either<Failure, Map<AppCategory, int>>> getCategoryBreakdown({
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<Either<Failure, void>> syncAppUsage();

  Stream<List<AppUsage>> watchAppUsage();
}
