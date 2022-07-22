// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:igc2/models/user.dart';
import 'package:igc2/widgets/search/search_list.dart';

class FollowingFollowersWidget extends StatefulWidget {
  static const routeName = '/followers';
  SearchedUser? user;
  int? index;

  FollowingFollowersWidget({Key? key, @required this.user, this.index})
      : super(key: key);

  @override
  State<FollowingFollowersWidget> createState() =>
      _FollowingFollowersWidgetState();
}

class _FollowingFollowersWidgetState extends State<FollowingFollowersWidget> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as FollowingFollowersWidget;
    return DefaultTabController(
      initialIndex: args.index!,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(args.user!.username.toString()),
          bottom: TabBar(tabs: [
            Tab(text: '${args.user!.followers?.length.toString()} followers'),
            Tab(text: '${args.user!.following?.length.toString()} following'),
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
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              args.user!.followers == null
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
                            final documents = snapshot.data?.docs;
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: documents!.length,
                              itemBuilder: (ctx, index) => args.user!.followers!.contains(documents[index]['userID'])
                                  ? SearchList(
                                      searchedUser: SearchedUser(
                                          email: documents[index]['email'],
                                          fullname: documents[index]['fullname'],
                                          username: documents[index]['username'],
                                          posts: documents[index]['posts'],
                                          followers: documents[index]['followers'],
                                          following: documents[index]['following'],
                                          postURL: documents[index]['postURL'],
                                          stories: documents[index]['stories'],
                                          viewedStories: documents[index]['viewedStories'],
                                          pictureID: documents[index]['pictureID'],
                                          userID: documents[index]['userID']))
                                  : Container(),
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
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              args.user!.followers == null
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
                            final documents = snapshot.data?.docs;
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: documents!.length,
                              itemBuilder: (ctx, index) => args.user!.following!.contains(documents[index]['userID'])
                                  ? SearchList(
                                      searchedUser: SearchedUser(
                                          email: documents[index]['email'],
                                          fullname: documents[index]['fullname'],
                                          username: documents[index]['username'],
                                          posts: documents[index]['posts'],
                                          followers: documents[index]['followers'],
                                          following: documents[index]['following'],
                                          postURL: documents[index]['postURL'],
                                          stories: documents[index]['stories'],
                                          viewedStories: documents[index]['viewedStories'],
                                          pictureID: documents[index]['pictureID'],
                                          userID: documents[index]['userID']))
                                  : Container(),
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
