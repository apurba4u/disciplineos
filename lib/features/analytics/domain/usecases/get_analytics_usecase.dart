import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/analytics_data.dart';
import '../repositories/analytics_repository.dart';

enum AnalyticsPeriod { daily, weekly, monthly }

class GetAnalyticsUseCase {
  final AnalyticsRepository _repository;

  GetAnalyticsUseCase(this._repository);

  Future<Either<Failure, AnalyticsData>> call(AnalyticsPeriod period) {
    switch (period) {
      case AnalyticsPeriod.daily:
        return _repository.getDailyAnalytics();
      case AnalyticsPeriod.weekly:
        return _repository.getWeeklyAnalytics();
      case AnalyticsPeriod.monthly:
        return _repository.getMonthlyAnalytics();
    }
  }
}
