// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable


import 'package:flutter/material.dart';

class ProfilePostWidget extends StatefulWidget {
  String pictureID;
  List comments;
  String description;
  int likes;
  String location;
  String userID;

  ProfilePostWidget(
      {Key? key,
      required this.pictureID,
      required this.comments,
      required this.description,
      required this.likes,
      required this.location,
      required this.userID})
      : super(key: key);

  @override
  State<ProfilePostWidget> createState() => _ProfilePostWidgetState();
}

class _ProfilePostWidgetState extends State<ProfilePostWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: Material(
        child: Column(children: [
          SizedBox(
            child: Padding(
              padding: EdgeInsets.only(top: 25),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.pictureID.toString()),
              ),
            ),
            height: MediaQuery.of(context).size.height / 2.5,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            padding: const EdgeInsets.only(left: 5, right: 5),
            width: double.infinity,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.thumb_up),
                    ),
                  ),
                  Text(widget.likes.toString()),
                  Flexible(
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.flag),
                    ),
                  ),
                ]),
          ),
          Column(
            children: [
              Text('Hello '),
              Text('Hello '),
              Text('Hello '),
              Text('Hello '),
              Text('Hello '),
            ],
          )
        ]),
      ),
    );
  }
}
