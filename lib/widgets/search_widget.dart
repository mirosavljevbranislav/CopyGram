// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:igc2/widgets/search_person.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(top: 65, left: 5, right: 5),
            child: TextField(
              controller: null,
              decoration: InputDecoration(
                  labelText: "Search people",
                  hintText: "Search people",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(left: 5, bottom: 15),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                  final document = snapshot.data!.docs;
                  return Container();
                },
              )
            ),
            itemCount: 5,
          ))
        ])
      ),
    );
  }
}
