// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igc2/screens/home/settings_screen.dart';
import 'package:igc2/widgets/home/home_widget.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/profile/new_post_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/search/search_screen.dart';

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
              // Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(builder: (context) {
              //   return LoginScreen();
              // }), (route) => false);
            },
            child: const Text(
              'Logout',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ]),
      ),
      // floatingActionButton: RawMaterialButton(
      //   onPressed: () {
      //     Navigator.pushNamed(context, NewPostScreen.routeName);
      //   },
      //   elevation: 2.0,
      //   fillColor: Colors.white,
      //   child: Icon(
      //     Icons.add,
      //     size: 35.0,
      //   ),
      //   padding: EdgeInsets.all(15.0),
      //   shape: CircleBorder(),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: BottomAppBar(
      //   color: themeColor,
      //   shape: CircularNotchedRectangle(),
      //   notchMargin: 5,
      //   child: Row(
      //     children: [
      //       IconButton(
      //         onPressed: () {
      //           Navigator.push(context, MaterialPageRoute(builder: (context) {
      //             return HomeTest();
      //           }));
      //         },
      //         icon: Icon(Icons.home),
      //         color: Colors.white,
      //       ),
      //       IconButton(
      //         onPressed: () {
      //           Navigator.push(context, MaterialPageRoute(builder: (context) {
      //             return SearchScreen();
      //           }));
      //         },
      //         icon: Icon(Icons.search),
      //         color: Colors.white,
      //       ),
      //       IconButton(
      //         onPressed: () {},
      //         icon: Icon(Icons.settings),
      //         color: Colors.white,
      //       ),
      //       IconButton(
      //         onPressed: () {
      //           Navigator.push(context, MaterialPageRoute(builder: (context) {
      //             return ProfileScreen();
      //           }));
      //         },
      //         icon: Icon(Icons.person),
      //         color: Colors.white,
      //       ),
      //     ],
      //     mainAxisSize: MainAxisSize.max,
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //   ),
      // ),
    );
  }
}
