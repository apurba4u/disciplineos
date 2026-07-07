enum AIProviderType {
  gemini,
  deepSeek;

  String get label {
    switch (this) {
      case AIProviderType.gemini:
        return 'Gemini';
      case AIProviderType.deepSeek:
        return 'DeepSeek';
    }
  }
}
