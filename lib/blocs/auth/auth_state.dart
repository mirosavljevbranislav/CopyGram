part of 'auth_bloc.dart';

enum AuthStatus { authenticated, unauthenticated, failed }

class AuthState extends Equatable {
  final AuthStatus status;
  final SearchedUser user;

  const AuthState(
      {this.status = AuthStatus.unauthenticated,
      this.user = SearchedUser.empty});

  const AuthState.authenticated(SearchedUser user)
      : this(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated() : this(status: AuthStatus.unauthenticated);

  const AuthState.failed() : this(status: AuthStatus.failed);

  @override
  List<Object> get props => [status, user];
}

class AppInitial extends AuthState {}

class AuthFailedState extends AuthState {}
