// ignore_for_file: prefer_const_constructors

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
  State<FollowingFollowersWidget> createState() => _FollowingFollowersWidgetState();
}


class _FollowingFollowersWidgetState extends State<FollowingFollowersWidget> {

  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.username.toString()),
          bottom: TabBar(tabs: [
            Tab(text: '${widget.followers?.length.toString()} followers'),
            Tab(text: '${widget.following?.length.toString()} following'),
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
              widget.followers!.isEmpty
                  ? Center(
                      child: Text('Currently you have no followers'),
                    )
                  : ListView.builder(
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
              widget.followers!.isEmpty
                  ? Center(
                      child: Text('Currently you don\'t follow anyone'),
                    )
                  : ListView.builder(
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
