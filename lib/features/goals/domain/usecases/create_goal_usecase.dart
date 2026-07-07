import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/goal.dart';
import '../repositories/goal_repository.dart';

class CreateGoalUseCase {
  final GoalRepository _repository;

  CreateGoalUseCase(this._repository);

  Future<Either<Failure, Goal>> call(Goal goal) {
    return _repository.createGoal(goal);
  }
}
