import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/entities/user.dart';
import '../models/user_model.dart';

abstract class AuthGoogleDataSource {
  Future<User> signInWithGoogle();
  Future<void> signOut();
}

class AuthGoogleDataSourceImpl implements AuthGoogleDataSource {
  final supabase.SupabaseClient _client;
  final GoogleSignIn _googleSignIn;

  AuthGoogleDataSourceImpl(this._client, this._googleSignIn);

  @override
  Future<User> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception('Google sign in was cancelled');
    }

    final googleAuth = await googleUser.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null || idToken == null) {
      throw Exception('Failed to get Google authentication tokens');
    }

    final response = await _client.auth.signInWithIdToken(
      provider: supabase.OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

    if (response.user == null) {
      throw Exception('Google sign in failed');
    }

    return UserModel.fromSupabaseUser(response.user!);
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _client.auth.signOut();
  }
}
