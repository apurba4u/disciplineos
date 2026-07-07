import 'package:dartz/dartz.dart' show Either;
import '../../../../core/errors/failures.dart';
import '../entities/task.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<Task>>> getTasks({
    String? status,
    String? priority,
    String? category,
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<Either<Failure, Task>> getTaskById(String id);

  Future<Either<Failure, Task>> createTask(Task task);

  Future<Either<Failure, Task>> updateTask(Task task);

  Future<Either<Failure, void>> deleteTask(String id);

  Future<Either<Failure, Task>> completeTask(String id);

  Future<Either<Failure, Task>> addSubTask(String taskId, SubTask subTask);

  Future<Either<Failure, Task>> updateSubTask(
    String taskId,
    String subTaskId,
    bool completed,
  );

  Future<Either<Failure, Task>> removeSubTask(String taskId, String subTaskId);

  Stream<List<Task>> watchTasks();
}
