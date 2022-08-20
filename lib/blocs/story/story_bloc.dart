import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'story_event.dart';
part 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  StoryBloc() : super(StoryInitial()) {
    on<PostStory>(_postStory);
  }



  void _loadStory(LoadingStory event, Emitter<StoryState> emit) {
    try {} catch (_) {}
  }

  void _postStory(PostStory event, Emitter<StoryState> emit) async {
    try {
      emit(StoryInitial());
      await Future<void>.delayed(const Duration(seconds: 3));
      emit(PostedStoryState());
    } catch (_) {}
  }
}
