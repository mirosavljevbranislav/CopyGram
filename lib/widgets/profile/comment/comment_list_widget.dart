// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igc2/models/comment.dart';
import 'package:igc2/widgets/profile/comment/comment_widget.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:intl/intl.dart';
import '../../../blocs/comment_page/comment_page_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../models/post.dart';
import '../../../models/user.dart';

class CommentListWidget extends StatefulWidget {
  Post? post;
  SearchedUser? user;
  CommentListWidget({
    this.post,
    this.user,
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
    TextEditingController commentController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        backgroundColor: themeColor,
      ),
      body: BlocBuilder<CommentPageBloc, CommentPageState>(
        builder: ((context, state) {
          if (state is CommentPageLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CommentPageLoadedState) {
            return SingleChildScrollView(
              child: Container(
                color: themeColor,
                child: Column(children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.21,
                    child: ScrollablePositionedList.builder(
                        itemScrollController: itemController,
                        itemCount: state.post.comments!.length,
                        itemBuilder: (context, index) => CommentWidget(
                              post: state.post,
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
                          icon: Icon(
                            Icons.send,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            var uuid = Uuid();
                            DateTime dateTime = DateTime.now();
                            String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
                            CommentModel newComment = CommentModel(
                                username: state.searchedUser.username,
                                commentID: uuid.v4().toString(),
                                postID: state.post.postID,
                                likes: [],
                                pictureID: state.searchedUser.pictureID,
                                commentedAt: formattedDate,
                                commentContent: commentController.text);
                            context.read<CommentPageBloc>().add(
                                PostCommentRequest(
                                    post: state.post,
                                    searchedUser: state.searchedUser,
                                    newComment: newComment.toJson()));
                          },
                        )),
                    controller: commentController,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom + 200,
                  ),
                ]),
              ),
            );
          }
          return Center(
            child: Text('Oops, somethign went wrong...'),
          );
        }),
      ),
    );
  }
}
