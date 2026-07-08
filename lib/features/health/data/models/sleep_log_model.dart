import '../../domain/entities/sleep_log.dart';

class SleepLogModel extends SleepLog {
  const SleepLogModel({
    required super.id,
    required super.userId,
    required super.sleepStart,
    required super.sleepEnd,
    required super.durationMinutes,
    required super.quality,
    required super.source,
    required super.date,
  });

  factory SleepLogModel.fromJson(Map<String, dynamic> json) {
    return SleepLogModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      sleepStart: DateTime.parse(json['sleep_start'] as String),
      sleepEnd: DateTime.parse(json['sleep_end'] as String),
      durationMinutes: json['duration'] as int,
      quality: SleepQuality.values.firstWhere(
        (e) => e.name == json['quality'],
        orElse: () => SleepQuality.good,
      ),
      source: json['source'] as String? ?? 'manual',
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'sleep_start': sleepStart.toIso8601String(),
      'sleep_end': sleepEnd.toIso8601String(),
      'duration': durationMinutes,
      'quality': quality.name,
      'source': source,
      'date': date.toIso8601String(),
    };
  }
}
