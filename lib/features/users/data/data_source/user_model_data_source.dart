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

  Future<User> getLoginUserData(String userId) async {
    final response = await _dbModel.where('userId', isEqualTo: userId).get();
    return User.fromJson(response.docs[0].data() as Map<String, dynamic>);
  }
}
