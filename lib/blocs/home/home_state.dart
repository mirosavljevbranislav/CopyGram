part of 'home_bloc.dart';

enum HomeStatus { initial, loaded, failed }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<Map> posts;
  final List<Map> user;

  const HomeState(
      {this.status = HomeStatus.initial,
      this.posts = const [],
      this.user = const []});
  const HomeState.loaded(List<Map> posts, List<Map> userList)
      : this(status: HomeStatus.loaded, posts: posts, user: userList);

  @override
  List<Object> get props => [posts];
}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  const HomeLoaded();

  @override
  List<Object> get props => [];
}

class HomeFailed extends HomeState {}
