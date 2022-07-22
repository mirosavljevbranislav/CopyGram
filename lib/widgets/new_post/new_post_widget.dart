// ignore_for_file: prefer_const_constructors_in_immutables, avoid_print, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:igc2/widgets/new_post/new_post_edit.dart';
import 'package:image_picker/image_picker.dart';

class NewPostWidget extends StatefulWidget {
  NewPostWidget({Key? key}) : super(key: key);

  @override
  State<NewPostWidget> createState() => _NewPostWidgetState();
}

class _NewPostWidgetState extends State<NewPostWidget> {
  File? _imageFile;
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  _getImages() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New post'),
        leading: IconButton(
          icon: const Icon(Icons.cancel),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              if (_imageFile != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return NewPostEdit(
                      imageFile: _imageFile,
                    );
                  }),
                );
              } else if (_imageFile == null) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: Text('You did not choose any image.'),
                          actions: [
                            TextButton(
                              onPressed: () => {
                                Navigator.pop(context),
                              },
                              child: Text('back'),
                            )
                          ],
                        ));
              }
            },
            icon: const Icon(Icons.arrow_right_alt),
          ),
        ],
      ),
      body: Material(
        child: Column(children: [
          SizedBox(
            child: _imageFile == null
                ? Center(
                    child: Text('Press on camera button to take picture'),
                  )
                : Image.file(
                    _imageFile!,
                    fit: BoxFit.cover,
                  ),
            height: MediaQuery.of(context).size.height / 2.5,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            width: double.infinity,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextButton(
                      onPressed: () {
                        _getImages();
                      },
                      child: Text('Gallery'),
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                      ),
                    ),
                  ),
                  Flexible(
                    child: IconButton(
                      onPressed: () {
                        pickImage();
                      },
                      icon: Icon(Icons.camera_alt),
                    ),
                  ),
                ]),
          ),
        ]),
      ),
    );
  }
}
