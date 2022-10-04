import 'package:flutter/material.dart';
import 'package:igc2/widgets/home/settings.dart';
import 'package:igc2/widgets/search/search_widget.dart';

import '../../screens/profile_screen.dart';
import '../new_post/new_post_widget.dart';
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
      return SearchWidget();
    } else if (screenToReturn == 'settings') {
      return SettingsWidget();
    } else if (screenToReturn == 'profile') {
      return const ProfileScreen();
    }
    return const HomeTest();
  }

  @override
  Widget build(BuildContext context) {
    Color? themeColor = Theme.of(context).primaryColor;
    Color? secondaryColor = Theme.of(context).primaryColorLight;
    return Scaffold(
      body: returnScreen(screenToShow),
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
              color: secondaryColor,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  screenToShow = 'search';
                });
              },
              icon: const Icon(Icons.search),
              color: secondaryColor,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NewPostWidget();
                }));
              },
              icon: const Icon(Icons.add_box),
              color: secondaryColor,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  screenToShow = 'settings';
                });
              },
              icon: const Icon(Icons.settings),
              color: secondaryColor,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  screenToShow = 'profile';
                });
              },
              icon: const Icon(Icons.person),
              color: secondaryColor,
            ),
          ],
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
    );
  }
}
