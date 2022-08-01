// ignore_for_file: must_be_immutable

part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class LoadingPosts extends PostsEvent {}

class LoadPosts extends PostsEvent {
  List<Map> posts = <Map>[];

  LoadPosts({required this.posts});

  @override
  List<Object> get props => [posts];
}
