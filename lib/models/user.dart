import 'package:flutter/material.dart';
import './post.dart';

class User {
  String? email;
  String? fullname;
  String? username;
  String? password;
  String? referenceId;
  List<Post>? posts;
  List<User>? followers;
  List<User>? following;
  String? pictureID;

  User({
    @required this.email,
    @required this.fullname,
    @required this.username,
    @required this.password,
    @required this.posts,
    @required this.followers,
    @required this.following,
    @required this.pictureID,
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
        'pictureID': instance.pictureID,
      };
}
