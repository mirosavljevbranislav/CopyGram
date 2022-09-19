// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:igc2/models/user.dart';
import 'package:igc2/widgets/profile/post/single_post_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../models/post.dart';

class ProfilePostListWidget extends StatefulWidget {
  List listOfPosts;
  int indexToScroll;
  SearchedUser searchedUser;

  ProfilePostListWidget({
    required this.listOfPosts,
    required this.indexToScroll,
    required this.searchedUser,
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePostListWidget> createState() => _ProfilePostListWidgetState();
}

class _ProfilePostListWidgetState extends State<ProfilePostListWidget> {
  final itemController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => scrollToIndex(widget.indexToScroll));
  }

  void scrollToIndex(int index) => itemController.jumpTo(index: index);
  @override
  Widget build(BuildContext context) {
    Color? themeColor = Theme.of(context).primaryColor;
    Color? secondaryColor = Theme.of(context).primaryColorLight;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        backgroundColor: themeColor,
      ),
      body: Stack(children: [
        Expanded(
          child: ScrollablePositionedList.builder(
              shrinkWrap: true,
              initialScrollIndex: widget.indexToScroll,
              itemScrollController: null,
              itemCount: widget.searchedUser.posts!,
              itemBuilder: (context, index) => SinglePostWidget(
                      post: Post(
                        profilePictureID: widget.listOfPosts[index].docs[index]['profilePictureID'],
                        username: widget.listOfPosts[index].docs[index]['username'],
                        userID: widget.listOfPosts[index].docs[index]['userID'],
                        postID: widget.listOfPosts[index].docs[index]['postID'],
                        picture: widget.listOfPosts[index].docs[index]['picture'],
                        location: widget.listOfPosts[index].docs[index]['location'],
                        description: widget.listOfPosts[index].docs[index]['description'],
                        likes: widget.listOfPosts[index].docs[index]['likes'],
                        comments: widget.listOfPosts[index].docs[index]['comments'],
                        pictureTakenAt: widget.listOfPosts[index].docs[index]['pictureTakenAt'],
                      ),
                    )
                  ),
        ),
      ]),
    );
  }
}
