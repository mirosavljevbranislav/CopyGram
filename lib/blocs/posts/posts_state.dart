part of 'posts_bloc.dart';

enum PostStatus { initial, loaded, failed }

class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostState {}

class PostsLoaded extends PostState {
  final PostStatus status;
  final List<Map> posts;

  const PostsLoaded({this.status = PostStatus.initial, this.posts = const []});
  const PostsLoaded.loaded(List<Map> posts)
      : this(status: PostStatus.loaded, posts: posts);
  @override
  List<Object> get props => [posts];
}

class PostFailed extends PostState {}
