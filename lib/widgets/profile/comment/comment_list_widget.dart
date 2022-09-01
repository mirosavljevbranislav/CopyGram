// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:igc2/models/comment.dart';
import 'package:igc2/widgets/profile/comment/comment_widget.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../models/post.dart';

class CommentListWidget extends StatefulWidget {
  Post? post; 
  CommentListWidget({
    this.post,
    Key? key,
  }) : super(key: key);

  @override
  State<CommentListWidget> createState() => _CommentListWidgetState();
}

class _CommentListWidgetState extends State<CommentListWidget> {
  final itemController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollToIndex(2));
  }

  void scrollToIndex(int index) => itemController.jumpTo(index: index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comments')),
      body: SingleChildScrollView(
        child: Column(children: [ 
          StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('comments').snapshots(),
              builder: (ctx, AsyncSnapshot<QuerySnapshot> streamsnapshot) {
                if (streamsnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final documents = streamsnapshot.data?.docs;

                return SizedBox(
                  height: MediaQuery.of(context).size.height / 1.21,
                  child: ScrollablePositionedList.builder(
                    itemScrollController: itemController,
                    itemCount: documents!.length,
                    itemBuilder: (context, index) =>
                        documents[index]['postID'] == 'w'
                            ? CommentWidget(
                                post: widget.post,
                                comment: CommentModel(
                                  username: documents[index]['username'],
                                  commentID: documents[index]['commentID'],
                                  postID: documents[index]['postID'],
                                  likes: documents[index]['likes'],
                                  pictureID: documents[index]['pictureID'],
                                  commentedAt: documents[index]['commentedAt'],
                                  commentContent: documents[index]
                                      ['commentContent'],
                                ),
                              )
                            : Container(),
                  ),
                );
              }),
          TextFormField(
            decoration: InputDecoration(labelText: 'Add new comment'),
            // scrollPadding: EdgeInsets.only(
            //     bottom: MediaQuery.of(context).viewInsets.bottom + 100),
            controller: null,
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom + 200,
          ),
        ]),
      ),
    );
  }
}
