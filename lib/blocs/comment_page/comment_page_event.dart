// ignore_for_file: must_be_immutable

part of 'comment_page_bloc.dart';

abstract class CommentPageEvent extends Equatable {
  const CommentPageEvent();

  @override
  List<Object> get props => [];
}

class LoadCommentsRequest extends CommentPageEvent {
  final Post post;
  SearchedUser searchedUser;

  LoadCommentsRequest({
    required this.post,
    required this.searchedUser,
  });

  @override
  List<Object> get props => [post, searchedUser];
}

class PostCommentRequest extends CommentPageEvent {
  Post post;
  SearchedUser searchedUser;
  Map<String, dynamic>? newComment;

  PostCommentRequest({
    required this.post,
    required this.searchedUser,
    this.newComment,
  });

  @override
  List<Object> get props => [post, searchedUser, newComment!];

}