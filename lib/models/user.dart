import 'package:flutter/material.dart';

class User {
  String? email;
  String? fullname;
  String? username;
  String? password;
  int? posts;
  List? followers;
  List? following;
  List? postURL;
  String? pictureID;
  String? userID;

  User({
    @required this.email,
    @required this.fullname,
    @required this.username,
    @required this.password,
    @required this.posts,
    @required this.followers,
    @required this.following,
    @required this.postURL,
    @required this.pictureID,
    @required this.userID,
  });

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
        'pictureID': instance.pictureID,
        'userID': instance.userID,
      };
}

class SearchedUser {
  String? email;
  String? fullname;
  String? username;
  int? posts;
  List? followers;
  List? following;
  List? postURL;
  String? pictureID;
  String? userID;
  SearchedUser({
    @required this.email,
    @required this.fullname,
    @required this.username,
    @required this.posts,
    @required this.followers,
    @required this.following,
    @required this.postURL,
    @required this.pictureID,
    @required this.userID,
  });

  Map<String, dynamic> toJson() => _userToJson(this);

  Map<String, dynamic> _userToJson(SearchedUser instance) => <String, dynamic>{
        'email': instance.email,
        'fullname': instance.fullname,
        'username': instance.username,
        'posts': instance.posts,
        'followers': instance.followers,
        'following': instance.following,
        'postURL': instance.postURL,
        'pictureID': instance.pictureID,
        'userID': instance.userID,
      };
}
