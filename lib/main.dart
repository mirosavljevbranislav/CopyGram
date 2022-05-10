// ignore_for_file: missing_required_param

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:igc2/screens/home/home_screen.dart';
import 'package:igc2/screens/auth/login_screen.dart';
import 'package:igc2/screens/home/settings_screen.dart';
import 'package:igc2/screens/profile/new_post_screen.dart';
import 'package:igc2/screens/profile/post_screen.dart';
import 'package:igc2/screens/profile/profile_screen.dart';
import 'package:igc2/screens/auth/registration_screen.dart';
import 'package:igc2/screens/search/search_screen.dart';
import 'package:igc2/screens/searched_user_screen.dart';
import 'package:igc2/widgets/home/settings.dart';
import 'package:igc2/widgets/new_post/new_post_edit.dart';
import 'package:igc2/widgets/profile/comment/comment_list_widget.dart';
import 'package:igc2/widgets/profile/following_followers_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CopyGram',
      theme: SettingsWidget.light? SettingsWidget.lightTheme : SettingsWidget.darkTheme,
      home: const LoginScreen(),
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegistrationScreen.routeName: (context) => const RegistrationScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
        FollowingFollowersWidget.routeName: (context) => FollowingFollowersWidget(),
        SearchScreen.routeName: (context) => const SearchScreen(),
        SearchedUserScreen.routeName: ((context) => const SearchedUserScreen()),
        NewPostScreen.routeName: (context) => const NewPostScreen(),
        NewPostEdit.routeName: (context) => NewPostEdit(),
        PostScreen.routeName: (context) => PostScreen(),
        CommentListWidget.routeName: ((context) => CommentListWidget()),
        SettingsScreen.routeName: ((context) => SettingsScreen()),
      },
    );
  }
}
