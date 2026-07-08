import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthPasswordDataSource {
  Future<void> resetPassword({required String email});
  Future<void> updatePassword({required String newPassword});
}

class AuthPasswordDataSourceImpl implements AuthPasswordDataSource {
  final SupabaseClient _client;

  AuthPasswordDataSourceImpl(this._client);

  @override
  Future<void> resetPassword({required String email}) async {
    await _client.auth.resetPasswordForEmail(email);
  }

  @override
  Future<void> updatePassword({required String newPassword}) async {
    await _client.auth.updateUser(
      UserAttributes(password: newPassword),
    );
  }
}
