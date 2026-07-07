import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/focus_session.dart';
import '../repositories/focus_repository.dart';

class EndFocusSessionUseCase {
  final FocusRepository _repository;

  EndFocusSessionUseCase(this._repository);

  Future<Either<Failure, FocusSession>> call(
    String sessionId,
    int actualDuration,
  ) {
    return _repository.endSession(sessionId, actualDuration);
  }
}
