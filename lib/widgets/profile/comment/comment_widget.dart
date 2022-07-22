// ignore_for_file: prefer_const_constructors_in_immutables, avoid_print, prefer_const_constructors, must_be_immutable, unnecessary_new, prefer_const_literals_to_create_immutables, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/comment.dart';
import '../../../models/post.dart';

class CommentWidget extends StatefulWidget {
  Post? post;
  CommentModel? comment;

  CommentWidget({
    required this.post,
    required this.comment,
    Key? key,
  }) : super(key: key);

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic> userJson = widget.user!.toJson();
    Map<String, dynamic> postJson = widget.post!.toJson();
    Map<String, dynamic> commentJson = widget.comment!.toJson();
    String? userID = FirebaseAuth.instance.currentUser?.uid;
    CollectionReference comments =
        FirebaseFirestore.instance.collection('comments');
    _likeComment() {
      commentJson['likes'].add(userID);

      FirebaseFirestore.instance
          .collection('comments')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (doc['commentID'] == 'w') {
            comments.doc(postJson['postID']).update({
              'commentContent': doc['commentContent'],
              'commentID': doc['commentID'],
              'commentedAt': postJson['commentedAt'],
              'likes': doc['likes'],
              'pictureID': doc['pictureID'],
              'postID': doc['postID'],
              'username': doc['username'],
            });
          }
        });
      });
    }

    _dislikeComment() {
      commentJson['likes'].removeWhere((element) => element == userID);
      FirebaseFirestore.instance
          .collection('comments')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (doc['commentID'] == 'w') {
            comments.doc(postJson['postID']).update({
              'commentContent': doc['commentContent'],
              'commentID': doc['commentID'],
              'commentedAt': postJson['commentedAt'],
              'likes': doc['likes'],
              'pictureID': doc['pictureID'],
              'postID': doc['postID'],
              'username': doc['username'],
            });
          }
        });
      });
    }

    print(postJson);
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(3),
          child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(commentJson['pictureID'].toString())),
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
                                    text: commentJson['username'] + " ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: commentJson['commentContet']),
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
                        commentJson['commentedAt'].toString(),
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${commentJson['likes'].length} likes',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ))
            ]),
            commentJson['likes'].contains(userID)
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _dislikeComment();
                      });
                    },
                    icon: Icon(Icons.thumb_up_alt),
                  )
                : IconButton(
                    onPressed: () {
                      setState(() {
                        _likeComment();
                      });
                    },
                    icon: Icon(Icons.thumb_up_alt_outlined),
                  )
          ],
        )
      ],
    );
  }
}
