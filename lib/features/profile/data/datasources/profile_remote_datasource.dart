import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserProfileModel> getProfile(String userId);

  Future<UserProfileModel> updateProfile(UserProfileModel profile);

  Future<UserProfileModel> createProfile(UserProfileModel profile);

  Stream<UserProfileModel> watchProfile(String userId);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final SupabaseClient _client;

  ProfileRemoteDataSourceImpl(this._client);

  @override
  Future<UserProfileModel> getProfile(String userId) async {
    final data = await _client
        .from('users')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (data == null) {
      throw Exception('Profile not found');
    }

    return UserProfileModel.fromJson(data);
  }

  @override
  Future<UserProfileModel> updateProfile(UserProfileModel profile) async {
    final data = await _client
        .from('users')
        .update(profile.toJson())
        .eq('user_id', profile.userId)
        .select()
        .single();
    return UserProfileModel.fromJson(data);
  }

  @override
  Future<UserProfileModel> createProfile(UserProfileModel profile) async {
    final data = await _client
        .from('users')
        .insert(profile.toJson())
        .select()
        .single();
    return UserProfileModel.fromJson(data);
  }

  @override
  Stream<UserProfileModel> watchProfile(String userId) {
    return _client
        .from('users')
        .stream(primaryKey: ['user_id'])
        .eq('user_id', userId)
        .map((data) {
      if (data.isEmpty) {
        throw Exception('Profile not found');
      }
      return UserProfileModel.fromJson(data.first);
    });
  }
}
