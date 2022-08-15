part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadingProfile extends ProfileEvent {}

class LoadProfile extends ProfileEvent {
  final SearchedUser user;

  const LoadProfile({required this.user});

  @override
  List<Object> get props => [user];
}
