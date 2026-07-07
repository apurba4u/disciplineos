class HabitLog {
  final String id;
  final String habitId;
  final String userId;
  final int completedCount;
  final DateTime completedAt;
  final String? notes;

  const HabitLog({
    required this.id,
    required this.habitId,
    required this.userId,
    required this.completedCount,
    required this.completedAt,
    this.notes,
  });

  HabitLog copyWith({
    String? id,
    String? habitId,
    String? userId,
    int? completedCount,
    DateTime? completedAt,
    String? notes,
  }) {
    return HabitLog(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      userId: userId ?? this.userId,
      completedCount: completedCount ?? this.completedCount,
      completedAt: completedAt ?? this.completedAt,
      notes: notes ?? this.notes,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitLog && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
