// ignore_for_file: must_be_immutable

part of 'comment_page_bloc.dart';

enum CommentPageStatus { loading, loaded, failed , posting}

abstract class CommentPageState extends Equatable {
  const CommentPageState();

  @override
  List<Object> get props => [];
}

class CommentPageLoadingState extends CommentPageState {}

class CommentPageLoadedState extends CommentPageState {
  Post post;
  SearchedUser searchedUser;

  CommentPageLoadedState({
    required this.post,
    required this.searchedUser,
  });

  @override
  List<Object> get props => [post, searchedUser];
}

class CommentPageFailedState extends CommentPageState {}

class CommentPagePostingState extends CommentPageState {}
