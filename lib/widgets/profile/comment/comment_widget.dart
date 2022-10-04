// ignore_for_file: prefer_const_constructors_in_immutables, avoid_print, prefer_const_constructors, must_be_immutable, unnecessary_new, prefer_const_literals_to_create_immutables, avoid_function_literals_in_foreach_calls, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/post.dart';

class CommentWidget extends StatefulWidget {
  Post? post;
  int? index;

  CommentWidget({
    required this.post,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    Color? themeColor = Theme.of(context).primaryColor;
    Color? secondaryColor = Theme.of(context).primaryColorLight;
    Map<String, dynamic> postJson = widget.post!.toJson();
    String? userID = FirebaseAuth.instance.currentUser?.uid;
    // CollectionReference comments = FirebaseFirestore.instance.collection('comments');

    _likeComment() {
      // postJson['comments'][widget.index]['likes'].add(userID);
      // FirebaseFirestore.instance
      //     .collection('comments')
      //     .get()
      //     .then((QuerySnapshot querySnapshot) {
      //   querySnapshot.docs.forEach((doc) {
      //     if (doc['commentID'] == 'w') {
      //       comments.doc(postJson['postID']).update({
      //         'commentContent': doc['commentContent'],
      //         'commentID': doc['commentID'],
      //         'commentedAt': postJson['commentedAt'],
      //         'likes': doc['likes'],
      //         'pictureID': doc['pictureID'],
      //         'postID': doc['postID'],
      //         'username': doc['username'],
      //       });
      //     }
      //   });
      // });
    }

    _dislikeComment() {
      // postJson['comments'][widget.index]['likes'].removeWhere((element) => element == userID);
      // FirebaseFirestore.instance
      //     .collection('comments')
      //     .get()
      //     .then((QuerySnapshot querySnapshot) {
      //   querySnapshot.docs.forEach((doc) {
      //     if (doc['commentID'] == 'w') {
      //       comments.doc(postJson['postID']).update({
      //         'commentContent': doc['commentContent'],
      //         'commentID': doc['commentID'],
      //         'commentedAt': postJson['commentedAt'],
      //         'likes': doc['likes'],
      //         'pictureID': doc['pictureID'],
      //         'postID': doc['postID'],
      //         'username': doc['username'],
      //       });
      //     }
      //   });
      // });
    }
    if (widget.index! < 0) {
      widget.index = 0; 
    }
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(3),
          child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(postJson['comments'][widget.index]['pictureID'])),
        ),
        Row(
          children: [
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                      child: Container(
                          width: MediaQuery.of(context).size.width / 1.35,
                          child: RichText(
                            text: TextSpan(
                              style: new TextStyle(
                                color: Colors.black,
                                fontFamily: 'Montserrat',
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: postJson['comments'][widget.index]['username'] + " ",
                                    style: TextStyle(fontWeight: FontWeight.bold, color: secondaryColor)),
                                TextSpan(
                                    text: postJson['comments'][widget.index]['commentContent'],
                                    style: TextStyle(color: secondaryColor)),
                              ],
                            ),
                          )))
                ],
              ),
              Container(
                  width: MediaQuery.of(context).size.width / 1.35,
                  child: Row(
                    children: [
                      Text(
                        postJson['comments'][widget.index]['commentedAt']
                            .toString(),
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${postJson['comments'][widget.index]['likes'].length} likes',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ))
            ]),
            postJson['comments'][widget.index]['likes'].contains(userID)
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _dislikeComment();
                      });
                    },
                    icon: Icon(Icons.thumb_up_alt, color: secondaryColor,),
                  )
                : IconButton(
                    onPressed: () {
                      setState(() {
                        _likeComment();
                      });
                    },
                    icon: Icon(Icons.thumb_up_alt_outlined, color: secondaryColor,),
                  )
          ],
        )
      ],
    );
  }
}
