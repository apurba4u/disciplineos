import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/calendar_event.dart';
import '../repositories/calendar_repository.dart';

class GetEventsUseCase {
  final CalendarRepository _repository;

  GetEventsUseCase(this._repository);

  Future<Either<Failure, List<CalendarEvent>>> call({
    DateTime? startDate,
    DateTime? endDate,
    EventType? eventType,
  }) {
    return _repository.getEvents(
      startDate: startDate,
      endDate: endDate,
      eventType: eventType,
    );
  }
}
