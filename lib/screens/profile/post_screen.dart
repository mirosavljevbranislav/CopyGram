// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:igc2/widgets/profile/post/post_list_widget.dart';

class PostScreen extends StatefulWidget {
  static const routeName = '/post';
  PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ProfilePostListWidget;
    return ProfilePostListWidget(
      listLength: args.listLength,
      indexToScroll: args.indexToScroll,
      searchedUser: args.searchedUser,
    );
  }
}
