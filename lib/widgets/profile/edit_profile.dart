// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:igc2/models/user.dart';

class EditProfile extends StatefulWidget {
  final SearchedUser? user;

  const EditProfile({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    Color? themeColor = Theme.of(context).primaryColor;
    Color? secondaryColor = Theme.of(context).primaryColorLight;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        actions: [Icon(Icons.check, color: secondaryColor,)],
        title: Text('Edit profile'),
      ),
      body: Container(
        color: themeColor,
        padding: EdgeInsets.only(left: 5, right: 5),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              child: Text('photo', style: TextStyle(color: secondaryColor)),
            ),
            Container(
              child: Text('Change profile photo',
                  style: TextStyle(color: secondaryColor)),
            ),
            Text('Name', style: TextStyle(color: secondaryColor)),
            TextFormField(
              
              style: TextStyle(color: secondaryColor),
              decoration: InputDecoration(
                labelStyle: TextStyle(color: secondaryColor),
                labelText: widget.user!.fullname,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: secondaryColor))),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Username', style: TextStyle(color: secondaryColor)),
            TextFormField(
              style: TextStyle(color: secondaryColor),
              decoration: InputDecoration(
                labelStyle: TextStyle(color: secondaryColor),
                labelText: widget.user!.username,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: secondaryColor))),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Bio', style: TextStyle(color: secondaryColor)),
            TextFormField(
              style: TextStyle(color: secondaryColor),
              decoration: InputDecoration(
                labelStyle: TextStyle(color: secondaryColor),
                labelText: widget.user!.description,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: secondaryColor))),
            ),
          ],
        ),
      ),
    );
  }
}
