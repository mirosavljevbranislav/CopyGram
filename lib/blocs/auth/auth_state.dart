part of 'auth_bloc.dart';

enum AuthStatus { authenticated, loading, unauthenticated, failed }

class AuthState extends Equatable {
  final AuthStatus status;
  final SearchedUser user;

  const AuthState(
      {this.status = AuthStatus.unauthenticated,
      this.user = SearchedUser.empty});

  const AuthState.authenticated(SearchedUser user)
      : this(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated() : this(status: AuthStatus.unauthenticated);


  @override
  List<Object> get props => [status, user];
}
class AuthLoading extends AuthState {}

class AppInitial extends AuthState {}

class AuthFailedState extends AuthState {}
