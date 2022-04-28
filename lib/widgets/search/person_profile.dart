// ignore_for_file: prefer_const_constructors, avoid_print, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:igc2/widgets/profile/following_followers_widget.dart';

import '../../screens/following_followers_screen.dart';

class PersonProfile extends StatefulWidget {
  final String? username;
  final String? email;
  final String? pictureID;
  final List? followers;
  final List? following;
  final int? posts;
  final String? userid;

  const PersonProfile({
    Key? key,
    this.username,
    this.email,
    this.pictureID,
    this.followers,
    this.following,
    this.posts,
    this.userid,
  }) : super(key: key);

  @override
  State<PersonProfile> createState() => _PersonProfileState();
}

class _PersonProfileState extends State<PersonProfile> {
  String? userID = FirebaseAuth.instance.currentUser?.uid;
  var check = false;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> unfollowUser() {
    return users
        .doc(userID)
        .update({'followers': FieldValue.delete()})
        .then((value) => print("User unfollowed"))
        .catchError(
            (error) => print("Failed to delete user's property: $error"));
  }

  Future<void> followUser(String followUser) {
    widget.followers?.add(followUser);
    print('username ${widget.username}');
    print('email ${widget.email}');
    print('pictureID ${widget.pictureID}');
    print('followers ${widget.followers}');
    print('following ${widget.following}');
    print('posts ${widget.posts}');
    print('userID ${widget.userid}');

    return users.doc(userID).update({
      'username': widget.username,
      'email': widget.email,
      'pictureID': widget.pictureID,
      'followers': FieldValue.arrayUnion([widget.followers]),
      'following': widget.followers,
      'posts': widget.posts,
      'userID': widget.userid,
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as PersonProfile;

    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['followers'].contains(userID)) {
          check = true;
        } else {
          check = false;
        }
      });
    });
    return Scaffold(
        appBar: AppBar(
          title: Text(args.username.toString()),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (ctx, AsyncSnapshot<QuerySnapshot> streamsnapshot) {
              return Column(
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
                                NetworkImage(args.pictureID.toString()),
                          ),
                        ),
                        TextButton(
                          child: Text(
                            '${args.posts?.toString()}  \nPosts',
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
                            '${args.followers?.length.toString()}  \nFollowers',
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
                                  username: args.username,
                                  followers: args.followers,
                                  following: args.following,
                                ));
                          },
                        ),
                        TextButton(
                          child: Text(
                            '${args.posts?.toString()}  \nFollowing',
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
                                  username: args.username,
                                  followers: args.followers,
                                  following: args.following,
                                ));
                          },
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: const Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s'
                        'standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make'
                        ' a type specimen book. '),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          check
                              ? Expanded(
                                  child: TextButton(
                                    onPressed: unfollowUser,
                                    child: Text('Unfollow'),
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      primary: Colors.black,
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      print(
                                          'EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE ${widget.userid}');
                                      followUser(widget.userid.toString());
                                    },
                                    child: Text('Follow'),
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      primary: Colors.black,
                                    ),
                                  ),
                                ),
                          SizedBox(width: 5),
                          Expanded(
                            child: TextButton(
                                onPressed: () {},
                                child: const Text('Message'),
                                style: TextButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).primaryColorLight,
                                    primary: Colors.black)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: const [
                      Icon(Icons.error_outline),
                      Text('This user currently has no pictures...')
                    ],
                  )
                ],
              );
            }));
  }
}
