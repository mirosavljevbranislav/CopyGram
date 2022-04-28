// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:igc2/screens/profile_screen.dart';
import 'package:igc2/screens/searched_user_screen.dart';
import 'package:igc2/widgets/search/person_profile.dart';

class SearchList extends StatefulWidget {
  String? username;
  String? email;
  String? pictureID;
  List? followers;
  List? following;
  int? posts;
  String? userID;

  SearchList({
    Key? key,
    required this.email,
    required this.username,
    required this.pictureID,
    required this.followers,
    required this.following,
    required this.posts,
    required this.userID,
  }) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  String? userEmail = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.email == userEmail) {
          Navigator.pushNamed(context, ProfileScreen.routeName);
        } else {
          Navigator.pushNamed(context, SearchedUserScreen.routeName,
              arguments: PersonProfile(
                username: widget.username.toString(),
                email: widget.email,
                pictureID: widget.pictureID,
                followers: widget.followers,
                following: widget.followers,
                posts: widget.posts,
                userid: widget.userID,
              ));
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(widget.pictureID.toString()),
          ),
          SizedBox(width: 30),
          Text(widget.username.toString()),
          SizedBox(
            width: 30,
          ),
          Column(
            children: [
              Text('${widget.followers?.length.toString()} followers'),
              SizedBox(
                height: 5,
              ),
              Text('${widget.following?.length.toString()} following'),
            ],
          )
        ],
      ),
    );
  }
}
