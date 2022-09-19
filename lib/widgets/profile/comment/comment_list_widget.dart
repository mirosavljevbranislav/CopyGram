// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
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
    Color? themeColor = Theme.of(context).primaryColor;
    Color? secondaryColor = Theme.of(context).primaryColorLight;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        backgroundColor: themeColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: themeColor,
          child: Column(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.21,
              child: ScrollablePositionedList.builder(
                  itemScrollController: itemController,
                  itemCount: widget.post!.comments!.length,
                  itemBuilder: (context, index) => CommentWidget(
                        post: widget.post,
                        index: index,
                      )),
            ),
            TextFormField(
              style: (TextStyle(color: secondaryColor)),
              decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(color: secondaryColor),
                  labelText: 'Add new comment',
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: secondaryColor)),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      print("U hit send!");
                    },
                  )),
              // scrollPadding: EdgeInsets.only(
              //     bottom: MediaQuery.of(context).viewInsets.bottom + 100),
              controller: null,
            ),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom + 200,
            ),
          ]),
        ),
      ),
    );
  }
}
