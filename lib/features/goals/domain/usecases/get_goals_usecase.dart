import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/goal.dart';
import '../repositories/goal_repository.dart';

class GetGoalsUseCase {
  final GoalRepository _repository;

  GetGoalsUseCase(this._repository);

  Future<Either<Failure, List<Goal>>> call({
    String? category,
    String? status,
  }) {
    return _repository.getGoals(
      category: category,
      status: status,
    );
  }
}
