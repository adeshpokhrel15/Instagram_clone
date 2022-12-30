import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user_model.dart';

final userProvider = StreamProvider((ref) => UserProvider().getUsers());

class UserProvider {
  CollectionReference _dbModel = FirebaseFirestore.instance.collection('users');
  Stream<List<User>> getUsers() {
    final data = _dbModel.snapshots().map((event) => _getFromSnap(event));

    return data;
  }

  List<User> _getFromSnap(QuerySnapshot querySnapshot) {
    return querySnapshot.docs
        .map((e) => User.fromJson(e.data() as Map<String, dynamic>))
        .toList();
  }
}
