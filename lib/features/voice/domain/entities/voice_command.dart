enum VoiceCommandType {
  createTask,
  completeTask,
  deleteTask,
  startFocus,
  stopFocus,
  addHabit,
  openDashboard,
  openCalendar,
  logWater,
  logSleep,
  askAI,
  generatePlan,
  unknown;

  String get label {
    switch (this) {
      case VoiceCommandType.createTask:
        return 'Create Task';
      case VoiceCommandType.completeTask:
        return 'Complete Task';
      case VoiceCommandType.deleteTask:
        return 'Delete Task';
      case VoiceCommandType.startFocus:
        return 'Start Focus';
      case VoiceCommandType.stopFocus:
        return 'Stop Focus';
      case VoiceCommandType.addHabit:
        return 'Add Habit';
      case VoiceCommandType.openDashboard:
        return 'Open Dashboard';
      case VoiceCommandType.openCalendar:
        return 'Open Calendar';
      case VoiceCommandType.logWater:
        return 'Log Water';
      case VoiceCommandType.logSleep:
        return 'Log Sleep';
      case VoiceCommandType.askAI:
        return 'Ask AI';
      case VoiceCommandType.generatePlan:
        return 'Generate Plan';
      case VoiceCommandType.unknown:
        return 'Unknown';
    }
  }
}

class VoiceCommand {
  final String id;
  final String rawText;
  final VoiceCommandType type;
  final Map<String, dynamic> parameters;
  final DateTime timestamp;

  const VoiceCommand({
    required this.id,
    required this.rawText,
    required this.type,
    this.parameters = const {},
    required this.timestamp,
  });

  VoiceCommand copyWith({
    String? id,
    String? rawText,
    VoiceCommandType? type,
    Map<String, dynamic>? parameters,
    DateTime? timestamp,
  }) {
    return VoiceCommand(
      id: id ?? this.id,
      rawText: rawText ?? this.rawText,
      type: type ?? this.type,
      parameters: parameters ?? this.parameters,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

class VoiceRecognitionResult {
  final String text;
  final double confidence;
  final bool isFinal;

  const VoiceRecognitionResult({
    required this.text,
    required this.confidence,
    required this.isFinal,
  });
}
