import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../models/user.dart';

class AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final _auth = firebase_auth.FirebaseAuth.instance;

  AuthRepository({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  var currentUser;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      currentUser = user;
      return user;
    });
  }

  Future<void> singup({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
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

extension on firebase_auth.User {
  User get toUser {
    return User(userID: uid, email: email, username: displayName, pictureID: photoURL);
  }
}
