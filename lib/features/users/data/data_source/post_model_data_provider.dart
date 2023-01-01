import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/features/users/models/post_model.dart';

final postCrudProvider = Provider((ref) => PostProvider());
final postStream = StreamProvider((ref) => PostProvider().getPost());

class PostProvider {
  CollectionReference dbPost = FirebaseFirestore.instance.collection('posts');
  Future<String> addPost({
    required String title,
    required String detail,
    required XFile image,
    required String userId,
    //image type is File type
  }) async {
    try {
      final imageFile = File(image.path); //converting the image to File type
      final imageID = DateTime.now().toString();
      final ref = FirebaseStorage.instance.ref().child(
          'postImages/$imageID'); //path to push the image to firebase storage

      await ref.putFile(imageFile); //pushing the image to firebase storage

      final url = await ref.getDownloadURL(); //getting the url of the image

      dbPost.add({
        'title': title,
        'detail': detail,
        'imageUrl': url,
        'userId': userId,
      });

      return 'success';
    } on FirebaseException catch (e) {
      print(e);

      return '';
    }
  }

  Stream<List<Post>> getPost() {
    final data = dbPost.snapshots().map((event) => _getFromSnap(event));

    return data;
  }

  List<Post> _getFromSnap(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((e) {
      final data = e.data() as Map<String, dynamic>;
      return Post(
        title: data['title'],
        detail: data['detail'],
        imageUrl: data['imageUrl'],
        id: e.id,
        userId: data['userId'],
      );
    }).toList();
  }
}
