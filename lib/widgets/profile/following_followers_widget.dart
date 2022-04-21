// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

class FollowingFollowersWidget extends StatefulWidget {
  String? username;
  List? followers;
  List? following;

  FollowingFollowersWidget({
    Key? key,
    @required this.username,
    @required this.followers,
    @required this.following,
  }) : super(key: key);

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
      initialIndex: 1,
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
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 0,
                      itemBuilder: (ctx, index) => Container(),
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
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 0,
                      itemBuilder: (ctx, index) => Container(),
                    )
            ]),
          ],
        ),
      ),
    );
  }
}
