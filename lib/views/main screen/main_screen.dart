import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/Provider/authentication/auth_provider.dart';
import 'package:instagram_clone/features/users/data/data_source/user_model_data_source.dart';
import 'package:instagram_clone/features/users/widgets/drawer_widgets.dart';

import '../../features/users/widgets/create_widgets.dart';
import '../../features/users/widgets/user_show.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final userData = ref.watch(userProvider);
      return Scaffold(
        drawer: DrawerWidget(),
        appBar: AppBar(
          title: const Text('Main Screen'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CreateScreen()));
                },
                child: Text(
                  "Create",
                  style: TextStyle(color: Colors.white),
                )),
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
        body: SingleChildScrollView(
            child: Column(
          children: [UserShow(userData)],
        )),
      );
    });
  }
}
