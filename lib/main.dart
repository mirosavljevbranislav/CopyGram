import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:igc2/screens/following_followers_screen.dart';
import 'package:igc2/screens/home_screen.dart';
import 'package:igc2/screens/login_screen.dart';
import 'package:igc2/screens/new_post_screen.dart';
import 'package:igc2/screens/profile_screen.dart';
import 'package:igc2/screens/registration_screen.dart';
import 'package:igc2/screens/search_screen.dart';
import 'package:igc2/screens/searched_user_screen.dart';
import 'package:igc2/widgets/new_post/new_post_edit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
      },
    );
  }
}
