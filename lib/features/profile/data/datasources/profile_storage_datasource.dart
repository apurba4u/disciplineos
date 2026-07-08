import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProfileStorageDataSource {
  Future<String> uploadProfilePhoto(String userId, File imageFile);
  Future<void> deleteProfilePhoto(String userId);
}

class ProfileStorageDataSourceImpl implements ProfileStorageDataSource {
  final SupabaseClient _client;

  ProfileStorageDataSourceImpl(this._client);

  @override
  Future<String> uploadProfilePhoto(String userId, File imageFile) async {
    final fileName = '$userId/profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
    
    await _client.storage.from('profile-images').upload(
      fileName,
      imageFile,
      fileOptions: const FileOptions(upsert: true),
    );

    final url = _client.storage.from('profile-images').getPublicUrl(fileName);
    return url;
  }

  @override
  Future<void> deleteProfilePhoto(String userId) async {
    try {
      final files = await _client.storage.from('profile-images').list(path: '$userId/');
      for (final file in files) {
        await _client.storage.from('profile-images').remove(['$userId/${file.name}']);
      }
    } catch (e) {
      // Ignore errors if no files exist
    }
  }
}
