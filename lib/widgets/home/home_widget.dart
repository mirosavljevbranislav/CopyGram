// ignore_for_file: use_key_in_widget_constructors, avoid_print, prefer_const_constructors, must_be_immutable
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:igc2/screens/home/home_screen.dart';
import 'package:igc2/screens/home/settings_screen.dart';
import 'package:igc2/screens/profile/profile_screen.dart';
import 'package:igc2/screens/search/search_screen.dart';
import 'package:igc2/widgets/profile/post/single_post_widget.dart';

import '../../models/post.dart';
import '../../screens/profile/new_post_screen.dart';

class HomeWidget extends StatefulWidget {
  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String? userEmail = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    Color? themeColor = Theme.of(context).primaryColor;
    Color? secondaryColor = Theme.of(context).primaryColorLight;
    return Scaffold(
      backgroundColor: themeColor,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> streamsnapshot) {
          if (streamsnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamsnapshot.data?.docs;
          return ListView.builder(
            itemCount: documents?.length,
            itemBuilder: (ctx, index) => Container(
                padding: EdgeInsets.all(10),
                child: SinglePostWidget(
                  post: Post(
                      profilePictureID: documents![index]['profilePictureID'],
                      username: documents[index]['username'],
                      userID: documents[index]['userID'],
                      postID: documents[index]['postID'],
                      picture: documents[index]['picture'],
                      location: documents[index]['location'],
                      description: documents[index]['description'],
                      likes: documents[index]['likes'],
                      comments: documents[index]['comments'],
                      pictureTakenAt: documents[index]['pictureTakenAt']),
                )),
          );
        },
      ),
      appBar: AppBar(
        title: Text(
          'CopyGram',
          style: TextStyle(fontFamily: 'DancingScript', fontSize: 34),
        ),
        backgroundColor: themeColor,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.chat_outlined),
          ),
        ],
      ),
      floatingActionButton: RawMaterialButton(
        onPressed: () {
          Navigator.pushNamed(context, NewPostScreen.routeName);
        },
        elevation: 2.0,
        fillColor: Colors.white,
        child: Icon(
          Icons.add,
          size: 35.0,
        ),
        padding: EdgeInsets.all(15.0),
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: themeColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                if (ModalRoute.of(context)?.settings.name !=
                    HomeScreen.routeName) {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                }
              },
              icon: Icon(Icons.home),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {
                if (ModalRoute.of(context)?.settings.name !=
                    SearchScreen.routeName) {
                  Navigator.pushNamed(context, SearchScreen.routeName);
                }
              },
              icon: Icon(Icons.search),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {
                if (ModalRoute.of(context)?.settings.name !=
                    SettingsScreen.routeName) {
                  Navigator.pushNamed(context, SettingsScreen.routeName);
                }
              },
              icon: Icon(Icons.settings),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {
                if (ModalRoute.of(context)?.settings.name !=
                    ProfileScreen.routeName) {
                  Navigator.pushNamed(context, ProfileScreen.routeName);
                }
              },
              icon: Icon(Icons.person),
              color: Colors.white,
            ),
          ],
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
    );
  }
}
