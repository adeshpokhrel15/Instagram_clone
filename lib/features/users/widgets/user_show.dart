import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';

class UserShow extends StatelessWidget {
  final AsyncValue<List<User>> userData;
  UserShow(this.userData);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 200,
      child: userData.when(
        data: (data) {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          data[index].userImage,
                        ),
                        radius: 40,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(data[index].username)
                    ],
                  ),
                );
              });
        },
        error: (err, stack) => Text('$err'),
        loading: () => CircularProgressIndicator(),
      ),
    );
  }
}
