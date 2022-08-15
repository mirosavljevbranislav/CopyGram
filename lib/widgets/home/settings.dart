// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';

class SettingsWidget extends StatefulWidget {
  static var light = false;
  SettingsWidget({Key? key}) : super(key: key);

  static ThemeData darkTheme =
      ThemeData(primaryColor: Colors.black, primaryColorLight: Colors.white);

  static ThemeData lightTheme =
      ThemeData(primaryColor: Colors.white, primaryColorLight: Colors.black);
  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    Color? themeColor = Theme.of(context).primaryColor;
    Color? secondaryColor = Theme.of(context).primaryColorLight;
    return Scaffold(
      backgroundColor: themeColor,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: themeColor,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dark/Light mode',
                style: TextStyle(color: secondaryColor),
              ),
              Switch(
                value: SettingsWidget.light,
                onChanged: (toggle) {
                  setState(() {
                    SettingsWidget.light = toggle;
                  });
                },
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(AppLogoutRequested());

            },
            child: const Text(
              'Logout',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ]),
      ),
    );
  }
}
