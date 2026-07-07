import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/focus_session.dart';
import '../repositories/focus_repository.dart';

class StartFocusSessionUseCase {
  final FocusRepository _repository;

  StartFocusSessionUseCase(this._repository);

  Future<Either<Failure, FocusSession>> call(FocusSession session) {
    return _repository.startSession(session);
  }
}
