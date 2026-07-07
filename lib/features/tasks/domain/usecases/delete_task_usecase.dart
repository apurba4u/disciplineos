import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../repositories/task_repository.dart';

class DeleteTaskUseCase {
  final TaskRepository _repository;

  DeleteTaskUseCase(this._repository);

  Future<Either<Failure, void>> call(String taskId) {
    return _repository.deleteTask(taskId);
  }
}
