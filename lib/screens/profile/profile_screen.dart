// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:igc2/models/user.dart';
import 'package:igc2/widgets/profile/profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List listOfPosts = [];
  String? userEmail = FirebaseAuth.instance.currentUser?.email;
  String? currentUserID = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
          final document = snapshot.data?.docs;
          if (document != null) {
            for (int i = 0; i < document.length; i++) {
              if (userEmail == document[i]['email']) {
                return ProfileWidget(
                  user: SearchedUser(
                    email: document[i]['email'],
                    username: document[i]['username'],
                    fullname: document[i]['fullname'],
                    pictureID: document[i]['pictureID'],
                    followers: document[i]['followers'],
                    following: document[i]['following'],
                    stories: document[i]['stories'],
                    viewedStories: document[i]['viewedStories'],
                    postURL: document[i]['postURL'],
                    posts: document[i]['posts'],
                    userID: document[i]['userID'],
                    description: document[i]['description'],
                  ),
                );
              }
            }
          }
          return const Text('Oops, something went wrong... :)');
        });
  }
}
