import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/update_profile_usecase.dart';

class ProfileState {
  final UserProfile? profile;
  final bool isLoading;
  final String? error;

  const ProfileState({
    this.profile,
    this.isLoading = false,
    this.error,
  });

  ProfileState copyWith({
    UserProfile? profile,
    bool? isLoading,
    String? error,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  final GetProfileUseCase _getProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;

  ProfileNotifier({
    required GetProfileUseCase getProfileUseCase,
    required UpdateProfileUseCase updateProfileUseCase,
  })  : _getProfileUseCase = getProfileUseCase,
        _updateProfileUseCase = updateProfileUseCase,
        super(const ProfileState());

  Future<void> loadProfile(String userId) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _getProfileUseCase(userId);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (profile) => state = state.copyWith(
        profile: profile,
        isLoading: false,
      ),
    );
  }

  Future<void> updateProfile(UserProfile profile) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _updateProfileUseCase(profile);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (updated) => state = state.copyWith(
        profile: updated,
        isLoading: false,
      ),
    );
  }
}

final profileProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  throw UnimplementedError('Override in ProviderScope');
});
