// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:igc2/models/comment.dart';

import '../../models/post.dart';
import '../../models/user.dart';

part 'comment_page_event.dart';
part 'comment_page_state.dart';

class CommentPageBloc extends Bloc<CommentPageEvent, CommentPageState> {
  CommentPageBloc() : super(CommentPageLoadingState()) {
    on<LoadCommentsRequest>(_loadComments);
    on<PostCommentRequest>(_postComment);
  }

  void _loadComments(
      LoadCommentsRequest event, Emitter<CommentPageState> emit) async {
    emit(CommentPageLoadingState());
    try {
      emit(CommentPageLoadedState(
          post: event.post, searchedUser: event.searchedUser));
    } catch (_) {
      emit(CommentPageFailedState());
    }
  }

  void _postComment(PostCommentRequest event, Emitter<CommentPageState> emit) async {
    CollectionReference postsCollection = FirebaseFirestore.instance.collection('posts');
    emit(CommentPagePostingState());
    try {
      event.post.comments!.add(event.newComment);
      String postID = event.post.postID.toString();
      postsCollection
          .where("postID", isEqualTo: postID)
          .get()
          .then((value) {
        value.docs.forEach((result) {
          postsCollection
              .doc(postID)
              .update({'comments': event.post.comments});
        });
      });
      emit(CommentPageLoadedState(post: event.post, searchedUser: event.searchedUser));
    } catch (_) {
      emit(CommentPageFailedState());
    }
  }
}
