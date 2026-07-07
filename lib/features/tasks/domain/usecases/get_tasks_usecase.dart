import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository _repository;

  GetTasksUseCase(this._repository);

  Future<Either<Failure, List<Task>>> call({
    String? status,
    String? priority,
    String? category,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return _repository.getTasks(
      status: status,
      priority: priority,
      category: category,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
