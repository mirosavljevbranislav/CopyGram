import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<LoadingProfile>(_loadProfile);
  }

  void _loadProfile(LoadingProfile event, Emitter<ProfileState> emit) async {
    try {
      String? currentUserID = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance
          .collection("users")
          .where("userID", isEqualTo: currentUserID)
          .get()
          .then((value) {
        value.docs.forEach((result) {
          SearchedUser user = SearchedUser(
              email: result.data()['email'],
              fullname: result.data()['fullname'],
              username: result.data()['username'],
              posts: result.data()['posts'],
              followers: result.data()['followers'],
              following: result.data()['following'],
              postURL: result.data()['postURL'],
              stories: result.data()['stories'],
              viewedStories: result.data()['viewedStories'],
              pictureID: result.data()['pictureID'],
              userID: result.data()['userID']);
          emit(ProfileLoaded.loaded(user));
        });
      });
    } catch (_) {}
  }
}
