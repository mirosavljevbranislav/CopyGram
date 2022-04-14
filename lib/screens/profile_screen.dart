import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:igc2/widgets/profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userEmail = FirebaseAuth.instance.currentUser!.email;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
          final document = snapshot.data!.docs;
          for (int i = 0; i < document.length; i++) {
            if (userEmail == document[i]['email']) {
              return ProfileWidget(
                email: document[i]['email'],
                username: document[i]['username'],
                fullname: document[i]['fullname'],
                pictureID: document[i]['pictureID'],
                followers: document[i]['followers'],
                following: document[i]['following'],
                posts: document[i]['followers'],
              );
            }
          }
          return const Text('Oops, something went wrong... :)');
        });
  }
}
