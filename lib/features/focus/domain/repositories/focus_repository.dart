import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/focus_session.dart';

abstract class FocusRepository {
  Future<Either<Failure, List<FocusSession>>> getSessions({
    DateTime? startDate,
    DateTime? endDate,
    FocusModeType? type,
  });

  Future<Either<Failure, FocusSession>> getSessionById(String id);

  Future<Either<Failure, FocusSession>> startSession(FocusSession session);

  Future<Either<Failure, FocusSession>> endSession(
    String sessionId,
    int actualDuration,
  );

  Future<Either<Failure, FocusSession>> pauseSession(String sessionId);

  Future<Either<Failure, FocusSession>> resumeSession(String sessionId);

  Future<Either<Failure, FocusSession>> updateSession(FocusSession session);

  Future<Either<Failure, void>> deleteSession(String id);

  Future<Either<Failure, FocusSession?>> getActiveSession();

  Future<Either<Failure, int>> getTodayFocusMinutes();

  Future<Either<Failure, int>> getWeeklyFocusMinutes();

  Stream<List<FocusSession>> watchSessions();
}
