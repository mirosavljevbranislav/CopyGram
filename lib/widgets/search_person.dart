// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class SearchPerson extends StatefulWidget {
  String? username;
  int? followers;
  int? following;
  SearchPerson({
    @required this.username,
    @required this.followers,
    @required this.following,
  });

  @override
  State<SearchPerson> createState() => _SearchPersonState();
}

class _SearchPersonState extends State<SearchPerson> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Image'),
        SizedBox(width: 30),
        Text(widget.username.toString()),
        SizedBox(
          width: 30,
        ),
        Column(
          children: [
            Text(widget.followers.toString()),
            SizedBox(
              height: 5,
            ),
            Text(widget.following.toString()),
          ],
        )
      ],
    );
  }
}
