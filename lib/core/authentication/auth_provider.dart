import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider =
    StreamProvider((ref) => FirebaseAuth.instance.authStateChanges());

class LoginSignUpProvider {
  Future<String> signUp(
      {required String email, required String password}) async {
    try {
      final response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return 'success';
    } catch (err) {
      return '';
    }
  }
}
