import '../../../../shared/enums/goal_category.dart';
import '../../../../shared/enums/goal_status.dart';
import '../../domain/entities/goal.dart';

class GoalModel extends Goal {
  const GoalModel({
    required super.id,
    required super.userId,
    required super.title,
    super.description,
    super.category,
    super.status,
    super.targetDate,
    super.progress,
    super.milestones,
    super.resources,
    super.notes,
    required super.createdAt,
    required super.updatedAt,
  });

  factory GoalModel.fromJson(Map<String, dynamic> json) {
    return GoalModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      category: GoalCategory.values.firstWhere(
        (e) => e.name == json['category'],
        orElse: () => GoalCategory.personal,
      ),
      status: GoalStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => GoalStatus.notStarted,
      ),
      targetDate: json['target_date'] != null
          ? DateTime.parse(json['target_date'] as String)
          : null,
      progress: json['progress'] as int? ?? 0,
      milestones: (json['milestones'] as List<dynamic>?)
              ?.map((m) => Milestone(
                    id: m['id'] as String,
                    goalId: m['goal_id'] as String,
                    title: m['title'] as String,
                    completed: m['completed'] as bool? ?? false,
                    deadline: m['deadline'] != null
                        ? DateTime.parse(m['deadline'] as String)
                        : null,
                  ))
              .toList() ??
          [],
      resources: json['resources'] as String?,
      notes: json['notes'] as String?,
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
      'category': category.name,
      'status': status.name,
      'target_date': targetDate?.toIso8601String(),
      'progress': progress,
      'milestones': milestones
          .map((m) => {
                'id': m.id,
                'goal_id': m.goalId,
                'title': m.title,
                'completed': m.completed,
                'deadline': m.deadline?.toIso8601String(),
              })
          .toList(),
      'resources': resources,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
