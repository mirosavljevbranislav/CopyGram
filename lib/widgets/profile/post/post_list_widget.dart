// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:igc2/models/user.dart';
import 'package:igc2/widgets/profile/post/single_post_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../models/post.dart';

class ProfilePostListWidget extends StatefulWidget {
  int listLength;
  int indexToScroll;
  SearchedUser searchedUser;

  ProfilePostListWidget({
    required this.listLength,
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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (ctx, AsyncSnapshot<QuerySnapshot> streamsnapshot) {
            if (streamsnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final documents = streamsnapshot.data?.docs;
            return Expanded(
              // color: themeColor,
              child: ScrollablePositionedList.builder(
                shrinkWrap: true,
                  initialScrollIndex: widget.indexToScroll,
                  itemScrollController: null,
                  itemCount: widget.searchedUser.posts!,
                  itemBuilder: (context, index) => documents![index]['userID'] == (widget.searchedUser.userID)
                      ? SinglePostWidget(
                          post: Post(
                            profilePictureID: documents[index]['profilePictureID'],
                            username: documents[index]['username'],
                            userID: documents[index]['userID'],
                            postID: documents[index]['postID'],
                            picture: documents[index]['picture'],
                            location: documents[index]['location'],
                            description: documents[index]['description'],
                            likes: documents[index]['likes'],
                            comments: documents[index]['comments'],
                            pictureTakenAt: documents[index]['pictureTakenAt'],
                          ),
                        )
                      : Container()),
            );
          }),
    );
  }
}
