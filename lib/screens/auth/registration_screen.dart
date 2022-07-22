import 'package:flutter/material.dart';
import 'package:igc2/widgets/auth/registration_widet.dart';

class RegistrationScreen extends StatelessWidget {
  static const routeName = '/register';
  const RegistrationScreen({Key? key}) : super(key: key);

  // static Page page() => const MaterialPage<void>(child: RegistrationScreen());

  @override
  Widget build(BuildContext context) {
    return const RegistrationWidget();
  }
}
