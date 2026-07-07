import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/calendar_event.dart';

abstract class CalendarRepository {
  Future<Either<Failure, List<CalendarEvent>>> getEvents({
    DateTime? startDate,
    DateTime? endDate,
    EventType? eventType,
  });

  Future<Either<Failure, CalendarEvent>> getEventById(String id);

  Future<Either<Failure, CalendarEvent>> createEvent(CalendarEvent event);

  Future<Either<Failure, CalendarEvent>> updateEvent(CalendarEvent event);

  Future<Either<Failure, void>> deleteEvent(String id);

  Future<Either<Failure, List<CalendarEvent>>> getEventsForDay(DateTime day);

  Future<Either<Failure, List<CalendarEvent>>> getEventsForWeek(DateTime weekStart);

  Future<Either<Failure, List<CalendarEvent>>> getEventsForMonth(
    int year,
    int month,
  );

  Future<Either<Failure, bool>> checkConflict(CalendarEvent event);

  Stream<List<CalendarEvent>> watchEvents();
}
