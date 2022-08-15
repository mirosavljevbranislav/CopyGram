part of 'profile_bloc.dart';

enum ProfileStatus { initial, loaded, failed }

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileStatus status;
  final SearchedUser user;

  const ProfileLoaded({
    this.status = ProfileStatus.initial,
    this.user = SearchedUser.empty,
  });

  const ProfileLoaded.loaded(SearchedUser user)
      : this(status: ProfileStatus.loaded, user: user);

  @override
  List<Object> get props => [user];
}

class ProfileFailed extends ProfileState {}
