// ignore_for_file: must_be_immutable

part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadingHome extends HomeEvent {}

class LoadHome extends HomeEvent {
  List<Map> posts = <Map>[];

  LoadHome({required this.posts});

  @override
  List<Object> get props => [posts];
}
