import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/get_tasks_usecase.dart';
import '../../domain/usecases/create_task_usecase.dart';
import '../../domain/usecases/complete_task_usecase.dart';

class TaskState {
  final List<Task> tasks;
  final bool isLoading;
  final String? error;
  final String? filterStatus;
  final String? filterPriority;

  const TaskState({
    this.tasks = const [],
    this.isLoading = false,
    this.error,
    this.filterStatus,
    this.filterPriority,
  });

  TaskState copyWith({
    List<Task>? tasks,
    bool? isLoading,
    String? error,
    String? filterStatus,
    String? filterPriority,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      filterStatus: filterStatus ?? this.filterStatus,
      filterPriority: filterPriority ?? this.filterPriority,
    );
  }

  List<Task> get filteredTasks {
    var filtered = tasks;
    if (filterStatus != null) {
      filtered = filtered
          .where((t) => t.status.name == filterStatus)
          .toList();
    }
    if (filterPriority != null) {
      filtered = filtered
          .where((t) => t.priority.name == filterPriority)
          .toList();
    }
    return filtered;
  }

  List<Task> get todayTasks {
    final now = DateTime.now();
    return tasks.where((t) {
      if (t.deadline == null) return false;
      return t.deadline!.year == now.year &&
          t.deadline!.month == now.month &&
          t.deadline!.day == now.day;
    }).toList();
  }

  List<Task> get overdueTasks {
    return tasks.where((t) => t.isOverdue).toList();
  }
}

class TaskNotifier extends StateNotifier<TaskState> {
  final GetTasksUseCase _getTasksUseCase;
  final CreateTaskUseCase _createTaskUseCase;
  final CompleteTaskUseCase _completeTaskUseCase;

  TaskNotifier({
    required GetTasksUseCase getTasksUseCase,
    required CreateTaskUseCase createTaskUseCase,
    required CompleteTaskUseCase completeTaskUseCase,
  })  : _getTasksUseCase = getTasksUseCase,
        _createTaskUseCase = createTaskUseCase,
        _completeTaskUseCase = completeTaskUseCase,
        super(const TaskState());

  Future<void> loadTasks() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _getTasksUseCase();
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (tasks) => state = state.copyWith(
        tasks: tasks,
        isLoading: false,
      ),
    );
  }

  Future<void> createTask(Task task) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _createTaskUseCase(task);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (created) {
        state = state.copyWith(
          tasks: [...state.tasks, created],
          isLoading: false,
        );
      },
    );
  }

  Future<void> completeTask(String taskId) async {
    final result = await _completeTaskUseCase(taskId);
    result.fold(
      (failure) => state = state.copyWith(error: failure.message),
      (completed) {
        final updated = state.tasks.map((t) {
          if (t.id == taskId) return completed;
          return t;
        }).toList();
        state = state.copyWith(tasks: updated);
      },
    );
  }

  void setFilter({String? status, String? priority}) {
    state = state.copyWith(
      filterStatus: status,
      filterPriority: priority,
    );
  }

  void clearFilters() {
    state = state.copyWith(
      filterStatus: null,
      filterPriority: null,
    );
  }
}

final taskProvider =
    StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  throw UnimplementedError('Override in ProviderScope');
});
