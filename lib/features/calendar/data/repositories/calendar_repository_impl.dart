import 'package:dartz/dartz.dart' show Either, Right, Left;
import '../../../../core/errors/failures.dart';
import '../../domain/entities/calendar_event.dart';
import '../../domain/repositories/calendar_repository.dart';
import '../datasources/calendar_remote_datasource.dart';
import '../models/calendar_event_model.dart';

class CalendarRepositoryImpl implements CalendarRepository {
  final CalendarRemoteDataSource _remoteDataSource;

  CalendarRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<CalendarEvent>>> getEvents({
    DateTime? startDate,
    DateTime? endDate,
    EventType? eventType,
  }) async {
    try {
      final events = await _remoteDataSource.getEvents(
        startDate: startDate,
        endDate: endDate,
        eventType: eventType?.name,
      );
      return Right(events);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CalendarEvent>> getEventById(String id) async {
    try {
      final event = await _remoteDataSource.getEventById(id);
      return Right(event);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CalendarEvent>> createEvent(
    CalendarEvent event,
  ) async {
    try {
      final model = CalendarEventModel(
        id: event.id,
        userId: event.userId,
        title: event.title,
        description: event.description,
        location: event.location,
        startTime: event.startTime,
        endTime: event.endTime,
        eventType: event.eventType,
        linkedTaskId: event.linkedTaskId,
        linkedGoalId: event.linkedGoalId,
        color: event.color,
        allDay: event.allDay,
        createdAt: event.createdAt,
      );
      final created = await _remoteDataSource.createEvent(model);
      return Right(created);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CalendarEvent>> updateEvent(
    CalendarEvent event,
  ) async {
    try {
      final model = CalendarEventModel(
        id: event.id,
        userId: event.userId,
        title: event.title,
        description: event.description,
        location: event.location,
        startTime: event.startTime,
        endTime: event.endTime,
        eventType: event.eventType,
        linkedTaskId: event.linkedTaskId,
        linkedGoalId: event.linkedGoalId,
        color: event.color,
        allDay: event.allDay,
        createdAt: event.createdAt,
      );
      final updated = await _remoteDataSource.updateEvent(model);
      return Right(updated);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteEvent(String id) async {
    try {
      await _remoteDataSource.deleteEvent(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CalendarEvent>>> getEventsForDay(
    DateTime day,
  ) async {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    return getEvents(startDate: start, endDate: end);
  }

  @override
  Future<Either<Failure, List<CalendarEvent>>> getEventsForWeek(
    DateTime weekStart,
  ) async {
    final weekEnd = weekStart.add(const Duration(days: 7));
    return getEvents(startDate: weekStart, endDate: weekEnd);
  }

  @override
  Future<Either<Failure, List<CalendarEvent>>> getEventsForMonth(
    int year,
    int month,
  ) async {
    final start = DateTime(year, month, 1);
    final end = DateTime(year, month + 1, 0, 23, 59, 59);
    return getEvents(startDate: start, endDate: end);
  }

  @override
  Future<Either<Failure, bool>> checkConflict(CalendarEvent event) async {
    try {
      final events = await _remoteDataSource.getEvents(
        startDate: event.startTime,
        endDate: event.endTime,
      );
      return Right(events.isNotEmpty);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Stream<List<CalendarEvent>> watchEvents() {
    return _remoteDataSource.watchEvents();
  }
}
