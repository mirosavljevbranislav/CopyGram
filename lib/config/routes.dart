import 'package:flutter/material.dart';
import 'package:igc2/widgets/auth/login_widget.dart';
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
      return [LoginWidget.page()];
    case AuthStatus.failed:
      return [LoginWidget.page()];
    case AuthStatus.loading:
      return [LoginWidget.page()];
  }
}
