import 'package:dartz/dartz.dart' show Either, Right, Left;
import '../../../../core/errors/failures.dart';
import '../../../../shared/enums/task_status.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_remote_datasource.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource _remoteDataSource;

  TaskRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<Task>>> getTasks({
    String? status,
    String? priority,
    String? category,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final tasks = await _remoteDataSource.getTasks(
        status: status,
        priority: priority,
        category: category,
        startDate: startDate,
        endDate: endDate,
      );
      return Right(tasks);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> getTaskById(String id) async {
    try {
      final task = await _remoteDataSource.getTaskById(id);
      return Right(task);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> createTask(Task task) async {
    try {
      final model = TaskModel(
        id: task.id,
        userId: task.userId,
        title: task.title,
        description: task.description,
        priority: task.priority,
        status: task.status,
        category: task.category,
        deadline: task.deadline,
        estimatedMinutes: task.estimatedMinutes,
        actualMinutes: task.actualMinutes,
        labels: task.labels,
        attachments: task.attachments,
        voiceNote: task.voiceNote,
        proofRequired: task.proofRequired,
        repeatRule: task.repeatRule,
        reminder: task.reminder,
        subtasks: task.subtasks,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final created = await _remoteDataSource.createTask(model);
      return Right(created);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> updateTask(Task task) async {
    try {
      final model = TaskModel(
        id: task.id,
        userId: task.userId,
        title: task.title,
        description: task.description,
        priority: task.priority,
        status: task.status,
        category: task.category,
        deadline: task.deadline,
        estimatedMinutes: task.estimatedMinutes,
        actualMinutes: task.actualMinutes,
        labels: task.labels,
        attachments: task.attachments,
        voiceNote: task.voiceNote,
        proofRequired: task.proofRequired,
        repeatRule: task.repeatRule,
        reminder: task.reminder,
        subtasks: task.subtasks,
        createdAt: task.createdAt,
        updatedAt: DateTime.now(),
      );
      final updated = await _remoteDataSource.updateTask(model);
      return Right(updated);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(String id) async {
    try {
      await _remoteDataSource.deleteTask(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> completeTask(String id) async {
    try {
      final existing = await _remoteDataSource.getTaskById(id);
      final updated = TaskModel(
        id: existing.id,
        userId: existing.userId,
        title: existing.title,
        description: existing.description,
        priority: existing.priority,
        status: TaskStatus.completed,
        category: existing.category,
        deadline: existing.deadline,
        estimatedMinutes: existing.estimatedMinutes,
        actualMinutes: existing.actualMinutes,
        labels: existing.labels,
        attachments: existing.attachments,
        voiceNote: existing.voiceNote,
        proofRequired: existing.proofRequired,
        repeatRule: existing.repeatRule,
        reminder: existing.reminder,
        subtasks: existing.subtasks,
        createdAt: existing.createdAt,
        updatedAt: DateTime.now(),
      );
      final result = await _remoteDataSource.updateTask(updated);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> addSubTask(String taskId, SubTask subTask) async {
    try {
      final existing = await _remoteDataSource.getTaskById(taskId);
      final updatedSubtasks = [...existing.subtasks, subTask];
      final updated = TaskModel(
        id: existing.id,
        userId: existing.userId,
        title: existing.title,
        description: existing.description,
        priority: existing.priority,
        status: existing.status,
        category: existing.category,
        deadline: existing.deadline,
        estimatedMinutes: existing.estimatedMinutes,
        actualMinutes: existing.actualMinutes,
        labels: existing.labels,
        attachments: existing.attachments,
        voiceNote: existing.voiceNote,
        proofRequired: existing.proofRequired,
        repeatRule: existing.repeatRule,
        reminder: existing.reminder,
        subtasks: updatedSubtasks,
        createdAt: existing.createdAt,
        updatedAt: DateTime.now(),
      );
      final result = await _remoteDataSource.updateTask(updated);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> updateSubTask(
    String taskId,
    String subTaskId,
    bool completed,
  ) async {
    try {
      final existing = await _remoteDataSource.getTaskById(taskId);
      final updatedSubtasks = existing.subtasks.map((s) {
        if (s.id == subTaskId) {
          return s.copyWith(completed: completed);
        }
        return s;
      }).toList();
      final updated = TaskModel(
        id: existing.id,
        userId: existing.userId,
        title: existing.title,
        description: existing.description,
        priority: existing.priority,
        status: existing.status,
        category: existing.category,
        deadline: existing.deadline,
        estimatedMinutes: existing.estimatedMinutes,
        actualMinutes: existing.actualMinutes,
        labels: existing.labels,
        attachments: existing.attachments,
        voiceNote: existing.voiceNote,
        proofRequired: existing.proofRequired,
        repeatRule: existing.repeatRule,
        reminder: existing.reminder,
        subtasks: updatedSubtasks,
        createdAt: existing.createdAt,
        updatedAt: DateTime.now(),
      );
      final result = await _remoteDataSource.updateTask(updated);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> removeSubTask(
    String taskId,
    String subTaskId,
  ) async {
    try {
      final existing = await _remoteDataSource.getTaskById(taskId);
      final updatedSubtasks = existing.subtasks
          .where((s) => s.id != subTaskId)
          .toList();
      final updated = TaskModel(
        id: existing.id,
        userId: existing.userId,
        title: existing.title,
        description: existing.description,
        priority: existing.priority,
        status: existing.status,
        category: existing.category,
        deadline: existing.deadline,
        estimatedMinutes: existing.estimatedMinutes,
        actualMinutes: existing.actualMinutes,
        labels: existing.labels,
        attachments: existing.attachments,
        voiceNote: existing.voiceNote,
        proofRequired: existing.proofRequired,
        repeatRule: existing.repeatRule,
        reminder: existing.reminder,
        subtasks: updatedSubtasks,
        createdAt: existing.createdAt,
        updatedAt: DateTime.now(),
      );
      final result = await _remoteDataSource.updateTask(updated);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Stream<List<Task>> watchTasks() {
    return _remoteDataSource.watchTasks();
  }
}
