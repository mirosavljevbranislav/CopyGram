// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, must_be_immutable, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:igc2/models/post.dart';
import 'package:igc2/widgets/profile/comment/comment_list_widget.dart';
import 'package:igc2/widgets/profile/comment/comment_widget.dart';

import 'HeartAnimationWidget.dart';

class SinglePostWidget extends StatefulWidget {
  Post? post;

  SinglePostWidget({
    required this.post,
    Key? key,
  }) : super(key: key);

  @override
  State<SinglePostWidget> createState() => _SinglePostWidgetState();
}

class _SinglePostWidgetState extends State<SinglePostWidget> {
  bool isHeartAnimating = false;
  @override
  Widget build(BuildContext context) {
    Color? themeColor = Theme.of(context).primaryColor;
    Color? secondaryColor = Theme.of(context).primaryColorLight;
    Map<String, dynamic> postJson = widget.post!.toJson();
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
              'likes': postJson['likes'],
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
              'likes': postJson['likes'],
            });
          }
        });
      });
    }

    return Container(
      padding: EdgeInsets.only(bottom: 5),
      color: themeColor,
      child: Column(children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5, left: 5),
              child: CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      NetworkImage(postJson['profilePictureID'].toString())),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  postJson['username'],
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: secondaryColor),
                ),
                Text(
                  postJson['location'],
                  style: TextStyle(color: secondaryColor),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          child: InkWell(
            child: Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(postJson['picture'].toString())),
                Opacity(
                  opacity: isHeartAnimating ? 1 : 0,
                  child: HeartAnimationWidget(
                    isAnimating: isHeartAnimating,
                    child: Icon(
                      Icons.favorite,
                      color: secondaryColor,
                      size: 100,
                    ),
                    onEnd: () => setState(() => isHeartAnimating = false),
                  ),
                )
              ],
            ),
            onDoubleTap: () {
              setState(() {
                isHeartAnimating = true;
                if (!postJson['likes'].contains(userID)) {
                  _likePicture();
                }
              });
            },
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
              Row(children: [
                postJson['likes'].contains(userID)
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _dislikePicture();
                          });
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: secondaryColor,
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            _likePicture();
                          });
                        },
                        icon: Icon(
                          Icons.favorite_outline,
                          color: secondaryColor,
                        ),
                      ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.comment,
                    color: secondaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.send,
                    color: secondaryColor,
                  ),
                ),
              ]),
              Flexible(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.flag, color: secondaryColor),
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text('${postJson['likes'].length.toString()} likes',
                  style: TextStyle(color: secondaryColor))),
          alignment: Alignment.centerLeft,
        ),
        Row(
          children: [
            Padding(
                padding: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
                child: Text(
                  postJson['username'],
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: secondaryColor),
                )),
            Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Text(postJson['description'],
                    style: TextStyle(color: secondaryColor))),
          ],
        ),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CommentListWidget(
                post: widget.post,
              );
            }));
          },
          // child: ListView.builder(itemBuilder: (ctx, index) => CommentWidget(post: widget.post))
          child: TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CommentListWidget(post: widget.post);
              }));
            },
            child: Text('Comments'),
          ),
        )
      ]),
    );
  }
}
