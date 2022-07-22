// ignore_for_file: must_be_immutable, prefer_const_constructors, avoid_print, non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'dart:io';

import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:igc2/models/post.dart';
import 'package:location/location.dart' as loc;
import 'package:path/path.dart' as path;
import 'package:geolocator/geolocator.dart' as geo_loc;
import 'package:geocoding/geocoding.dart' as geo_cod;
import 'package:intl/intl.dart';

import '../home/home_widget.dart';

class NewPostEdit extends StatefulWidget {
  static const routeName = '/newpostedit';
  File? imageFile;
  String? address = '';
  late String description;

  final _captionController = TextEditingController();

  NewPostEdit({Key? key, this.imageFile}) : super(key: key);

  @override
  State<NewPostEdit> createState() => _NewPostEditState();
}

class _NewPostEditState extends State<NewPostEdit> {
  String? userID = FirebaseAuth.instance.currentUser?.uid;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> updateUser() {
    return users
        .doc(userID)
        .update({'posts': FieldValue.increment(1)})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  void _addPostURL(String PID) {
    users.doc(userID).update({
      "postURL": FieldValue.arrayUnion([PID])
    }).then((_) {
      print("success!");
    });
  }

  _addNewPost(String desc, String location, File imageID) async {
    String fileName = path.basename(imageID.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageID);
    TaskSnapshot taskSnapshot = await uploadTask;
    var postUuid = Uuid().v4();
    String formatedDate = DateFormat('MMMM d,yyyy').format(DateTime.now());
    FirebaseFirestore.instance
        .collection("users")
        .where("userID", isEqualTo: userID)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        taskSnapshot.ref.getDownloadURL().then(
              (value) => setState(() {
                fileName = value;
                Post newPost = Post(
                    profilePictureID: result.data()['pictureID'],
                    username: result.data()['username'],
                    userID: userID,
                    postID: postUuid,
                    picture: fileName,
                    location: location,
                    description: desc,
                    likes: [],
                    comments: [],
                    pictureTakenAt: formatedDate);
                final CollectionReference collection =
                    FirebaseFirestore.instance.collection("posts");
                collection.doc(postUuid).set(newPost.toJson());
                _addPostURL(fileName);
              }),
            );
      });
    });
    updateUser();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text('Posted successfully!'),
              actions: [
                TextButton(
                  onPressed: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HomeTest();
                    }))
                  },
                  child: Text('Ok'),
                )
              ],
            ));
  }

  Future<geo_loc.Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    geo_loc.LocationPermission permission;
    serviceEnabled = await geo_loc.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await geo_loc.Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await geo_loc.Geolocator.checkPermission();
    if (permission == geo_loc.LocationPermission.denied) {
      permission = await geo_loc.Geolocator.requestPermission();
      if (permission == geo_loc.LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == geo_loc.LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await geo_loc.Geolocator.getCurrentPosition(
        desiredAccuracy: geo_loc.LocationAccuracy.high);
  }

  Future<void> getAddressFromLatLong(geo_loc.Position position) async {
    List<geo_cod.Placemark> placemarks = await geo_cod.placemarkFromCoordinates(
        position.latitude, position.longitude);
    geo_cod.Placemark place = placemarks[0];
    setState(() {
      // widget.address = '${place.street} ${place.subLocality} ${place.locality} ${place.postalCode} ${place.country}';
      widget.address = '${place.street} ${place.country}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              setState(() {
                widget.description = widget._captionController.text;
              });
              _addNewPost(widget.description, widget.address.toString(),
                  widget.imageFile!);
            },
          )
        ],
      ),
      body: Column(children: [
        Row(
          children: [
            Flexible(
              child: TextField(
                controller: widget._captionController,
                decoration: InputDecoration(labelText: 'Enter capotion...'),
              ),
            ),
            Image.file(
              widget.imageFile!,
              fit: BoxFit.cover,
              width: 50,
              height: 50,
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          height: 5,
          color: Colors.grey,
        ),
        TextButton(
          onPressed: () {
            loc.Location();
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Tag people'),
          ),
        ),
        Divider(
          height: 5,
          color: Colors.grey,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          TextButton(
              onPressed: () {
                loc.Location();
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Add location'),
              )),
          TextButton(
              onPressed: () async {
                geo_loc.Position position = await _getGeoLocationPosition();
                setState(() {
                  getAddressFromLatLong(position);
                });
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Text('Current location'),
              ))
        ]),
        Divider(
          height: 5,
          color: Colors.grey,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Current address'),
            Text(widget.address.toString()),
          ],
        ),
      ]),
    );
  }
}
