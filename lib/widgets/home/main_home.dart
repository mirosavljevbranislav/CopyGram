import 'package:flutter/material.dart';

import '../../screens/home/settings_screen.dart';
import '../../screens/profile/new_post_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/search/search_screen.dart';
import 'home_widget.dart';

class NewHome extends StatefulWidget {
  const NewHome({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: NewHome());

  @override
  State<NewHome> createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  String screenToShow = '';

  Widget returnScreen(String? screenToReturn) {
    if (screenToReturn == '' || screenToReturn == 'home') {
      return const HomeTest();
    } else if (screenToReturn == 'search') {
      return const SearchScreen();
    } else if (screenToReturn == 'settings') {
      return SettingsScreen();
    } else if (screenToReturn == 'profile') {
      return const ProfileScreen();
    }
    return const HomeTest();
  }

  @override
  Widget build(BuildContext context) {
    Color? themeColor = Theme.of(context).primaryColor;
    return Scaffold(
      body: returnScreen(screenToShow),
      // floatingActionButton: RawMaterialButton(
      //   onPressed: () {
      //     Navigator.push(context, MaterialPageRoute(builder: (context) {
      //       return const NewPostScreen();
      //     }));
      //   },
      //   elevation: 2.0,
      //   fillColor: Colors.white,
      //   child: const Icon(
      //     Icons.add,
      //     size: 35.0,
      //   ),
      //   padding: const EdgeInsets.all(15.0),
      //   shape: const CircleBorder(),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: themeColor,
        notchMargin: 5,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  screenToShow = 'home';
                });
              },
              icon: const Icon(Icons.home),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  screenToShow = 'search';
                });
              },
              icon: const Icon(Icons.search),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const NewPostScreen();
                }));
              },
              icon: const Icon(Icons.add_box),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  screenToShow = 'settings';
                });
              },
              icon: const Icon(Icons.settings),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  screenToShow = 'profile';
                });
              },
              icon: const Icon(Icons.person),
              color: Colors.white,
            ),
          ],
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
    );
  }
}
