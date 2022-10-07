// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

import '../../../models/user.dart';

class StoryPageView extends StatefulWidget {
  SearchedUser? user;
  StoryPageView({
    this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<StoryPageView> createState() => _StoryPageViewState();
}

class _StoryPageViewState extends State<StoryPageView> {
  final storyController = StoryController();
  @override
  Widget build(BuildContext context) {
    if (widget.user!.stories != null) {
      return Material(
        child: Stack(children: [
          StoryView(
            onComplete: () {
              // storyController.next();
              Navigator.pop(context);
            },
            storyItems: [
              for (var i in widget.user!.stories!)
                StoryItem.pageImage(url: i, controller: storyController),
            ],
            controller: storyController,
            inline: false,
            repeat: false,
          ),
          Row(children: [
            Padding(
              padding: const EdgeInsets.only(top: 60, left: 20),
              child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(widget.user!.pictureID!)),
            ),
            Container(
                padding: const EdgeInsets.only(top: 60, left: 14),
                child: Text(
                  widget.user!.username!,
                  style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                ))
          ])
        ]),
      );
    }
    return Container();
  }
}
