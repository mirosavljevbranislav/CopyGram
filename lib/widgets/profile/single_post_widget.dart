// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, must_be_immutable, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:igc2/models/post.dart';
import 'package:igc2/models/user.dart';

class SinglePostWidget extends StatefulWidget {
  Post? post;
  SearchedUser? searchedUser;

  SinglePostWidget({
    required this.post,
    this.searchedUser,
    Key? key,
  }) : super(key: key);

  @override
  State<SinglePostWidget> createState() => _SinglePostWidgetState();
}

class _SinglePostWidgetState extends State<SinglePostWidget> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> postJson = widget.post!.toJson();
    Map<String, dynamic> userJson = widget.searchedUser!.toJson();
    String? userID = FirebaseAuth.instance.currentUser?.uid;
    CollectionReference posts = FirebaseFirestore.instance.collection('posts');

    _likePicture() {
      postJson['likes'].add(userID);

      FirebaseFirestore.instance
          .collection('posts')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (doc['postID'] == postJson['postID']) {
            posts.doc(postJson['postID']).update({
              'comments': doc['comments'],
              'description': doc['description'],
              'likes': postJson['likes'],
              'location': doc['location'],
              'picture': doc['picture'],
              'pictureTakenAt': doc['pictureTakenAt'],
              'postID': doc['postID'],
              'userID': doc['userID'],
            });
          }
        });
      });
    }

    _dislikePicture() {
      postJson['likes'].removeWhere((element) => element == userID);
      FirebaseFirestore.instance
          .collection('posts')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (doc['postID'] == postJson['postID']) {
            posts.doc(postJson['postID']).update({
              'comments': doc['comments'],
              'description': doc['description'],
              'likes': postJson['likes'],
              'location': doc['location'],
              'picture': doc['picture'],
              'pictureTakenAt': doc['pictureTakenAt'],
              'postID': doc['postID'],
              'userID': doc['userID'],
            });
          }
        });
      });
    }

    return Material(
      child: Column(children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5, left: 5),
              child: CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      NetworkImage(userJson['pictureID'].toString())),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userJson['username']),
                Text(postJson['location']),
              ],
            ),
          ],
        ),
        SizedBox(
          child: Image.network(postJson['picture'].toString()),
          height: MediaQuery.of(context).size.height / 2.5,
          width: MediaQuery.of(context).size.width,
        ),
        Container(
          padding: const EdgeInsets.only(left: 5, right: 5),
          width: double.infinity,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                postJson['likes'].contains(postJson['userID'])
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _dislikePicture();
                          });
                        },
                        icon: const Icon(Icons.thumb_up_alt),
                      )
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            _likePicture();
                          });
                        },
                        icon: const Icon(Icons.thumb_up_alt_outlined),
                      ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.comment),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
            Flexible(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.flag),
              ),
            ),
          ]),
        ),
        Container(
          child: Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text('${postJson['likes'].length.toString()} likes')),
          alignment: Alignment.centerLeft,
        ),
        Row(
          children: [
            Padding(
                padding: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
                child: Text(
                  userJson['username'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            Padding(padding: EdgeInsets.only(top: 5, bottom: 5),child: Text(postJson['description'])),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            Text('Hello '),
            Text('Hello '),
            Text('Hello '),
            Text('Hello '),
            Text('Hello '),
          ],
        )
      ]),
    );
  }
}
