import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart' as user_model;

class DataRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  addUser(user_model.User user, String? authInfo) {
    collection.doc(authInfo.toString()).set(user.toJson());
  }

  void updateUser(user_model.User user) async {
    await collection.doc(user.email).update(user.toJson());
  }

  void deleteUser(String email) async {
    await collection.doc(email).delete();
  }
}
