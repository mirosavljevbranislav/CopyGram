// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../models/post.dart';
import '../../models/user.dart';

part 'comment_page_event.dart';
part 'comment_page_state.dart';

class CommentPageBloc extends Bloc<CommentPageEvent, CommentPageState> {
  CommentPageBloc() : super(CommentPageLoadingState()) {
    on<LoadCommentsRequest>(_loadComments);
    on<PostCommentRequest>(_postComment);
  }

  void _loadComments(LoadCommentsRequest event, Emitter<CommentPageState> emit) async {
    CollectionReference commentCollection = FirebaseFirestore.instance.collection('comments');
    List comments = [];
    emit(CommentPageLoadingState());
    try {
      await commentCollection
          .where('postID', isEqualTo: event.post.postID)
          .get()
          .then(((value) {
        value.docs.forEach((element) {
          if (element.data() != null) {
            comments.add(element.data());
          }
        });
      }));
      emit(CommentPageLoadedState(
          post: event.post ,comments: comments, searchedUser: event.searchedUser));
    } catch (_) {
      emit(CommentPageFailedState());
    }
  }

  void _postComment(PostCommentRequest event, Emitter<CommentPageState> emit) async {
    CollectionReference commentCollection = FirebaseFirestore.instance.collection('comments');
    List comments = [];
    emit(CommentPagePostingState());
    try {
      // commentCollection.add(event.newComment);
      commentCollection.doc(event.newComment!['commentID']).set(event.newComment);
      await commentCollection
          .where('postID', isEqualTo: event.post.postID)
          .get()
          .then(((value) {
        value.docs.forEach((element) {
          if (element.data() != null) {
            comments.add(element.data());
          }
        });
      }));
      emit(CommentPageLoadedState(
          post: event.post, comments: comments, searchedUser: event.searchedUser));
    } catch (_) {
      emit(CommentPageFailedState());
    }
  }
}
