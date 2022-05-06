// ignore_for_file: prefer_const_constructors, avoid_print, avoid_function_literals_in_foreach_calls, must_be_immutable, prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:igc2/models/user.dart';
import 'package:igc2/widgets/profile/following_followers_widget.dart';

import '../../screens/profile/following_followers_screen.dart';

class PersonProfile extends StatefulWidget {
  SearchedUser? searchedUser;

  PersonProfile({
    Key? key,
    this.searchedUser,
  }) : super(key: key);

  @override
  State<PersonProfile> createState() => _PersonProfileState();
}

class _PersonProfileState extends State<PersonProfile> {
  String? userID = FirebaseAuth.instance.currentUser?.uid;
  var followCheck;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as PersonProfile;
    List newList;
    List listOfPosts = [];

    updateUser() {
      users.doc(args.searchedUser?.userID).update({
        'email': args.searchedUser?.email,
        'fullname': args.searchedUser?.fullname,
        'username': args.searchedUser?.username,
        'posts': args.searchedUser?.posts,
        'followers': args.searchedUser?.followers,
        'following': args.searchedUser?.following,
        'pictureID': args.searchedUser?.pictureID,
        'userID': args.searchedUser?.userID,
      });
    }

    unfollowUser() {
      args.searchedUser?.followers
          ?.removeWhere(((element) => element == userID));
      updateUser();

      FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (doc['userID'] == userID) {
            newList = doc['following'];
            newList.removeWhere(
                ((element) => element == args.searchedUser?.userID));
            users.doc(userID).update({
              'email': doc['email'],
              'fullname': doc['fullname'],
              'username': doc['username'],
              'posts': doc['posts'],
              'followers': doc['followers'],
              'following': newList,
              'pictureID': doc['pictureID'],
              'userID': doc['userID'],
            });
          }
        });
      });
    }

    followUser() {
      args.searchedUser?.followers?.add(userID);

      updateUser();
      FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (doc['userID'] == userID) {
            newList = doc['following'];
            newList.add(args.searchedUser?.userID);
            users.doc(userID).update({
              'email': doc['email'],
              'fullname': doc['fullname'],
              'username': doc['username'],
              'posts': doc['posts'],
              'followers': doc['followers'],
              'following': newList,
              'pictureID': doc['pictureID'],
              'userID': doc['userID'],
            });
          }
        });
      });
    }

    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['followers'].contains(userID)) {
          followCheck = true;
        } else {
          followCheck = false;
        }
      });
    });
    return Scaffold(
        appBar: AppBar(
          title: Text(args.searchedUser!.username.toString()),
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
                            backgroundImage: NetworkImage(
                                args.searchedUser!.pictureID.toString()),
                          ),
                        ),
                        TextButton(
                          child: Text(
                            '${args.searchedUser?.posts?.toString()}  \nPosts',
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
                            '${args.searchedUser?.followers?.length.toString()}  \nFollowers',
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
                                  username: args.searchedUser?.username,
                                  followers: args.searchedUser?.followers,
                                  following: args.searchedUser?.following,
                                  index: 0,
                                ));
                          },
                        ),
                        TextButton(
                          child: Text(
                            '${args.searchedUser?.following?.length.toString()}  \nFollowing',
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
                                  username: args.searchedUser?.username,
                                  followers: args.searchedUser?.followers,
                                  following: args.searchedUser?.following,
                                  index: 1,
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
                          args.searchedUser!.followers!.contains(userID)
                              ? Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        followCheck != followCheck;
                                        unfollowUser();
                                      });
                                    },
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
                                      setState(() {
                                        followCheck != followCheck;
                                        followUser();
                                      });
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
                              if (args.searchedUser?.userID ==
                                  streamsnapshot.data!.docs[i]['userID']) {
                                listOfPosts.add(streamsnapshot.data!.docs[i]);
                              }
                            }
                            return Flexible(
                              child: GridView.count(
                                crossAxisCount: 3,
                                children: listOfPosts.map((e) {
                                  return InkWell(
                                    onTap: () {
                                      print(e['comments']);
                                      print(e['description']);
                                      print(e['likes']);
                                      print(e['location']);
                                      print(e['picture']);
                                      print(e['userID']);

                                    },
                                    child: Image.network(e['picture']),
                                  );
                                }).toList(),
                              ),
                            );
                          }),
                    ]),
                  )
                ],
              );
            }));
  }
}
