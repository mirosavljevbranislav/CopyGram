// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:igc2/screens/following_followers_screen.dart';

class ProfileWidget extends StatefulWidget {
  String? email;
  String? username;
  String? fullname;
  String? pictureID;
  List? followers;
  List? following;
  List? posts;

  ProfileWidget({
    Key? key,
    @required this.email,
    @required this.username,
    @required this.fullname,
    @required this.pictureID,
    @required this.followers,
    @required this.following,
    @required this.posts,
  }) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  File? profileImage;

  Future<QuerySnapshot<Map<String, dynamic>>> getImages() {
    return FirebaseFirestore.instance.collection("images").get();
  }

  String? userEmail = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username.toString()),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> streamsnapshot) {
          if (streamsnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            child: userEmail == widget.email
                ? Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(top: 25),
                                child: Image.network('https://firebasestorage.googleapis.com/v0/b/igcopy-c7e20.appspot.com/o/images%2Fscaled_bc811765-6f9c-4722-9a0d-ec150578b79d5302304234631337468.jpg?alt=media&token=59cea240-b418-4fe9-b53f-bada02f51f64', height: 120, width: 120,)),
                            TextButton(
                              child: Text(
                                '${widget.posts?.length.toString()}  \nPosts',
                                textAlign: TextAlign.center,
                              ),
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 15),
                                primary: Colors.black,
                              ),
                              onPressed: () {},
                            ),
                            TextButton(
                              child: Text(
                                '${widget.followers?.length.toString()}  \nFollowers',
                                textAlign: TextAlign.center,
                              ),
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 15),
                                primary: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, FollowingFollowersScreen.routeName, arguments: 1);
                              },
                            ),
                            TextButton(
                              child: Text(
                                '${widget.posts?.length.toString()}  \nFollowing',
                                textAlign: TextAlign.center,
                              ),
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 15),
                                primary: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, FollowingFollowersScreen.routeName, arguments: 1);
                              },
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text('Description will go here'),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {},
                          child: Text('Edit profile'),
                          style: TextButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            primary: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: const [
                          Icon(Icons.error_outline),
                          Text('This user currently has no pictures...')
                        ],
                      )
                    ],
                  )
                : null,
          );
        },
      ),
    );
  }
}
