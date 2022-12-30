import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/Provider/authentication/auth_provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Main Screen'),
          actions: [
            TextButton(
                onPressed: () {
                  ref
                      .read(logSignProvider)
                      .logOut(); //calling logOut function from auth_provider.dart
                },
                child: Text(
                  "Sign Out",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Container(
          child: Text("Welcome to Main Screen"),
        ),
      );
    });
  }
}
