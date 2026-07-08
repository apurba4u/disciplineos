enum DeepSeekModelType {
  fast,
  reasoning;

  String get modelId {
    switch (this) {
      case DeepSeekModelType.fast:
        return 'deepseek-chat';
      case DeepSeekModelType.reasoning:
        return 'deepseek-reasoner';
    }
  }

  int get maxTokens {
    switch (this) {
      case DeepSeekModelType.fast:
        return 1024;
      case DeepSeekModelType.reasoning:
        return 4096;
    }
  }
}

class DeepSeekModelRouter {
  DeepSeekModelType selectModel(String taskType) {
    switch (taskType) {
      case 'chat':
      case 'quick_question':
      case 'simple_task':
        return DeepSeekModelType.fast;
      case 'weekly_planning':
      case 'monthly_review':
      case 'goal_roadmap':
      case 'productivity_analysis':
      case 'habit_analysis':
      case 'complex_reasoning':
        return DeepSeekModelType.reasoning;
      default:
        return DeepSeekModelType.fast;
    }
  }
}
