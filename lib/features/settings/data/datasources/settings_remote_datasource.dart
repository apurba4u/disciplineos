import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_settings_model.dart';

abstract class SettingsRemoteDataSource {
  Future<UserSettingsModel> getSettings(String userId);

  Future<UserSettingsModel> updateSettings(UserSettingsModel settings);

  Stream<UserSettingsModel> watchSettings(String userId);
}

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  final SupabaseClient _client;

  SettingsRemoteDataSourceImpl(this._client);

  @override
  Future<UserSettingsModel> getSettings(String userId) async {
    final data = await _client
        .from('settings')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (data == null) {
      final defaultSettings = UserSettingsModel(
        userId: userId,
        updatedAt: DateTime.now(),
      );
      final created = await _client
          .from('settings')
          .insert(defaultSettings.toJson())
          .select()
          .single();
      return UserSettingsModel.fromJson(created);
    }

    return UserSettingsModel.fromJson(data);
  }

  @override
  Future<UserSettingsModel> updateSettings(UserSettingsModel settings) async {
    final data = await _client
        .from('settings')
        .upsert(settings.toJson())
        .select()
        .single();
    return UserSettingsModel.fromJson(data);
  }

  @override
  Stream<UserSettingsModel> watchSettings(String userId) {
    return _client
        .from('settings')
        .stream(primaryKey: ['user_id'])
        .eq('user_id', userId)
        .map((data) {
      if (data.isEmpty) {
        return UserSettingsModel(
          userId: userId,
          updatedAt: DateTime.now(),
        );
      }
      return UserSettingsModel.fromJson(data.first);
    });
  }
}
