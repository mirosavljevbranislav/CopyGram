import 'package:flutter/material.dart';
import 'package:igc2/widgets/search/person_profile.dart';

class SearchedUserScreen extends StatelessWidget {
  static const routeName = '/searchedUser';
  const SearchedUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PersonProfile();
  }
}
