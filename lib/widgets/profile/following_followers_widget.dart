// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FollowingFollowersWidget extends StatefulWidget {
  String? username;
  List? followers;
  List? following;
  int? index;

  FollowingFollowersWidget(
      {Key? key,
      @required this.username,
      @required this.followers,
      @required this.following,
      @required this.index})
      : super(key: key);

  @override
  State<FollowingFollowersWidget> createState() =>
      _FollowingFollowersWidgetState();
}

class _FollowingFollowersWidgetState extends State<FollowingFollowersWidget> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as FollowingFollowersWidget;
    return DefaultTabController(
      initialIndex: args.index!,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(args.username.toString()),
          bottom: TabBar(tabs: [
            Tab(text: '${args.followers?.length.toString()} followers'),
            Tab(text: '${args.following?.length.toString()} following'),
          ]),
        ),
        body: TabBarView(
          children: [
            Column(children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: null,
                  decoration: InputDecoration(
                      labelText: "Search followers",
                      hintText: "Search followers",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              args.followers == null
                  ? Center(
                      child: Text('Currently no followers'),
                    )
                  : Expanded(
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .snapshots(),
                          builder:
                              (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: args.followers?.length,
                              itemBuilder: (ctx, index) =>
                                  Text(args.followers?[index]),
                            );
                          }),
                    )
            ]),
            Column(children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: null,
                  decoration: InputDecoration(
                      labelText: "Search following",
                      hintText: "Search following",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              args.followers == null
                  ? Center(
                      child: Text('Currently no following'),
                    )
                  : Expanded(
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .snapshots(),
                          builder:
                              (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: args.following?.length,
                              itemBuilder: (ctx, index) =>
                                  Text(args.following?[index]),
                            );
                          }),
                    )
            ]),
          ],
        ),
      ),
    );
  }
}
