// ignore_for_file: prefer_const_constructors, avoid_print, unused_local_variable, unnecessary_null_comparison, unused_field

import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:igc2/repository/data_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import '../../models/user.dart' as user_model;
import 'package:crypto/crypto.dart';

class RegistrationWidget extends StatefulWidget {
  const RegistrationWidget({Key? key}) : super(key: key);

  @override
  State<RegistrationWidget> createState() => _RegistrationWidgetState();
}

class _RegistrationWidgetState extends State<RegistrationWidget> {
  File? _imageFile;
  final picker = ImagePicker();

  bool _passwordIsObscure = true;
  bool _confimartionIsObscure = true;

  // User fields

  String? _email;
  String? _username;
  String? _fullname;
  String? _password;

  final _auth = FirebaseAuth.instance;

  // Controllers

  final emailController = TextEditingController();
  final fullnameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  final DataRepository repository = DataRepository();

  String _hashPassword(String? password) {
    var bytes1 = utf8.encode(password!);
    var digest1 = sha256.convert(bytes1);
    return digest1.toString();
  }

  void _registerUser(
      String email, String password, BuildContext context) async {
    UserCredential authResult;
    try {
      String fileName = path.basename(_imageFile!.path);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile!);
      TaskSnapshot taskSnapshot = await uploadTask;
      taskSnapshot.ref.getDownloadURL().then(
            (value) => setState(() {
              fileName = value;
            }),
          );

      authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String? _hashedPassword = _hashPassword(password);
      final newUser = user_model.User(
        email: _email,
        fullname: _fullname,
        username: _username,
        password: _hashedPassword,
        posts: 0,
        followers: [],
        following: [],
        pictureID: fileName,
        userid: authResult.user?.uid.toString(),
      );

      repository.addUser(newUser, authResult.user?.uid.toString());
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Successfull sign up!'),
                content: Text('Welcome to CopyGram!'),
                actions: [
                  TextButton(
                    onPressed: () => {Navigator.pop(context)},
                    child: Text('Ok'),
                  )
                ],
              ));
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Email already in use'),
                    content: Text('Please choose another one.'),
                    actions: [
                      TextButton(
                        onPressed: () => {Navigator.pop(context)},
                        child: Text('Ok'),
                      )
                    ],
                  ));
          break;
        case "invalid-email":
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Email invalid'),
                    content: Text('Please choose another one.'),
                    actions: [
                      TextButton(
                        onPressed: () => {Navigator.pop(context)},
                        child: Text('Ok'),
                      )
                    ],
                  ));
          break;
        case "weak-passoword":
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Weak password'),
                    content: Text('Please choose another one.'),
                    actions: [
                      TextButton(
                        onPressed: () => {Navigator.pop(context)},
                        child: Text('Ok'),
                      )
                    ],
                  ));
          break;
      }
    }
  }

  Future pickImage() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.camera, maxWidth: 120, maxHeight: 120);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {}

  void _clearFields() {
    usernameController.clear();
    passwordController.clear();
    passwordConfirmationController.clear();
    emailController.clear();
    fullnameController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void _getFieldText() {
    // Set fields to text from textfields
    _email = emailController.text;
    _username = usernameController.text;
    _fullname = fullnameController.text;
    _password = passwordController.text;
  }

  void _passwordMissMatch() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Password missmatch!'),
              content: Text(
                  'Please try again typing your password and confirmation.'),
              actions: [
                TextButton(
                  onPressed: () => {Navigator.pop(context)},
                  child: Text('Ok'),
                )
              ],
            ));
    passwordController.clear();
    passwordConfirmationController.clear();
  }

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
        child: Container(
          decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
          padding: const EdgeInsets.only(top: 50),
          alignment: Alignment.topLeft,
          width: 150,
          height: 100,
          child: Column(children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 10),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back'),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).focusColor,
                  elevation: 0,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Material(
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Material(
                child: TextFormField(
                  controller: fullnameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full name',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Material(
                child: TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Material(
                child: TextFormField(
                  obscureText: _passwordIsObscure,
                  controller: passwordController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordIsObscure = !_passwordIsObscure;
                            });
                          },
                          icon: Icon(_passwordIsObscure
                              ? Icons.visibility
                              : Icons.visibility_off))),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Material(
                child: TextFormField(
                  obscureText: _confimartionIsObscure,
                  controller: passwordConfirmationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm password',
                    prefixIcon: Icon(Icons.password),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _confimartionIsObscure = !_confimartionIsObscure;
                        });
                      },
                      icon: Icon(_confimartionIsObscure
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: _imageFile == null
                  ? ElevatedButton(
                      onPressed: pickImage,
                      child: Icon(Icons.camera),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: const CircleBorder(),
                        fixedSize: const Size(80, 80),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        _imageFile!,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              height: 50,
              child: Material(
                child: ElevatedButton(
                  child: const Text('Sign up'),
                  onPressed: () {
                    if (passwordController.text ==
                        passwordConfirmationController.text) {
                      _getFieldText();
                      _registerUser(emailController.text,
                          passwordController.text, context);

                      FocusManager.instance.primaryFocus?.unfocus();
                      _clearFields();
                    } else if (passwordController.text !=
                        passwordConfirmationController.text) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      _passwordMissMatch();
                    }
                  },
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
