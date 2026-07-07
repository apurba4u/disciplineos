import 'package:dartz/dartz.dart' show Either, Right, Left;
import '../../../../core/errors/failures.dart';
import '../../domain/entities/focus_session.dart';
import '../../domain/repositories/focus_repository.dart';
import '../datasources/focus_remote_datasource.dart';
import '../models/focus_session_model.dart';

class FocusRepositoryImpl implements FocusRepository {
  final FocusRemoteDataSource _remoteDataSource;

  FocusRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<FocusSession>>> getSessions({
    DateTime? startDate,
    DateTime? endDate,
    FocusModeType? type,
  }) async {
    try {
      final sessions = await _remoteDataSource.getSessions(
        startDate: startDate,
        endDate: endDate,
        type: type?.name,
      );
      return Right(sessions);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, FocusSession>> getSessionById(String id) async {
    try {
      final session = await _remoteDataSource.getSessionById(id);
      return Right(session);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, FocusSession>> startSession(
    FocusSession session,
  ) async {
    try {
      final model = FocusSessionModel(
        id: session.id,
        userId: session.userId,
        type: session.type,
        startTime: session.startTime,
        durationMinutes: session.durationMinutes,
        linkedTaskId: session.linkedTaskId,
        category: session.category,
        createdAt: session.createdAt,
      );
      final created = await _remoteDataSource.createSession(model);
      return Right(created);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, FocusSession>> endSession(
    String sessionId,
    int actualDuration,
  ) async {
    try {
      final existing = await _remoteDataSource.getSessionById(sessionId);
      final updated = FocusSessionModel(
        id: existing.id,
        userId: existing.userId,
        type: existing.type,
        startTime: existing.startTime,
        endTime: DateTime.now(),
        durationMinutes: actualDuration,
        interruptions: existing.interruptions,
        linkedTaskId: existing.linkedTaskId,
        mood: existing.mood,
        notes: existing.notes,
        category: existing.category,
        score: existing.score,
        completed: true,
        createdAt: existing.createdAt,
      );
      final result = await _remoteDataSource.updateSession(updated);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, FocusSession>> pauseSession(String sessionId) async {
    try {
      final existing = await _remoteDataSource.getSessionById(sessionId);
      final updated = FocusSessionModel(
        id: existing.id,
        userId: existing.userId,
        type: existing.type,
        startTime: existing.startTime,
        endTime: DateTime.now(),
        durationMinutes: existing.durationMinutes,
        interruptions: existing.interruptions + 1,
        linkedTaskId: existing.linkedTaskId,
        mood: existing.mood,
        notes: existing.notes,
        category: existing.category,
        score: existing.score,
        completed: false,
        createdAt: existing.createdAt,
      );
      final result = await _remoteDataSource.updateSession(updated);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, FocusSession>> resumeSession(String sessionId) async {
    try {
      final existing = await _remoteDataSource.getSessionById(sessionId);
      final updated = FocusSessionModel(
        id: existing.id,
        userId: existing.userId,
        type: existing.type,
        startTime: DateTime.now(),
        durationMinutes: existing.durationMinutes,
        interruptions: existing.interruptions,
        linkedTaskId: existing.linkedTaskId,
        mood: existing.mood,
        notes: existing.notes,
        category: existing.category,
        score: existing.score,
        completed: false,
        createdAt: existing.createdAt,
      );
      final result = await _remoteDataSource.updateSession(updated);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, FocusSession>> updateSession(
    FocusSession session,
  ) async {
    try {
      final model = FocusSessionModel(
        id: session.id,
        userId: session.userId,
        type: session.type,
        startTime: session.startTime,
        endTime: session.endTime,
        durationMinutes: session.durationMinutes,
        interruptions: session.interruptions,
        linkedTaskId: session.linkedTaskId,
        mood: session.mood,
        notes: session.notes,
        category: session.category,
        score: session.score,
        completed: session.completed,
        createdAt: session.createdAt,
      );
      final updated = await _remoteDataSource.updateSession(model);
      return Right(updated);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSession(String id) async {
    try {
      await _remoteDataSource.deleteSession(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, FocusSession?>> getActiveSession() async {
    try {
      final session = await _remoteDataSource.getActiveSession();
      return Right(session);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getTodayFocusMinutes() async {
    try {
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      final sessions = await _remoteDataSource.getSessions(
        startDate: startOfDay,
      );
      final totalMinutes = sessions.fold<int>(
        0,
        (sum, s) => sum + s.durationMinutes,
      );
      return Right(totalMinutes);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getWeeklyFocusMinutes() async {
    try {
      final now = DateTime.now();
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      final sessions = await _remoteDataSource.getSessions(
        startDate: DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day),
      );
      final totalMinutes = sessions.fold<int>(
        0,
        (sum, s) => sum + s.durationMinutes,
      );
      return Right(totalMinutes);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Stream<List<FocusSession>> watchSessions() {
    return _remoteDataSource.watchSessions();
  }
}
