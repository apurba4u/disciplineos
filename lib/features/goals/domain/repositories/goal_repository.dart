import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/goal.dart';

abstract class GoalRepository {
  Future<Either<Failure, List<Goal>>> getGoals({
    String? category,
    String? status,
  });

  Future<Either<Failure, Goal>> getGoalById(String id);

  Future<Either<Failure, Goal>> createGoal(Goal goal);

  Future<Either<Failure, Goal>> updateGoal(Goal goal);

  Future<Either<Failure, void>> deleteGoal(String id);

  Future<Either<Failure, Goal>> addMilestone(
    String goalId,
    Milestone milestone,
  );

  Future<Either<Failure, Goal>> updateMilestone(
    String goalId,
    String milestoneId,
    bool completed,
  );

  Future<Either<Failure, Goal>> removeMilestone(
    String goalId,
    String milestoneId,
  );

  Stream<List<Goal>> watchGoals();
}
