import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/data_source/user_model_data_source.dart';

class DrawerWidget extends StatelessWidget {
  final auth = FirebaseAuth.instance.currentUser!
      .uid; //value of current user  //public gareko chiz auxa auth ma
  @override
  Widget build(BuildContext context) {
    final loginUserProvider =
        FutureProvider((ref) => UserProvider().getLoginUserData(auth));

    return Consumer(builder: (context, ref, child) {
      final userData = ref.watch(loginUserProvider);
      return Drawer(
          child: userData.when(
              data: (data) {
                return ListView(children: [
                  DrawerHeader(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(data.userImage),
                              fit: BoxFit.cover)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.username,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            data.email,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ))
                ]);
              },
              error: (err, stack) => Text(err.toString()),
              loading: () => CircularProgressIndicator()));
    });
  }
}
