class StepLog {
  final String id;
  final String userId;
  final int steps;
  final double distance;
  final int calories;
  final int goal;
  final DateTime date;
  final DateTime createdAt;

  const StepLog({
    required this.id,
    required this.userId,
    required this.steps,
    required this.distance,
    required this.calories,
    required this.goal,
    required this.date,
    required this.createdAt,
  });

  StepLog copyWith({
    String? id,
    String? userId,
    int? steps,
    double? distance,
    int? calories,
    int? goal,
    DateTime? date,
    DateTime? createdAt,
  }) {
    return StepLog(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      steps: steps ?? this.steps,
      distance: distance ?? this.distance,
      calories: calories ?? this.calories,
      goal: goal ?? this.goal,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  double get progressToGoal => goal == 0 ? 0 : steps / goal;

  bool get goalReached => steps >= goal;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StepLog && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
