import 'package:flutter/material.dart';
import 'package:igc2/screens/auth/login_screen.dart';
import 'package:igc2/widgets/home/main_home.dart';

import '../blocs/auth/auth_bloc.dart';

List<Page> onGenerateAppViewPages(
  AuthStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AuthStatus.authenticated:
      return [NewHome.page()];
    case AuthStatus.unauthenticated:
      return [LoginScreen.page()];
    case AuthStatus.failed:
      return [LoginScreen.page()];
    case AuthStatus.loading:
      return [LoginScreen.page()];
  }
}
