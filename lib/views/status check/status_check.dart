import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/Provider/authentication/auth_provider.dart';
import 'package:instagram_clone/views/home/login_screen.dart';

import '../main screen/main_screen.dart';

class StatusCheck extends StatelessWidget {
  const StatusCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: ((context, ref, child) {
      final auth = ref.watch(authProvider);
      return auth.when(
          data: (data) {
            if (data == null) {
              return LoginScreen();
            } else {
              return MainScreen();
            }
          },
          error: (err, stack) => Text('$err'),
          loading: () => CircularProgressIndicator());
    }));
  }
}
