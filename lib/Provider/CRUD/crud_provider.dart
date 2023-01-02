import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/features/users/models/post_model.dart';

final crudProvider = Provider((ref) => CrudProvider());

class CrudProvider {
  CollectionReference dbPost = FirebaseFirestore.instance.collection('posts');
  Future<String> updatePost({
    required String title,
    required String detail,
    XFile? image,
    required String postId,
    required String imageID,
    //image type is File type
  }) async {
    try {
      if (image == null) {
        dbPost.doc(postId).update({
          //updating the post
          'title': title,
          'detail': detail,
        });
      } else {
        final ref = FirebaseStorage.instance.ref().child(
            'postImages/$imageID'); //path to push the image to firebase storage
        await ref.delete();

        final imageFile = File(image.path); //converting the image to File type
        final imageID1 = DateTime.now().toString();
        final ref1 = FirebaseStorage.instance.ref().child(
            'postImages/$imageID1'); //path to push the image to firebase storage

        await ref1.putFile(imageFile); //pushing the image to firebase storage

        final url = await ref1.getDownloadURL(); //getting the url of the image

        dbPost.doc(postId).update({
          //updating the post
          'title': title,
          'detail': detail,
          'imageUrl': url,
          'imageId': imageID1,
        });
      }

      return 'success';
    } on FirebaseException catch (e) {
      print(e);

      return '';
    }
  }

  Future<String> removePost({
    required String postId,
    required String imageID,
    //image type is File type
  }) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(
          'postImages/$imageID'); //path to push the image to firebase storage
      await ref.delete();

      dbPost.doc(postId).delete();
      //updating the post

      return 'success';
    } on FirebaseException catch (e) {
      print(e);

      return '';
    }
  }

  Future<String> addLike({
    required String postId,
    required Like like,
    //image type is File type
  }) async {
    try {
      await dbPost.doc(postId).update({
        'likes': like.toJson(),
      });

      return 'success';
    } on FirebaseException catch (e) {
      print(e);

      return '';
    }
  }
}
