import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user_settings.dart';
import '../../domain/usecases/get_settings_usecase.dart';
import '../../domain/usecases/update_settings_usecase.dart';

class SettingsState {
  final UserSettings? settings;
  final bool isLoading;
  final String? error;

  const SettingsState({
    this.settings,
    this.isLoading = false,
    this.error,
  });

  SettingsState copyWith({
    UserSettings? settings,
    bool? isLoading,
    String? error,
  }) {
    return SettingsState(
      settings: settings ?? this.settings,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  final GetSettingsUseCase _getSettingsUseCase;
  final UpdateSettingsUseCase _updateSettingsUseCase;

  SettingsNotifier({
    required GetSettingsUseCase getSettingsUseCase,
    required UpdateSettingsUseCase updateSettingsUseCase,
  })  : _getSettingsUseCase = getSettingsUseCase,
        _updateSettingsUseCase = updateSettingsUseCase,
        super(const SettingsState());

  Future<void> loadSettings(String userId) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _getSettingsUseCase(userId);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (settings) => state = state.copyWith(
        settings: settings,
        isLoading: false,
      ),
    );
  }

  Future<void> updateSettings(UserSettings settings) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _updateSettingsUseCase(settings);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (updated) => state = state.copyWith(
        settings: updated,
        isLoading: false,
      ),
    );
  }
}
