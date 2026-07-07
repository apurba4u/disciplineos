import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../../../core/exceptions/app_exceptions.dart' as app;
import '../../domain/entities/user.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<User> signIn({required String email, required String password});
  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<void> signOut();
  Future<User> getCurrentUser();
  Future<void> resetPassword({required String email});
  Stream<User?> get authStateChanges;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final supabase.SupabaseClient _client;

  AuthRemoteDataSourceImpl(this._client);

  @override
  Future<User> signIn({required String email, required String password}) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw const app.AuthException(message: 'Sign in failed');
      }

      return UserModel.fromSupabaseUser(response.user!);
    } catch (e) {
      throw app.AuthException(message: e.toString());
    }
  }

  @override
  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      if (response.user == null) {
        throw const app.AuthException(message: 'Sign up failed');
      }

      return UserModel.fromSupabaseUser(response.user!);
    } catch (e) {
      throw app.AuthException(message: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      throw app.AuthException(message: e.toString());
    }
  }

  @override
  Future<User> getCurrentUser() async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) {
        throw const app.AuthException(message: 'No user logged in');
      }
      return UserModel.fromSupabaseUser(user);
    } catch (e) {
      throw app.AuthException(message: e.toString());
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    try {
      await _client.auth.resetPasswordForEmail(email);
    } catch (e) {
      throw app.AuthException(message: e.toString());
    }
  }

  @override
  Stream<User?> get authStateChanges {
    return _client.auth.onAuthStateChange.map((event) {
      if (event.session?.user != null) {
        return UserModel.fromSupabaseUser(event.session!.user);
      }
      return null;
    });
  }
}
