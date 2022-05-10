// ignore_for_file: avoid_print, prefer_const_constructors, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:igc2/screens/home/home_screen.dart';
import 'package:igc2/screens/auth/registration_screen.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool _isObscure = true;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void clearFields() {
    usernameController.clear();
    passwordController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void signInUser(String? email, String? password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      Navigator.pushNamed(context, HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: Text('Invalid credentials.'),
                  actions: [
                    TextButton(
                      onPressed: () => {Navigator.pop(context)},
                      child: Text('Ok'),
                    )
                  ],
                ));
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: Text('Invalid credentials.'),
                  actions: [
                    TextButton(
                      onPressed: () => {Navigator.pop(context)},
                      child: Text('Ok'),
                    )
                  ],
                ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Color? themeColor = Theme.of(context).primaryColor;
    Color? secondaryColor = Theme.of(context).primaryColorLight;
    return Material(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          decoration: BoxDecoration(color: themeColor),
          padding: const EdgeInsets.only(top: 150),
          alignment: Alignment.topLeft,
          width: 150,
          height: 100,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 30),
                alignment: Alignment.center,
                child: Text(
                  'CopyGram',
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 60,
                    fontFamily: 'DancingScript',
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                child: TextField(
                  cursorColor: secondaryColor,
                  controller: usernameController,
                  decoration: InputDecoration(
                    fillColor: secondaryColor,
                    filled: true,
                    border: OutlineInputBorder(
                      
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  cursorColor: secondaryColor,
                  obscureText: _isObscure,
                  controller: passwordController,
                  decoration: InputDecoration(
                    fillColor: secondaryColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.password),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                ),
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: secondaryColor,
                    
                  ),
                  child: Text(
                    'Log In',
                    style: TextStyle(color: themeColor),
                  ),
                  onPressed: () {
                    signInUser(
                        usernameController.text, passwordController.text);
                    clearFields();
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  print('Forgot password pressed');
                },
                child: Text(
                  'Forgot password?',
                  style: TextStyle(color: secondaryColor),
                ),
              ),
              Expanded(child: Container()),
              Container(
                padding: const EdgeInsets.only(
                    top: 10, left: 80, right: 10, bottom: 10),
                child: Row(children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(fontSize: 16, color: secondaryColor),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RegistrationScreen.routeName);
                      },
                      child: Text(
                        'Sing up',
                        style: TextStyle(fontSize: 24),
                      ))
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
