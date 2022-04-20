// ignore_for_file: prefer_const_constructors

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
  final List? posts;

  const PersonProfile({
    Key? key,
    this.username,
    this.email,
    this.pictureID,
    this.followers,
    this.following,
    this.posts,
  }) : super(key: key);

  @override
  State<PersonProfile> createState() => _PersonProfileState();
}

class _PersonProfileState extends State<PersonProfile> {
  String? userEmail = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as PersonProfile;
    return Scaffold(
        appBar: AppBar(
          title: Text(args.username.toString()),
        ),
        body: Material(
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
                        backgroundImage:
                            NetworkImage(args.pictureID.toString()),
                      ),
                    ),
                    TextButton(
                      child: Text(
                        '${args.posts?.length.toString()}  \nPosts',
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
                        '${args.posts?.length.toString()}  \nFollowing',
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
              Container(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Text('Follow'),
                          style: TextButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
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
          ),
        ));
  }
}
