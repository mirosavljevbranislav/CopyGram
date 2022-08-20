part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppLogoutRequested extends AuthEvent {}

class AppLoginRequested extends AuthEvent {
  final String email;
  final String password;

  const AppLoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}


class AppLoginFailed extends AuthEvent {}