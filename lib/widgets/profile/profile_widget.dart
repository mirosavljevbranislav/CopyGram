// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, must_be_immutable, avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:igc2/screens/following_followers_screen.dart';
import 'package:igc2/widgets/profile/following_followers_widget.dart';

class ProfileWidget extends StatefulWidget {
  String? email;
  String? username;
  String? fullname;
  String? pictureID;
  List? followers;
  List? following;
  int? posts;
  List listOfPosts = [];

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

  String? userEmail = FirebaseAuth.instance.currentUser?.email;
  String? currentUserID = FirebaseAuth.instance.currentUser?.uid;

  _loadUsers() {
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['email'] == userEmail) {
          print(doc["email"]);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List listOfPosts = [];
    _loadUsers();
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
                              child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                      widget.pictureID.toString())),
                            ),
                            TextButton(
                              child: Text(
                                '${widget.posts}\nPosts',
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
                                '${widget.followers?.length.toString()}\nFollowers',
                                textAlign: TextAlign.center,
                              ),
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 15),
                                primary: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, FollowingFollowersScreen.routeName,
                                    arguments: FollowingFollowersWidget(
                                      username: widget.username,
                                      followers: widget.followers,
                                      following: widget.following,
                                    ));
                              },
                            ),
                            TextButton(
                              child: Text(
                                '${widget.following?.length.toString()}\nFollowing',
                                textAlign: TextAlign.center,
                              ),
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 15),
                                primary: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, FollowingFollowersScreen.routeName,
                                    arguments: FollowingFollowersWidget(
                                      username: widget.username,
                                      followers: widget.followers,
                                      following: widget.following,
                                    ));
                              },
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Text(
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s'
                            'standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make'
                            ' a type specimen book. '),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
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
                      Flexible(
                        child: Column(children: [
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('posts')
                                  .snapshots(),
                              builder: (ctx,
                                  AsyncSnapshot<QuerySnapshot> streamsnapshot) {
                                if (streamsnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                for (int i = 0;
                                    i < streamsnapshot.data!.docs.length;
                                    i++) {
                                  if (currentUserID ==
                                      streamsnapshot.data!.docs[i]['userID']) {
                                    listOfPosts
                                        .add(streamsnapshot.data!.docs[i]);
                                  }
                                }
                                return Flexible(
                                  child: GridView.count(
                                    crossAxisCount: 3,
                                    children: listOfPosts.map((e) {
                                      return Center(
                                        child: Image.network(e['picture']),
                                      );
                                    }).toList(),
                                  ),
                                );
                              }),
                        ]),
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
