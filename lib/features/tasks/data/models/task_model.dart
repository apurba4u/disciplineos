import '../../../../shared/enums/task_priority.dart';
import '../../../../shared/enums/task_status.dart';
import '../../domain/entities/task.dart';

class TaskModel extends Task {
  const TaskModel({
    required super.id,
    required super.userId,
    required super.title,
    super.description,
    super.priority,
    super.status,
    super.category,
    super.deadline,
    super.estimatedMinutes,
    super.actualMinutes,
    super.labels,
    super.attachments,
    super.voiceNote,
    super.proofRequired,
    super.repeatRule,
    super.reminder,
    super.subtasks,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      priority: TaskPriority.values.firstWhere(
        (e) => e.name == json['priority'],
        orElse: () => TaskPriority.medium,
      ),
      status: TaskStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => TaskStatus.pending,
      ),
      category: json['category'] as String?,
      deadline: json['deadline'] != null
          ? DateTime.parse(json['deadline'] as String)
          : null,
      estimatedMinutes: json['estimated_minutes'] as int?,
      actualMinutes: json['actual_minutes'] as int?,
      labels: (json['labels'] as List<dynamic>?)?.cast<String>() ?? [],
      attachments: json['attachments'] as String?,
      voiceNote: json['voice_note'] as String?,
      proofRequired: json['proof_required'] as bool? ?? false,
      repeatRule: json['repeat_rule'] as String?,
      reminder: json['reminder'] != null
          ? DateTime.parse(json['reminder'] as String)
          : null,
      subtasks: (json['subtasks'] as List<dynamic>?)
              ?.map((s) => SubTask(
                    id: s['id'] as String,
                    title: s['title'] as String,
                    completed: s['completed'] as bool? ?? false,
                  ))
              .toList() ??
          [],
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'description': description,
      'priority': priority.name,
      'status': status.name,
      'category': category,
      'deadline': deadline?.toIso8601String(),
      'estimated_minutes': estimatedMinutes,
      'actual_minutes': actualMinutes,
      'labels': labels,
      'attachments': attachments,
      'voice_note': voiceNote,
      'proof_required': proofRequired,
      'repeat_rule': repeatRule,
      'reminder': reminder?.toIso8601String(),
      'subtasks': subtasks
          .map((s) => {
                'id': s.id,
                'title': s.title,
                'completed': s.completed,
              })
          .toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
