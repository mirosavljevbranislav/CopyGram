import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../models/user.dart';

class AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final _auth = firebase_auth.FirebaseAuth.instance;
  final firebaseInstance = FirebaseFirestore.instance;

  AuthRepository({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;


  Future<SearchedUser> getUserById(String userID) async {
    final user = await firebaseInstance
        .collection("users")
        .where("userID", isEqualTo: userID)
        .get()
        .then((value) {
      for (var result in value.docs) {
        return SearchedUser(
            email: result.data()['email'],
            fullname: result.data()['fullname'],
            username: result.data()['username'],
            posts: result.data()['posts'],
            followers: result.data()['followers'],
            following: result.data()['following'],
            postURL: result.data()['postURL'],
            stories: result.data()['stories'],
            viewedStories: result.data()['viewedStories'],
            pictureID: result.data()['pictureID'],
            userID: result.data()['userID'],
            description: result.data()['description']);
      }
    });
  return user!;
  }

  Future<void> singup({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (_) {}
  }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (_) {}
  }

  Future<void> logOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut()]);
    } catch (_) {}
  }
}


