import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:igc2/repository/auth_repository.dart';
import '../../models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AppInitial()) {
    on<AppLoginRequested>(_loginUser);
    on<AppLogoutRequested>(_logoutUser);
  }

  void _logoutUser(AppLogoutRequested event, Emitter<AuthState> emit) {
    try {
      unawaited(authRepository.logOut());
      emit(const AuthState.unauthenticated());
    } catch (_) {}
  }

  void _loginUser(AppLoginRequested event, Emitter<AuthState> emit) async {
    try {
      await authRepository.logInWithEmailAndPassword(
          email: event.email, password: event.password);
      if (firebase_auth.FirebaseAuth.instance.currentUser != null) {
        String currentUserID =
            firebase_auth.FirebaseAuth.instance.currentUser!.uid;
        SearchedUser? userTest =
            await authRepository.getUserById(currentUserID);
        emit((event.email.isNotEmpty || event.password.isNotEmpty) &&
                userTest != null
            ? AuthState.authenticated(SearchedUser(
                email: userTest.email,
                fullname: userTest.fullname,
                username: userTest.username,
                posts: userTest.posts,
                followers: userTest.followers,
                following: userTest.following,
                postURL: userTest.postURL,
                stories: userTest.stories,
                viewedStories: userTest.viewedStories,
                pictureID: userTest.pictureID,
                userID: userTest.userID,
                description: userTest.description))
            : const AuthState.unauthenticated());
      } else {
        emit(AuthFailedState());
      }
    } on firebase_auth.FirebaseAuthException catch (_) {
      emit(AuthFailedState());
    }
  }
}
