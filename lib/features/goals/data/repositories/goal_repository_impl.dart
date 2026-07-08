import 'package:dartz/dartz.dart' show Either, Right, Left;
import '../../../../core/errors/failures.dart';
import '../../domain/entities/goal.dart';
import '../../domain/repositories/goal_repository.dart';
import '../datasources/goal_remote_datasource.dart';
import '../models/goal_model.dart';

class GoalRepositoryImpl implements GoalRepository {
  final GoalRemoteDataSource _remoteDataSource;

  GoalRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<Goal>>> getGoals({
    String? category,
    String? status,
  }) async {
    try {
      final goals = await _remoteDataSource.getGoals(
        category: category,
        status: status,
      );
      return Right(goals);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Goal>> getGoalById(String id) async {
    try {
      final goal = await _remoteDataSource.getGoalById(id);
      return Right(goal);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Goal>> createGoal(Goal goal) async {
    try {
      final model = GoalModel(
        id: goal.id,
        userId: goal.userId,
        title: goal.title,
        description: goal.description,
        category: goal.category,
        status: goal.status,
        targetDate: goal.targetDate,
        progress: goal.progress,
        milestones: goal.milestones,
        resources: goal.resources,
        notes: goal.notes,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final created = await _remoteDataSource.createGoal(model);
      return Right(created);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Goal>> updateGoal(Goal goal) async {
    try {
      final model = GoalModel(
        id: goal.id,
        userId: goal.userId,
        title: goal.title,
        description: goal.description,
        category: goal.category,
        status: goal.status,
        targetDate: goal.targetDate,
        progress: goal.progress,
        milestones: goal.milestones,
        resources: goal.resources,
        notes: goal.notes,
        createdAt: goal.createdAt,
        updatedAt: DateTime.now(),
      );
      final updated = await _remoteDataSource.updateGoal(model);
      return Right(updated);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteGoal(String id) async {
    try {
      await _remoteDataSource.deleteGoal(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Goal>> addMilestone(
    String goalId,
    Milestone milestone,
  ) async {
    try {
      final existing = await _remoteDataSource.getGoalById(goalId);
      final updatedMilestones = [...existing.milestones, milestone];
      final updated = GoalModel(
        id: existing.id,
        userId: existing.userId,
        title: existing.title,
        description: existing.description,
        category: existing.category,
        status: existing.status,
        targetDate: existing.targetDate,
        progress: existing.progress,
        milestones: updatedMilestones,
        resources: existing.resources,
        notes: existing.notes,
        createdAt: existing.createdAt,
        updatedAt: DateTime.now(),
      );
      final result = await _remoteDataSource.updateGoal(updated);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Goal>> updateMilestone(
    String goalId,
    String milestoneId,
    bool completed,
  ) async {
    try {
      final existing = await _remoteDataSource.getGoalById(goalId);
      final updatedMilestones = existing.milestones.map((m) {
        if (m.id == milestoneId) {
          return m.copyWith(completed: completed);
        }
        return m;
      }).toList();
      final updated = GoalModel(
        id: existing.id,
        userId: existing.userId,
        title: existing.title,
        description: existing.description,
        category: existing.category,
        status: existing.status,
        targetDate: existing.targetDate,
        progress: existing.progress,
        milestones: updatedMilestones,
        resources: existing.resources,
        notes: existing.notes,
        createdAt: existing.createdAt,
        updatedAt: DateTime.now(),
      );
      final result = await _remoteDataSource.updateGoal(updated);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Goal>> removeMilestone(
    String goalId,
    String milestoneId,
  ) async {
    try {
      final existing = await _remoteDataSource.getGoalById(goalId);
      final updatedMilestones = existing.milestones
          .where((m) => m.id != milestoneId)
          .toList();
      final updated = GoalModel(
        id: existing.id,
        userId: existing.userId,
        title: existing.title,
        description: existing.description,
        category: existing.category,
        status: existing.status,
        targetDate: existing.targetDate,
        progress: existing.progress,
        milestones: updatedMilestones,
        resources: existing.resources,
        notes: existing.notes,
        createdAt: existing.createdAt,
        updatedAt: DateTime.now(),
      );
      final result = await _remoteDataSource.updateGoal(updated);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Stream<List<Goal>> watchGoals() {
    return _remoteDataSource.watchGoals();
  }
}
