// ignore_for_file: avoid_print, prefer_const_constructors, unused_local_variable, must_be_immutable, sized_box_for_whitespace

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igc2/blocs/auth/auth_bloc.dart';
import 'package:igc2/repository/auth_repository.dart';
import 'package:igc2/widgets/auth/registration_widet.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginWidget());
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
    Color usernameColor = Colors.grey;
    Color passwordColor = Colors.grey;
    String usernameText = 'Email';
    String passwordText = 'Password';
    bool isLoading = false;
    bool passResetRequested = false;
    double topPadding = 150;

    return Material(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthFailedState) {
              usernameController.clear();
              passwordController.clear();
              usernameColor = Colors.red;
              passwordColor = Colors.red;
              usernameText = 'Wrong email';
              passwordText = 'Wrong password';
              FocusScope.of(context).requestFocus(FocusNode());
            } else if (state is AuthLoading) {
              isLoading = true;
            }
            return Container(
              decoration: BoxDecoration(color: themeColor),
              padding: EdgeInsets.only(top: passResetRequested ? 90 : 150),
              alignment: Alignment.topLeft,
              width: 150,
              height: 100,
              child: Column(
                children: [
                  _Title(secondaryColor: secondaryColor),
                  _Email(
                    usernameController: usernameController,
                    secondaryColor: secondaryColor,
                    usernameColor: usernameColor,
                    usernameText: usernameText,
                  ),
                  _Password(
                    secondaryColor: secondaryColor,
                    usernameController: usernameController,
                    passwordController: passwordController,
                    isObscure: _isObscure,
                    passwordColor: passwordColor,
                    passwordText: passwordText,
                  ),
                  _Login(
                    secondaryColor: secondaryColor,
                    themeColor: themeColor,
                    usernameController: usernameController,
                    passwordController: passwordController,
                    isLoading: isLoading,
                  ),
                  _ForgotPassword(
                    secondaryColor: secondaryColor,
                    userEmail: 'mirosavljev01@gmail.com',
                    passResetRequested: passResetRequested,
                  ),
                  Expanded(child: Container()),
                  _SignUp(secondaryColor: secondaryColor),
                ],
              ),
            );
          },
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
  Color usernameColor;
  String usernameText;

  _Email(
      {required this.usernameController,
      required this.secondaryColor,
      required this.usernameColor,
      required this.usernameText});
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
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: usernameColor, width: 3)),
          fillColor: secondaryColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          labelText: usernameText,
          prefixIcon: Icon(
            Icons.email,
            color: usernameColor,
          ),
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
  Color passwordColor;
  String passwordText;

  _Password(
      {Key? key,
      required this.secondaryColor,
      required this.usernameController,
      required this.passwordController,
      required this.isObscure,
      required this.passwordColor,
      required this.passwordText})
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
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.passwordColor, width: 3)),
          fillColor: widget.secondaryColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          labelText: widget.passwordText,
          prefixIcon: Icon(
            Icons.password,
            color: widget.passwordColor,
          ),
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
  bool isLoading = false;

  _Login({
    required this.secondaryColor,
    required this.themeColor,
    required this.usernameController,
    required this.passwordController,
    required this.isLoading,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            isLoading = false;
            if (state is AuthLoading) {
              isLoading = true;
            }

            return ElevatedButton.icon(
                onPressed: isLoading
                    ? null
                    : () {
                        isLoading = false;
                        context.read<AuthBloc>().add(AppLoginRequested(
                            email: usernameController.text,
                            password: passwordController.text));
                      },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.redAccent;
                      }
                      return secondaryColor;
                    },
                  ),
                ),
                icon: isLoading ? Container() : Container(),
                label: isLoading ? Text('Logging in...') : Text('Login'));
          },
        ));
  }
}

class _ForgotPassword extends StatefulWidget {
  Color secondaryColor;
  String userEmail;
  bool passResetRequested;
  _ForgotPassword({
    required this.secondaryColor,
    required this.userEmail,
    required this.passResetRequested,
  });

  @override
  State<_ForgotPassword> createState() => __ForgotPasswordState();
}

class __ForgotPasswordState extends State<_ForgotPassword> {
  bool _visible = false;
  late FocusNode forgotPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    forgotPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    forgotPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthRepository authRepo = AuthRepository();
    final emailController = TextEditingController();
    return Column(children: [
      TextButton(
        onPressed: () {
          widget.passResetRequested = !widget.passResetRequested;
          setState(() {
            _visible = !_visible;
            Timer(const Duration(milliseconds: 10),
                () => forgotPasswordFocusNode.requestFocus());
          });
        },
        child: Text(
          'Forgot password?',
          style: TextStyle(color: widget.secondaryColor),
        ),
      ),
      AnimatedOpacity(
        // If the widget is visible, animate to 0.0 (invisible).
        // If the widget is hidden, animate to 1.0 (fully visible).
        opacity: _visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: Column(children: [
          Container(
              width: 250,
              child: TextField(
                controller: emailController,
                // readOnly: _visible? false : true,
                enabled: _visible ? true : false,
                focusNode: forgotPasswordFocusNode,
                style: TextStyle(color: Colors.blue),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your email',
                ),
              )),
          Container(
            width: 100,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.transparent),
                onPressed: _visible
                    ? () {
                        authRepo.resetPassword(emailController.text);
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Text(
                                      'An password reset has been sent to your email.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          _visible = !_visible;
                                        });
                                        emailController.clear();
                                      },
                                      child: Text('Ok'),
                                    )
                                  ],
                                ));
                      }
                    : null,
                child: Row(
                  children: const [
                    Text('Send', style: TextStyle(color: Colors.blue)),
                    SizedBox(width: 10),
                    Icon(Icons.send, color: Colors.blue),
                  ],
                )),
          ),
        ]),
      ),
    ]);
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
                return RegistrationWidget();
              }));
            },
            child: Text(
              'Sing up',
              style: TextStyle(fontSize: 24, color: Colors.blue),
            ))
      ]),
    );
  }
}
