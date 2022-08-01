import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostState> {
  PostsBloc() : super(PostsInitial()) {
    on<LoadingPosts>(_loadPosts);
  }

  void _loadPosts(LoadingPosts event, Emitter<PostState> emit) {
    try {
      List<Map> emptyListToFill = <Map>[];
      FirebaseFirestore.instance
          .collection('posts')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          emptyListToFill.add(element.data());
        });
      });
      emit(PostsLoaded.loaded(emptyListToFill));
    } catch (_) {}
  }
}
