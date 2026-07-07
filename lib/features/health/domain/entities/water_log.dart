class WaterLog {
  final String id;
  final String userId;
  final int amountMl;
  final int goalMl;
  final DateTime loggedAt;

  const WaterLog({
    required this.id,
    required this.userId,
    required this.amountMl,
    required this.goalMl,
    required this.loggedAt,
  });

  WaterLog copyWith({
    String? id,
    String? userId,
    int? amountMl,
    int? goalMl,
    DateTime? loggedAt,
  }) {
    return WaterLog(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      amountMl: amountMl ?? this.amountMl,
      goalMl: goalMl ?? this.goalMl,
      loggedAt: loggedAt ?? this.loggedAt,
    );
  }

  double get progressToGoal => goalMl == 0 ? 0 : amountMl / goalMl;

  bool get goalReached => amountMl >= goalMl;

  String get formattedAmount {
    if (amountMl >= 1000) {
      return '${(amountMl / 1000).toStringAsFixed(1)}L';
    }
    return '${amountMl}ml';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WaterLog && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
