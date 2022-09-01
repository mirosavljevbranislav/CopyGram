// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, avoid_print, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:igc2/models/user.dart';
import 'package:igc2/widgets/search/search_list.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  String? searchedUser; //Username for searching

  @override
  Widget build(BuildContext context) {
    Color? themeColor = Theme.of(context).primaryColor;
    Color? secondaryColor = Theme.of(context).primaryColorLight;
    return Material(
      child: Container(
        color: themeColor,
        child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(top: 65, left: 5, right: 5),
                child: TextField(
                  style: TextStyle(color: secondaryColor),
                  onChanged: (value) {
                    setState(() {
                      searchedUser = value;
                    });
                  },
                  controller: null,
                  decoration: InputDecoration(
                      fillColor: Colors.grey,
                      labelText: "Search people",
                      filled: true,
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .snapshots(),
                      builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                        final document = snapshot.data?.docs;
                        return ListView.builder(
                            itemCount: document?.length,
                            itemBuilder: (context, index) {
                              if (searchedUser == null) {
                                return Text('');
                              }
                              if (document?[index]['username']
                                  .contains(searchedUser)) {
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(8, 5, 0, 5),
                                  child: SearchList(
                                    searchedUser: SearchedUser(
                                      email: document?[index]['email'],
                                      fullname: document?[index]['fullname'],
                                      username: document?[index]['username'],
                                      posts: document?[index]['posts'],
                                      followers: document?[index]['followers'],
                                      following: document?[index]['following'],
                                      stories: document?[index]['stories'],
                                      viewedStories: document?[index]['viewedStories'],
                                      pictureID: document?[index]['pictureID'],
                                      userID: document?[index]['userID'],
                                      postURL: document?[index]['postURL'],
                                      description: document?[index]['description'],
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            });
                      }))
            ])),
      ),
    );
  }
}
