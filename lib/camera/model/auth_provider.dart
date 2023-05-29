import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier() : super(FirebaseAuth.instance.currentUser);

  bool get _isLogin => state != null;

  Future<void> _signIn() async {
    final userCredential = await FirebaseAuth.instance.signInAnonymously();
    state = userCredential.user;
  }

  Future<void> checkAuth() async {
    if (!_isLogin) {
      await _signIn();
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier();
});
