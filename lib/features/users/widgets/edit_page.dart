import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/Provider/CRUD/crud_provider.dart';
import 'package:instagram_clone/features/users/models/post_model.dart';

import '../../../Provider/image provider/image_provider.dart';

class EditScreen extends StatelessWidget {
  final titleController = TextEditingController();
  final detailController = TextEditingController();
  final Post post;
  EditScreen(this.post);

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
                                  ? Image.network(
                                      post.imageUrl,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(dbimage.image!.path),
                                      fit: BoxFit.cover,
                                    )),
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: detailController..text = post.detail,
                        decoration: InputDecoration(hintText: 'Detail'),
                      ),
                      TextFormField(
                        controller: titleController..text = post.title,
                        obscureText: true,
                        decoration: InputDecoration(hintText: 'Title'),
                      ),
                      Container(
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () async {
                            _form.currentState!.save();
                            if (dbimage == null) {
                              final response = await ref
                                  .read(crudProvider)
                                  .updatePost(
                                      title: titleController.text.trim(),
                                      detail: detailController.text.trim(),
                                      postId: post.id,
                                      imageID: post.imageId,
                                      image: null);

                              if (response == 'success') {
                                Navigator.of(context).pop();
                              }
                            } else {}
                            final response = await ref
                                .read(crudProvider)
                                .updatePost(
                                    title: titleController.text.trim(),
                                    detail: detailController.text.trim(),
                                    postId: post.id,
                                    imageID: post.imageId,
                                    image: dbimage.image);

                            if (response == 'success') {
                              Navigator.of(context).pop();
                            }

                            FocusScope.of(context).unfocus();
                            if (_form.currentState!.validate()) {}
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Update post',
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
