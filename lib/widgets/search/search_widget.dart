// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, avoid_print, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:igc2/widgets/search/search_list.dart';

class SearchWidget extends StatefulWidget {
  String? searchedUser;
  SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  String? searchedUser;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Column(children: [
            Padding(
              padding: EdgeInsets.only(top: 65, left: 5, right: 5),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchedUser = value;
                  });
                },
                controller: null,
                decoration: InputDecoration(
                    labelText: "Search people",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
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
                            if (searchedUser != null &&
                                document?[index]['username']
                                    .contains(searchedUser)) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(8, 5, 0, 5),
                                child: SearchList(
                                  email: document?[index]['email'],
                                  username: document?[index]['username'],
                                  pictureID: document?[index]['pictureID'],
                                  followers: document?[index]['followers'],
                                  following: document?[index]['following'],
                                  posts: document?[index]['posts'],
                                ),
                              );
                            } else if (searchedUser == null) {
                              ListView.builder(
                                itemCount: document?.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.fromLTRB(8, 5, 0, 5),
                                    child: SearchList(
                                      email: document?[index]['email'],
                                      username: document?[index]['username'],
                                      pictureID: document?[index]['pictureID'],
                                      followers: document?[index]['followers'],
                                      following: document?[index]['following'],
                                      posts: document?[index]['posts'],
                                    ),
                                  );
                                },
                              );
                            }
                            return ListView.builder(
                              itemCount: document?.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(8, 5, 0, 5),
                                  child: SearchList(
                                    email: document?[index]['email'],
                                    username: document?[index]['username'],
                                    pictureID: document?[index]['pictureID'],
                                    followers: document?[index]['followers'],
                                    following: document?[index]['following'],
                                    posts: document?[index]['posts'],
                                  ),
                                );
                              },
                            );
                          });
                    }))
          ])),
    );
  }
}
