import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier() : super(FirebaseAuth.instance.currentUser);

  bool isLogin() {
    return state != null;
  }

  Future<void> signIn() async {
    final userCredential = await FirebaseAuth.instance.signInAnonymously();
    state = userCredential.user;
  }
}

final authProvider =
    StateNotifierProvider.autoDispose<AuthNotifier, User?>((ref) {
  return AuthNotifier();
});
