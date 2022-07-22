// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:igc2/widgets/home/story/add_story.dart';

class NoStoryWidget extends StatefulWidget {
  String? pictureID;
  Color? secondaryColor;
  Map<String, dynamic>? user;

  NoStoryWidget({
    this.pictureID,
    this.secondaryColor,
    this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<NoStoryWidget> createState() => _NoStoryWidgetState();
}

class _NoStoryWidgetState extends State<NoStoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InkWell(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              margin: EdgeInsets.only(left: 5, right: 5, bottom: 2),
              child: Stack(alignment: Alignment.center, children: [
                CircleAvatar(
                  radius: 37,
                  backgroundColor: Colors.black,
                ),
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(widget.pictureID!),
                ),
              ]),
            ),
            CircleAvatar(
                radius: 15,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ))
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, AddStoryWidget.routeName,
              arguments: AddStoryWidget(user: widget.user));
        },
      ),
      Text(
        'Your story',
        style: TextStyle(fontSize: 14, color: widget.secondaryColor),
      )
    ]);
  }
}
