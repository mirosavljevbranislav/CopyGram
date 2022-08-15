part of 'story_bloc.dart';

enum StoryStatus { noStory, loading, posted }

abstract class StoryState extends Equatable {
  const StoryState();

  @override
  List<Object> get props => [];
}

class StoryInitial extends StoryState {}

class NoStoryState extends StoryState {}

class PostedStoryState extends StoryState {}
