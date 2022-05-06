import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:igc2/screens/profile/following_followers_screen.dart';
import 'package:igc2/screens/home_screen.dart';
import 'package:igc2/screens/auth/login_screen.dart';
import 'package:igc2/screens/profile/new_post_screen.dart';
import 'package:igc2/screens/profile/post_screen.dart';
import 'package:igc2/screens/profile/profile_screen.dart';
import 'package:igc2/screens/auth/registration_screen.dart';
import 'package:igc2/screens/search/search_screen.dart';
import 'package:igc2/screens/searched_user_screen.dart';
import 'package:igc2/widgets/new_post/new_post_edit.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const LoginScreen(),
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegistrationScreen.routeName: (context) => const RegistrationScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
        FollowingFollowersScreen.routeName: (context) => const FollowingFollowersScreen(),
        SearchScreen.routeName: (context) => const SearchScreen(),
        SearchedUserScreen.routeName: ((context) => const SearchedUserScreen()),
        NewPostScreen.routeName: (context) => const NewPostScreen(),
        NewPostEdit.routeName:(context) =>  NewPostEdit(),
        PostScreen.routeName:(context) => PostScreen(),
      },
    );
  }
}
