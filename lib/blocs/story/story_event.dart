// ignore_for_file: must_be_immutable

part of 'story_bloc.dart';

abstract class StoryEvent extends Equatable {
  const StoryEvent();

  @override
  List<Object> get props => [];
}

class LoadingStory extends StoryEvent {}

class PostStory extends StoryEvent {
  File imageID;

  PostStory({required this.imageID});
  @override
  List<Object> get props => [imageID];
}
