// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, unnecessary_null_comparison
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:igc2/models/user.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  final SearchedUser? user;

  const EditProfile({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _imageFile;
  final picker = ImagePicker();

  Future _getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  _getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  _removePicture() {} // not finished yet

  void _updateUser(String username, String fullname, String description) {
    String newUsername;
    String newFullName;
    String newDescription;
    setState(() {
      username.isEmpty
          ? newUsername = widget.user!.username!
          : newUsername = username;
      fullname.isEmpty
          ? newFullName = widget.user!.fullname!
          : newFullName = fullname;
      description.isEmpty
          ? newDescription = widget.user!.description!
          : newDescription = description;

      FirebaseFirestore.instance
          .collection("users")
          .doc(widget.user!.userID)
          .update({
        "username": newUsername,
        "fullname": newFullName,
        "description": newDescription,
      }).then((_) {
        Navigator.pop(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Color? themeColor = Theme.of(context).primaryColor;
    Color? secondaryColor = Theme.of(context).primaryColorLight;

    TextEditingController nameController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        actions: [
          IconButton(
            onPressed: () {
              _updateUser(usernameController.text, nameController.text,
                  descriptionController.text);
            },
            icon: Icon(Icons.check),
            color: secondaryColor,
          )
        ],
        title: Text('Edit profile'),
      ),
      body: Container(
        color: themeColor,
        padding: EdgeInsets.only(left: 5, right: 5),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: 80,
              width: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  widget.user!.pictureID!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: 200,
              child: TextButton(
                  child: Text('Change profile photo'),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (builder) {
                          return Container(
                            color: themeColor,
                            height: 150,
                            child: Column(children: [
                              TextButton(
                                  onPressed: () {
                                    _getImageFromGallery();
                                  },
                                  child: Text(
                                    'Choose from gallery',
                                    style: TextStyle(color: secondaryColor),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    _getImageFromCamera();
                                  },
                                  child: Text(
                                    'Use camera',
                                    style: TextStyle(color: secondaryColor),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    _removePicture();
                                  },
                                  child: Text(
                                    'Remove photo',
                                    style: TextStyle(color: Colors.red),
                                  )),
                            ]),
                          );
                        });
                  },
                  style: TextButton.styleFrom(
                      textStyle:
                          TextStyle(color: secondaryColor, fontSize: 16))),
            ),
            Container(
              child: Row(
                children: [
                  Text('Name', style: TextStyle(color: secondaryColor))
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),
            TextFormField(
              controller: nameController,
              style: TextStyle(color: secondaryColor),
              decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(color: secondaryColor),
                  labelText: widget.user!.fullname,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: secondaryColor))),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                children: [
                  Text('Username', style: TextStyle(color: secondaryColor))
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),
            TextFormField(
              controller: usernameController,
              textAlignVertical: TextAlignVertical.bottom,
              style: TextStyle(color: secondaryColor),
              decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(color: secondaryColor),
                  labelText: widget.user!.username,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: secondaryColor))),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                children: [
                  Text('Bio', style: TextStyle(color: secondaryColor))
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),
            TextFormField(
              controller: descriptionController,
              style: TextStyle(color: secondaryColor),
              decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(color: secondaryColor),
                  labelText: widget.user!.description ??
                      'Empty. Let people know something about you. ',
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: secondaryColor))),
            ),
          ],
        ),
      ),
    );
  }
}
