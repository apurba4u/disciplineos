import '../../../../shared/enums/task_priority.dart';
import '../../../../shared/enums/task_status.dart';

class Task {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final TaskPriority priority;
  final TaskStatus status;
  final String? category;
  final DateTime? deadline;
  final int? estimatedMinutes;
  final int? actualMinutes;
  final List<String> labels;
  final String? attachments;
  final String? voiceNote;
  final bool proofRequired;
  final String? repeatRule;
  final DateTime? reminder;
  final List<SubTask> subtasks;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Task({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    this.priority = TaskPriority.medium,
    this.status = TaskStatus.pending,
    this.category,
    this.deadline,
    this.estimatedMinutes,
    this.actualMinutes,
    this.labels = const [],
    this.attachments,
    this.voiceNote,
    this.proofRequired = false,
    this.repeatRule,
    this.reminder,
    this.subtasks = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  Task copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    TaskPriority? priority,
    TaskStatus? status,
    String? category,
    DateTime? deadline,
    int? estimatedMinutes,
    int? actualMinutes,
    List<String>? labels,
    String? attachments,
    String? voiceNote,
    bool? proofRequired,
    String? repeatRule,
    DateTime? reminder,
    List<SubTask>? subtasks,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Task(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      category: category ?? this.category,
      deadline: deadline ?? this.deadline,
      estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
      actualMinutes: actualMinutes ?? this.actualMinutes,
      labels: labels ?? this.labels,
      attachments: attachments ?? this.attachments,
      voiceNote: voiceNote ?? this.voiceNote,
      proofRequired: proofRequired ?? this.proofRequired,
      repeatRule: repeatRule ?? this.repeatRule,
      reminder: reminder ?? this.reminder,
      subtasks: subtasks ?? this.subtasks,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isOverdue =>
      deadline != null && deadline!.isBefore(DateTime.now()) && status != TaskStatus.completed;

  int get completedSubtasks => subtasks.where((s) => s.completed).length;

  double get subtaskProgress =>
      subtasks.isEmpty ? 0 : completedSubtasks / subtasks.length;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class SubTask {
  final String id;
  final String title;
  final bool completed;

  const SubTask({
    required this.id,
    required this.title,
    this.completed = false,
  });

  SubTask copyWith({
    String? id,
    String? title,
    bool? completed,
  }) {
    return SubTask(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}
