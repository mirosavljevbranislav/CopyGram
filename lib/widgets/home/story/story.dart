// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

import '../../../models/user.dart';

class StoryPageView extends StatefulWidget {
  static const routeName = '/stories';
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
    final args = ModalRoute.of(context)!.settings.arguments as StoryPageView;
    if (args.user!.stories != null) {
      return Material(
        child: Stack(children: [
          StoryView(
            onComplete: () {},
            storyItems: [
              for (var i in args.user!.stories!)
                StoryItem.pageImage(
                    url: i,
                    controller: storyController),
            ],
            controller: storyController,
            inline: false,
            repeat: true,
          ),
          Text(args.user!.username!)
        ]),
      );
    }
    return Container();
  }
}
