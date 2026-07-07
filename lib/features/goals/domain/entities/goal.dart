import '../../../../shared/enums/goal_category.dart';
import '../../../../shared/enums/goal_status.dart';

class Goal {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final GoalCategory category;
  final GoalStatus status;
  final DateTime? targetDate;
  final int progress;
  final List<Milestone> milestones;
  final String? resources;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Goal({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    this.category = GoalCategory.personal,
    this.status = GoalStatus.notStarted,
    this.targetDate,
    this.progress = 0,
    this.milestones = const [],
    this.resources,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  Goal copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    GoalCategory? category,
    GoalStatus? status,
    DateTime? targetDate,
    int? progress,
    List<Milestone>? milestones,
    String? resources,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Goal(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      status: status ?? this.status,
      targetDate: targetDate ?? this.targetDate,
      progress: progress ?? this.progress,
      milestones: milestones ?? this.milestones,
      resources: resources ?? this.resources,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  int get completedMilestones =>
      milestones.where((m) => m.completed).length;

  double get milestoneProgress =>
      milestones.isEmpty ? 0 : completedMilestones / milestones.length;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Goal && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class Milestone {
  final String id;
  final String goalId;
  final String title;
  final bool completed;
  final DateTime? deadline;

  const Milestone({
    required this.id,
    required this.goalId,
    required this.title,
    this.completed = false,
    this.deadline,
  });

  Milestone copyWith({
    String? id,
    String? goalId,
    String? title,
    bool? completed,
    DateTime? deadline,
  }) {
    return Milestone(
      id: id ?? this.id,
      goalId: goalId ?? this.goalId,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      deadline: deadline ?? this.deadline,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Milestone && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
