// ignore_for_file: use_key_in_widget_constructors, avoid_print, prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:igc2/screens/profile_screen.dart';
import 'package:igc2/screens/search_screen.dart';

class HomeWidget extends StatefulWidget {
  @override
  State<HomeWidget> createState() => _HomeWidgetState();

  String? currentUserFullname;
  String? currentUserUsername;
}

class _HomeWidgetState extends State<HomeWidget> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? userEmail = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
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
              child: userEmail == documents?[index]['email']
                  ? Column(children: [
                      Text(documents?[index]['email']),
                      Text(documents?[index]['fullname']),
                      Text(documents?[index]['username']),
                    ])
                  : null,
            ),
          );
        },
      ),
      appBar: AppBar(
        title: Text('CopyGram'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.chat_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).backgroundColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.home),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SearchScreen.routeName);
              },
              icon: Icon(Icons.search),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, ProfileScreen.routeName);
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
