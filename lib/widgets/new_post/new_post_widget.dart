// ignore_for_file: prefer_const_constructors_in_immutables, avoid_print, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:igc2/widgets/new_post/new_post_edit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

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
    var result = await PhotoManager.requestPermissionExtend();
    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList();
    // final assetList = await path.getAssetListRange(0, 2);

    if (result.isAuth) {
      print('EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE ${paths[1].assetCount}');
      for (int i=0; i< paths.length; i++){
        if (paths[i].name == 'Download'){
          print(paths[i].getAssetListPaged(page: 1, size: 2));
        }
      }
    }else {

    }
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
              Navigator.pushNamed(context, NewPostEdit.routeName, arguments: NewPostEdit(imageFile: _imageFile,));
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
                : FittedBox(
                    child: Image.file(
                      _imageFile!,
                      fit: BoxFit.cover,
                    ),
                  ),
            height: MediaQuery.of(context).size.height / 2.5,
          ),
          Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            width: double.infinity,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      _getImages();
                    },
                    child: Text('Gallery'),
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                      
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      pickImage();
                    },
                    icon: Icon(Icons.camera_alt),
                  ),
                ]),
          ),
        ]),
      ),
    );
  }
}
