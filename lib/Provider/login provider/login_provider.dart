import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = StateNotifierProvider.autoDispose<LoginProvider, bool>(
    (ref) => LoginProvider());

// This is the provider
class LoginProvider extends StateNotifier<bool> {
  LoginProvider() : super(true);

  void toggle() {
    state = !state;
  }
}
