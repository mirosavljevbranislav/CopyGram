// ignore_for_file: avoid_print, prefer_const_constructors, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:igc2/screens/home_screen.dart';
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!);
      Navigator.pushNamed(context, HomeScreen.routeName);
    }on FirebaseAuthException catch (e){
      if (e.code == 'user-not-found' || e.code == 'wrong-password'){
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
      }else{
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
          padding: const EdgeInsets.only(top: 150),
          alignment: Alignment.topLeft,
          width: 150,
          height: 100,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Material(
                  child: TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Material(
                  child: TextField(
                    obscureText: _isObscure,
                    controller: passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            icon: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off))),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  print('Forgot password pressed');
                },
                child: const Text(
                  'Forgot password?',
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    signInUser(usernameController.text, passwordController.text);
                    clearFields();
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 50),
                child: Row(children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(fontSize: 24),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RegistrationScreen.routeName);
                        print('Sing in pressed');
                      },
                      child: const Text('Sing in'))
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
