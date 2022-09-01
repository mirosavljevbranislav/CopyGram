import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';


part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadingHome>(_loadPosts);
  }
 
  void _loadPosts(LoadingHome event, Emitter<HomeState> emit) async {
    emit(HomeInitial());
    try {
      List<Map> emptyListToFill = <Map>[];
      await FirebaseFirestore.instance
          .collection('posts')
          .get()
          .then((querySnapshot) {
        for (var element in querySnapshot.docs) {
          emptyListToFill.add(element.data());
        }
      });
     
      emit(HomeState.loaded(emptyListToFill));
    } catch (_) {}
  }
}
