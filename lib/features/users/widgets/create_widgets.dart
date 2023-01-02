import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/features/users/data/data_source/post_model_data_provider.dart';
import 'package:instagram_clone/features/users/models/post_model.dart';

import '../../../Provider/image provider/image_provider.dart';

class CreateScreen extends StatelessWidget {
  final titleController = TextEditingController();
  final detailController = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(body: Consumer(builder: (context, ref, child) {
      final dbimage = ref.watch(imageProvider);

      return SingleChildScrollView(
        child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Create Post',
                        style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 2,
                            color: Colors.blueGrey),
                      ),
                      InkWell(
                        onTap: () {
                          ref.read(imageProvider.notifier).getImage();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                              height: 140,
                              child: dbimage.image == null
                                  ? Center(
                                      child: Text("please select an image"),
                                    )
                                  : Image.file(
                                      File(dbimage.image!.path),
                                      fit: BoxFit.cover,
                                    )),
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: detailController,
                        decoration: InputDecoration(hintText: 'Detail'),
                      ),
                      TextFormField(
                        controller: titleController,
                        obscureText: true,
                        decoration: InputDecoration(hintText: 'Title'),
                      ),
                      Container(
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () async {
                            _form.currentState!.save();
                            if (dbimage == null) {
                              Text("Please select the image");
                            } else {
                              Like newLike = Like(
                                like: 0,
                                username: [],
                              );
                              final response =
                                  await ref.read(postCrudProvider).addPost(
                                        title: titleController.text,
                                        detail: detailController.text,
                                        image: dbimage.image!,
                                        userId: auth,
                                        likes: newLike,
                                      );
                              if (response == 'success') {
                                Navigator.of(context).pop();
                              }
                            }
                            // if (dbimage == null) {}

                            FocusScope.of(context).unfocus();
                            if (_form.currentState!.validate()) {}
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Add post',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      );
    }));
  }
}
