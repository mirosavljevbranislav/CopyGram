// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, must_be_immutable

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
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    NetworkImage(widget.pictureID.toString()),
                              ),
                            ),
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
                                '${widget.posts?.length.toString()}  \nFollowing',
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
