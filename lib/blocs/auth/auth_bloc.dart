// ignore_for_file: unused_import

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart' as user_model;
import '../../repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AppInitial()) {
    on<AppLoginRequested>(_loginUser);
    on<AppLogoutRequested>(_logoutUser);
  }

  void _logoutUser(AppLogoutRequested event, Emitter<AuthState> emit) {
    try {
      unawaited(firebase_auth.FirebaseAuth.instance.signOut());
      emit(const AuthState.unauthenticated());
    } catch (_) {}
  }

  void _loginUser(AppLoginRequested event, Emitter<AuthState> emit) async {
    try {
      await firebase_auth.FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(event.email.isNotEmpty || event.password.isNotEmpty
          ? AuthState.authenticated(
              firebase_auth.FirebaseAuth.instance.currentUser!.uid)
          : const AuthState.unauthenticated());
    } catch (_) {}
  }
}
