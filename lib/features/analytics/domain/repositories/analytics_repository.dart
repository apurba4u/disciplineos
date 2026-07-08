import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/analytics_data.dart';

abstract class AnalyticsRepository {
  Future<Either<Failure, AnalyticsData>> getDailyAnalytics();
  Future<Either<Failure, AnalyticsData>> getWeeklyAnalytics();
  Future<Either<Failure, AnalyticsData>> getMonthlyAnalytics();
  Future<Either<Failure, List<DailyAnalytics>>> getDailyHistory({
    DateTime? startDate,
    DateTime? endDate,
  });
}
