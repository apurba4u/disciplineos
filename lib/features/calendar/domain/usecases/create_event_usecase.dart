import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/calendar_event.dart';
import '../repositories/calendar_repository.dart';

class CreateEventUseCase {
  final CalendarRepository _repository;

  CreateEventUseCase(this._repository);

  Future<Either<Failure, CalendarEvent>> call(CalendarEvent event) {
    return _repository.createEvent(event);
  }
}
