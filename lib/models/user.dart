import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class User extends Equatable {
  final String? email;
  final String? fullname;
  final String? username;
  final String? password;
  final int? posts;
  final List? followers;
  final List? following;
  final List? postURL;
  final List? stories;
  final List? viewedStories;
  final String? pictureID;
  final String? userID;
  final String? description;

  const User({
    @required this.email,
    @required this.fullname,
    @required this.username,
    @required this.password,
    @required this.posts,
    @required this.followers,
    @required this.following,
    @required this.postURL,
    @required this.stories,
    @required this.viewedStories,
    @required this.pictureID,
    @required this.userID,
    @required this.description,
  });

  static const empty = User(
      email: '',
      fullname: '',
      username: '',
      password: '',
      posts: 0,
      followers: [],
      following: [],
      postURL: [],
      stories: [],
      viewedStories: [],
      pictureID: '',
      userID: '',
      description: '');

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  Map<String, dynamic> toJson() => _userToJson(this);

  Map<String, dynamic> _userToJson(User instance) => <String, dynamic>{
        'email': instance.email,
        'fullname': instance.fullname,
        'username': instance.username,
        'password': instance.password,
        'posts': instance.posts,
        'followers': instance.followers,
        'following': instance.following,
        'postURL': instance.postURL,
        'stories': instance.stories,
        'viewedStories': instance.viewedStories,
        'pictureID': instance.pictureID,
        'userID': instance.userID,
        'description': instance.description,
      };

  @override
  List<Object?> get props => [
        email,
        fullname,
        username,
        password,
        posts,
        followers,
        following,
        postURL,
        stories,
        viewedStories,
        pictureID,
        userID,
        description,
      ];
}

class SearchedUser {
  final String? email;
  final String? fullname;
  final String? username;
  final int? posts;
  final List? followers;
  final List? following;
  final List? postURL;
  final List? stories;
  final List? viewedStories;
  final String? pictureID;
  final String? userID;
  final String? description;
  const SearchedUser({
    @required this.email,
    @required this.fullname,
    @required this.username,
    @required this.posts,
    @required this.followers,
    @required this.following,
    @required this.postURL,
    @required this.stories,
    @required this.viewedStories,
    @required this.pictureID,
    @required this.userID,
    @required this.description,
  });

  static const empty = SearchedUser(
      email: '',
      fullname: '',
      username: '',
      posts: 0,
      followers: [],
      following: [],
      postURL: [],
      stories: [],
      viewedStories: [],
      pictureID: '',
      userID: '',
      description: '');

  Map<String, dynamic> toJson() => _userToJson(this);

  Map<String, dynamic> _userToJson(SearchedUser instance) => <String, dynamic>{
        'email': instance.email,
        'fullname': instance.fullname,
        'username': instance.username,
        'posts': instance.posts,
        'followers': instance.followers,
        'following': instance.following,
        'postURL': instance.postURL,
        'stories': instance.stories,
        'viewedStories': instance.viewedStories,
        'pictureID': instance.pictureID,
        'userID': instance.userID,
        'description': instance.description,
      };
}
