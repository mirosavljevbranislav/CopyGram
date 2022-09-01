// ignore_for_file: must_be_immutable, prefer_const_constructors, avoid_print, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:igc2/widgets/home/story/story.dart';

import '../../../models/user.dart';

class YourStoryWidget extends StatefulWidget {
  SearchedUser? user;
  Color? secondaryColor;
  YourStoryWidget({
    this.user,
    this.secondaryColor,
    Key? key,
  }) : super(key: key);

  @override
  State<YourStoryWidget> createState() => _YourStoryWidgetState();
}

class _YourStoryWidgetState extends State<YourStoryWidget> {
  bool _checkStoryView() {
    // if (widget.user!.viewedStories!.contains(widget.user!.stories)){
    //   return true;
    // }
    // return false;
    for (int i = 0; i < widget.user!.stories!.length; i++) {
      for (int j = 0; j < widget.user!.viewedStories!.length; j++) {
        if (widget.user!.stories![i] == widget.user!.viewedStories![j]) {
          return true;
        }
        return false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Color? themeColor = Theme.of(context).primaryColor;
    Color? secondaryColor = Theme.of(context).primaryColorLight;
    Map<String, dynamic> userJson = widget.user!.toJson();
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    _seeStory(String storyID) {
      if (!userJson['viewedStories'].contains(storyID)) {
        userJson['viewedStories'].add(storyID);
      }

      FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (doc['userID'] == userJson['userID']) {
            users.doc(userJson['userID']).update({
              'viewedStories': userJson['viewedStories'],
            });
          }
        });
      });
    }

    return Column(children: [
      InkWell(
        onTap: () {
          setState(() {
            for (int i = 0; i < widget.user!.stories!.length; i++) {
              _seeStory(widget.user!.stories![i]);
            }
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return StoryPageView(user: widget.user);
            }));
          });
        },
        child: Container(
          margin: EdgeInsets.only(left: 5, right: 5, bottom: 2),
          child: Stack(alignment: Alignment.center, children: [
            CircleAvatar(
              radius: 39,
              backgroundColor: _checkStoryView() ? Colors.grey : Colors.red,
            ),
            CircleAvatar(
              radius: 37,
              backgroundColor: themeColor,
            ),
            CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(widget.user!.pictureID!),
            ),
          ]),
        ),
      ),
      Text(
        'Your story',
        style: TextStyle(fontSize: 14, color: widget.secondaryColor),
      )
    ]);
  }
}
