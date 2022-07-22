// ignore_for_file: avoid_print, prefer_const_constructors, unused_local_variable, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igc2/blocs/auth/auth_bloc.dart';
import 'package:igc2/screens/auth/registration_screen.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final bool _isObscure = true;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void clearFields() {
    usernameController.clear();
    passwordController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
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
              _Title(secondaryColor: secondaryColor),
              _Email(
                usernameController: usernameController,
                secondaryColor: secondaryColor,
              ),
              _Password(
                secondaryColor: secondaryColor,
                usernameController: usernameController,
                passwordController: passwordController,
                isObscure: _isObscure,
              ),
              _Login(
                secondaryColor: secondaryColor,
                themeColor: themeColor,
                usernameController: usernameController,
                passwordController: passwordController,
              ),
              _ForgotPassword(secondaryColor: secondaryColor),
              Expanded(child: Container()),
              _SignUp(secondaryColor: secondaryColor),
            ],
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  Color secondaryColor;
  final usernameController = TextEditingController();
  _Title({required this.secondaryColor});
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class _Email extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  Color secondaryColor;

  _Email({required this.usernameController, required this.secondaryColor});
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class _Password extends StatefulWidget {
  Color? secondaryColor;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscure;

  _Password(
      {Key? key,
      required this.secondaryColor,
      required this.usernameController,
      required this.passwordController,
      required this.isObscure})
      : super(key: key);

  @override
  State<_Password> createState() => __PasswordState();
}

class __PasswordState extends State<_Password> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        cursorColor: widget.secondaryColor,
        obscureText: widget.isObscure,
        controller: widget.passwordController,
        decoration: InputDecoration(
          fillColor: widget.secondaryColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          labelText: 'Password',
          prefixIcon: Icon(Icons.password),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                widget.isObscure = !widget.isObscure;
              });
            },
            icon: Icon(
                widget.isObscure ? Icons.visibility : Icons.visibility_off),
          ),
        ),
      ),
    );
  }
}

class _Login extends StatelessWidget {
  Color secondaryColor;
  Color themeColor;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _Login({
    required this.secondaryColor,
    required this.themeColor,
    required this.usernameController,
    required this.passwordController,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
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
          try {
            context.read<AuthBloc>().add(AppLoginRequested(
                email: usernameController.text,
                password: passwordController.text));
          } catch (_) {
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
        },
      ),
    );
  }
}

class _ForgotPassword extends StatelessWidget {
  Color secondaryColor;
  _ForgotPassword({required this.secondaryColor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        print('Forgot password pressed');
      },
      child: Text(
        'Forgot password?',
        style: TextStyle(color: secondaryColor),
      ),
    );
  }
}

class _SignUp extends StatelessWidget {
  Color secondaryColor;

  _SignUp({required this.secondaryColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 80, right: 10, bottom: 10),
      child: Row(children: [
        Text(
          'Don\'t have an account?',
          style: TextStyle(fontSize: 16, color: secondaryColor),
        ),
        TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return RegistrationScreen();
              }));
            },
            child: Text(
              'Sing up',
              style: TextStyle(fontSize: 24, color: secondaryColor),
            ))
      ]),
    );
  }
}
