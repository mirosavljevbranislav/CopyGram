part of 'auth_bloc.dart';

enum AuthStatus { authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus status;
  final String userID;

  const AuthState({this.status = AuthStatus.unauthenticated, this.userID = ''});

  const AuthState.authenticated(String userID)
      : this(status: AuthStatus.authenticated, userID: userID);

  const AuthState.unauthenticated()
      : this(
          status: AuthStatus.unauthenticated,
        );

  @override
  List<Object> get props => [status, userID];
}

class AppInitial extends AuthState {}
