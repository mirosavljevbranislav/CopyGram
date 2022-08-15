// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, must_be_immutable, avoid_print, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:igc2/models/user.dart';
import 'package:igc2/widgets/profile/following_followers_widget.dart';
import 'package:igc2/widgets/profile/post/post_list_widget.dart';

class ProfileWidget extends StatefulWidget {
  SearchedUser user;

  ProfileWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  String? userEmail = FirebaseAuth.instance.currentUser?.email;
  String? currentUserID = FirebaseAuth.instance.currentUser?.uid;
  List listlength = [];

  @override
  Widget build(BuildContext context) {
    Color? themeColor = Theme.of(context).primaryColor;
    Color? secondaryColor = Theme.of(context).primaryColorLight;
    FirebaseFirestore.instance.collection("posts").get().then((value) {
      value.docs.forEach((result) {
        listlength.add(value);
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.username.toString()),
        automaticallyImplyLeading: false,
        backgroundColor: themeColor,
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
            color: themeColor,
            child: userEmail == widget.user.email
                ? Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 25),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                  widget.user.pictureID.toString(),
                                ),
                              ),
                            ),
                            TextButton(
                              child: Text(
                                '${widget.user.posts}\nPosts',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: secondaryColor),
                              ),
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 15),
                              ),
                              onPressed: () {},
                            ),
                            TextButton(
                              child: Text(
                                '${widget.user.followers?.length.toString()}\nFollowers',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: secondaryColor),
                              ),
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 15),
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return FollowingFollowersWidget(
                                      user: widget.user, index: 0);
                                }));
                              },
                            ),
                            TextButton(
                              child: Text(
                                '${widget.user.following?.length.toString()}\nFollowing',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: secondaryColor),
                              ),
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 15),
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return FollowingFollowersWidget(
                                      user: widget.user, index: 1);
                                }));
                              },
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s'
                          'standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make'
                          ' a type specimen book. ',
                          style: TextStyle(color: secondaryColor),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {},
                          child: Text('Edit profile'),
                          style: TextButton.styleFrom(
                            backgroundColor: secondaryColor,
                            primary: themeColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Flexible(
                        child: Container(
                          color: themeColor,
                          child: Column(children: [
                            Flexible(
                              child: GridView.count(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 3,
                                  crossAxisSpacing: 3,
                                  children: List.generate(
                                    
                                      widget.user.postURL!.length,
                                      (index) => InkWell(
                                            onTap: () {
                                              SearchedUser user = SearchedUser(
                                                  email: widget.user.email,
                                                  fullname: widget.user.fullname,
                                                  username: widget.user.username,
                                                  posts: widget.user.posts,
                                                  followers: widget.user.followers,
                                                  following: widget.user.following,
                                                  postURL: widget.user.postURL,
                                                  stories: widget.user.stories,
                                                  viewedStories: widget.user.viewedStories,
                                                  pictureID: widget.user.pictureID,
                                                  userID: widget.user.userID);
                                              Navigator.push(context,
                                                  MaterialPageRoute( builder: (context) { 
                                                    return ProfilePostListWidget(
                                                    listLength: listlength.length,
                                                    indexToScroll: index,
                                                    searchedUser: user);
                                              }));
                                            },
                                            child: Image.network(
                                              widget.user.postURL![index],
                                            ),
                                          ))),
                            )
                          ]),
                        ),
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
