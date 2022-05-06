import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:igc2/widgets/profile/following_followers_widget.dart';

class FollowingFollowersScreen extends StatefulWidget {
  static const routeName = '/following';
  const FollowingFollowersScreen({Key? key}) : super(key: key);

  @override
  State<FollowingFollowersScreen> createState() =>
      _FollowingFollowersScreenState();
}

class _FollowingFollowersScreenState extends State<FollowingFollowersScreen> {
  String? userEmail = FirebaseAuth.instance.currentUser?.email;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
        final document = snapshot.data?.docs;
        if (document != null) {
          for (int i = 0; i < document.length; i++) {
            if (userEmail == document[i]['email']) {
              return FollowingFollowersWidget(
                username: document[i]['username'],
                followers: document[i]['followers'],
                following: document[i]['following'],
              );
            }
          }
        }
        return const Text('Oops, something went wrong... :)');
      },
    );
  }
}
