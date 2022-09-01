// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:igc2/models/user.dart';
import 'package:igc2/screens/profile/profile_screen.dart';
import 'package:igc2/widgets/search/person_profile.dart';

class SearchList extends StatefulWidget {
  SearchedUser? searchedUser;

  SearchList({
    Key? key,
    this.searchedUser,
  }) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  String? userEmail = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    Color? themeColor = Theme.of(context).primaryColor;
    Color? secondaryColor = Theme.of(context).primaryColorLight;
    return GestureDetector(
      onTap: () {
        if (widget.searchedUser?.email == userEmail) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ProfileScreen();
          }));
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PersonProfile(
              searchedUser: SearchedUser(
                  email: widget.searchedUser!.email,
                  fullname: widget.searchedUser!.fullname,
                  username: widget.searchedUser!.username.toString(),
                  posts: widget.searchedUser?.posts,
                  followers: widget.searchedUser?.followers,
                  following: widget.searchedUser?.following,
                  pictureID: widget.searchedUser?.pictureID,
                  stories: widget.searchedUser?.stories,
                  viewedStories: widget.searchedUser?.viewedStories,
                  userID: widget.searchedUser?.userID,
                  postURL: widget.searchedUser!.postURL,
                  description: widget.searchedUser!.description),
            );
          }));
        }
      },
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, top: 7),
            child: CircleAvatar(
              radius: 35,
              backgroundImage:
                  NetworkImage(widget.searchedUser!.pictureID.toString()),
            ),
          ),
          SizedBox(width: 30),
          Text(
            widget.searchedUser!.username.toString(),
            style: TextStyle(color: secondaryColor),
          ),
          SizedBox(
            width: 30,
          ),
          Column(
            children: [
              Text(
                '${widget.searchedUser?.followers?.length.toString()} followers',
                style: TextStyle(color: secondaryColor),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${widget.searchedUser?.following?.length.toString()} following',
                style: TextStyle(color: secondaryColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
