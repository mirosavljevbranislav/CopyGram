// ignore_for_file: prefer_const_constructors_in_immutables, avoid_function_literals_in_foreach_calls

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as path;

class AddStoryWidget extends StatefulWidget {
  static const routeName = '/addstory';
  Map<String, dynamic>? user;
  AddStoryWidget({
    this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<AddStoryWidget> createState() => _AddStoryWidgetState();
}

class _AddStoryWidgetState extends State<AddStoryWidget> {
  File? _imageFile;
  final picker = ImagePicker();

  _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  Future _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as AddStoryWidget;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    _addStory(File imageID) async {
      String fileName = path.basename(imageID.path);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(imageID);
      TaskSnapshot taskSnapshot = await uploadTask;
      taskSnapshot.ref.getDownloadURL().then(
            (value) => setState(() {
              fileName = value;
              args.user!['stories'].add(fileName);
            }),
          );
      FirebaseFirestore.instance
          .collection('posts')
          .where('userID', isEqualTo: args.user!['userID'])
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          users.doc(args.user!['userID']).update({
            'stories': args.user!['stories'],
          });
        });
      });
    }

    return Material(
      child: Container(
        padding: const EdgeInsets.only(top: 50),
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  _getImage();
                },
                child: const Text('Gallery')),
            TextButton(
                onPressed: () {
                  _pickImage();
                },
                child: const Text('Camera')),
            SizedBox(
              child: _imageFile == null
                  ? Center(
                      child: Text(
                        'Press on camera button to take picture',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight),
                      ),
                    )
                  : Image.file(
                      _imageFile!,
                      fit: BoxFit.cover,
                    ),
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width,
            ),
            const Spacer(),
            Container(
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).primaryColorLight,
                child: TextButton(
                  onPressed: () {
                    _addStory(_imageFile!);
                  },
                  child: const Text('Post story!'),
                )),
          ],
        ),
      ),
    );
  }
}
