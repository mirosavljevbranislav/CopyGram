// ignore_for_file: prefer_const_constructors, avoid_print, avoid_function_literals_in_foreach_calls, must_be_immutable, prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:igc2/models/user.dart';
import 'package:igc2/widgets/profile/following_followers_widget.dart';
import '../../screens/profile/post_screen.dart';
import '../profile/post/post_list_widget.dart';

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
    Color? themeColor = Theme.of(context).primaryColor;
    Color? secondaryColor = Theme.of(context).primaryColorLight;
    final args = ModalRoute.of(context)!.settings.arguments as PersonProfile;
    List newList;
    List listlength = [];

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
    FirebaseFirestore.instance.collection("posts").get().then((value) {
      value.docs.forEach((result) {
        listlength.add(value);
      });
    });
    return Scaffold(
        appBar: AppBar(
            title: Text(args.searchedUser!.username.toString()),
            backgroundColor: themeColor),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (ctx, AsyncSnapshot<QuerySnapshot> streamsnapshot) {
              return Container(
                color: themeColor,
                child: Column(
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
                              style: TextStyle(color: secondaryColor),
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
                                style: TextStyle(color: secondaryColor)),
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 15),
                              primary: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, FollowingFollowersWidget.routeName,
                                  arguments: FollowingFollowersWidget(
                                    user: args.searchedUser,
                                    index: 0,
                                  ));
                            },
                          ),
                          TextButton(
                            child: Text(
                                '${args.searchedUser?.following?.length.toString()}  \nFollowing',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: secondaryColor)),
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 15),
                              primary: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, FollowingFollowersWidget.routeName,
                                  arguments: FollowingFollowersWidget(
                                    user: args.searchedUser,
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
                      child: Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s'
                          'standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make'
                          ' a type specimen book. ',
                          style: TextStyle(color: secondaryColor)),
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
                                      child: Text(
                                        'Unfollow',
                                      ),
                                      style: TextButton.styleFrom(
                                        backgroundColor: secondaryColor,
                                        primary: themeColor,
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
                                        backgroundColor: secondaryColor,
                                        primary: themeColor,
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
                              return Flexible(
                                child: Column(children: [
                                  Flexible(
                                    child: GridView.count(
                                        crossAxisCount: 3,
                                        children: List.generate(
                                            args.searchedUser!.postURL!.length,
                                            (index) => InkWell(
                                                  onTap: () {
                                                    print(
                                                        'LIST LENGTH ${listlength.length}');
                                                    SearchedUser user = SearchedUser(
                                                        email: args
                                                            .searchedUser!
                                                            .email,
                                                        fullname: args
                                                            .searchedUser!
                                                            .fullname,
                                                        username: args
                                                            .searchedUser!
                                                            .username,
                                                        posts: args
                                                            .searchedUser!
                                                            .posts,
                                                        followers: args
                                                            .searchedUser!
                                                            .followers,
                                                        following: args
                                                            .searchedUser!
                                                            .following,
                                                        postURL: args
                                                            .searchedUser!
                                                            .postURL,
                                                        pictureID: args
                                                            .searchedUser!
                                                            .pictureID,
                                                        userID: args
                                                            .searchedUser!
                                                            .userID);
                                                    Navigator.pushNamed(context,
                                                        PostScreen.routeName,
                                                        arguments:
                                                            ProfilePostListWidget(
                                                          listLength:
                                                              listlength.length,
                                                          indexToScroll: index,
                                                          searchedUser: user,
                                                        ));
                                                  },
                                                  child: Image.network(
                                                    args.searchedUser!
                                                        .postURL![index],
                                                  ),
                                                ))),
                                  ),
                                ]),
                              );
                            }),
                      ]),
                    )
                  ],
                ),
              );
            }));
  }
}
