import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/Provider/authentication/auth_provider.dart';
import 'package:instagram_clone/features/users/data/data_source/post_model_data_provider.dart';
import 'package:instagram_clone/features/users/data/data_source/user_model_data_source.dart';
import 'package:instagram_clone/features/users/widgets/drawer_widgets.dart';

import '../../Provider/CRUD/crud_provider.dart';
import '../../features/users/widgets/create_widgets.dart';
import '../../features/users/widgets/edit_page.dart';
import '../../features/users/widgets/user_show.dart';

class MainScreen extends StatelessWidget {
  final auth = FirebaseAuth.instance.currentUser!.uid;
  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final userData = ref.watch(userProvider);
      final postData = ref.watch(postStream);

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
        body: Column(
          children: [
            UserShow(userData),
            postData.when(
              data: (data) {
                return Container(
                  height: 500,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          height: auth != data[index].userId ? 350 : 400,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(data[index].title),
                                  if (auth == data[index].userId)
                                    IconButton(
                                        onPressed: () {
                                          Get.defaultDialog(
                                              title: "Update or remove post",
                                              content: Text("customize post"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    Get.to(
                                                      () => EditScreen(
                                                          data[index]),
                                                      transition: Transition
                                                          .leftToRight,
                                                    );
                                                  },
                                                  child: Icon(Icons.edit),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    await ref
                                                        .read(crudProvider)
                                                        .removePost(
                                                          postId:
                                                              data[index].id,
                                                          imageID: data[index]
                                                              .imageId,
                                                        );

                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Icon(Icons.delete),
                                                ),
                                              ]);
                                        },
                                        icon: Icon(Icons.more_horiz_sharp))
                                ],
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  data[index].imageUrl,
                                  height: 250,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              if (auth != data[index].userId)
                                Row(
                                  children: [
                                    Spacer(),
                                    Text(data[index].likes.like == 0
                                        ? ''
                                        : '${data[index].likes.like} likes'),
                                    IconButton(
                                        onPressed: () {
                                          if (data[index].likes.username ==
                                              0) {}
                                        },
                                        icon: Icon(Icons.thumb_up)),
                                  ],
                                )
                            ],
                          ),
                        );
                      }),
                );
              },
              error: (err, stack) => Text('$err'),
              loading: () => CircularProgressIndicator(),
            ),
          ],
        ),
      );
    });
  }
}
