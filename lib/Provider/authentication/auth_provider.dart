import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final authProvider =
    StreamProvider((ref) => FirebaseAuth.instance.authStateChanges());

final logSignProvider = Provider((ref) => LoginSignUpProvider());

class LoginSignUpProvider {
  CollectionReference dbUsers =
      FirebaseFirestore.instance.collection('users'); //connection to firestore

  // for sign up
  Future<String> signUp({
    required String email,
    required String password,
    required String userName,
    required XFile image, //image type is File type
  }) async {
    try {
      final imageFile = File(image.path); //converting the image to File type
      final imageID = DateTime.now().toString();
      final ref = FirebaseStorage.instance.ref().child(
          'userImages/$imageID'); //path to push the image to firebase storage

      await ref.putFile(imageFile); //pushing the image to firebase storage

      final url = await ref.getDownloadURL(); //getting the url of the image

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      dbUsers.add({
        'email': email,
        'username': userName,
        'userImage': url,
      });

      return 'success';
    } on FirebaseException catch (e) {
      print(e);

      return '';
    }
  }

// for log in
  Future<String> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return 'success';
    } on FirebaseException catch (e) {
      print(e);
      return '';
    }
  }

//for log out
  Future<String> logOut() async {
    try {
      final response = await FirebaseAuth.instance.signOut();
      return 'success';
    } on FirebaseException catch (e) {
      print(e);
      return '';
    }
  }
}
