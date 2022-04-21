// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';

class NewPostEdit extends StatefulWidget {
  static const routeName = '/newpostedit';
  File? imageFile;
  NewPostEdit({
    Key? key,
    this.imageFile,
  }) : super(key: key);

  @override
  State<NewPostEdit> createState() => _NewPostEditState();
}

class _NewPostEditState extends State<NewPostEdit> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as NewPostEdit;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {},
          )
        ],

      ),
      body: Column(children: [
        Row(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Enter capotion...'),
            ),
            Image.file(
              args.imageFile!,
              fit: BoxFit.cover,
              width: 50,
              height: 50,
            )
          ],
        ),
        Divider(
          height: 5,
          color: Colors.grey,
        ),
        TextButton(onPressed: () {}, child: Text('Add location')),
        Divider(
          height: 5,
          color: Colors.grey,
        ),
      ]),
    );
  }
}
