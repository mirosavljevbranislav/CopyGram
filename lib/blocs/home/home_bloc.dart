import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadingHome>(_loadPosts);
  }

  void _loadPosts(LoadingHome event, Emitter<HomeState> emit) async {
    try {
      List<Map> emptyListToFill = <Map>[];
      List<Map> userList = <Map>[];
      FirebaseFirestore.instance
          .collection('posts')
          .get()
          .then((querySnapshot) {
        for (var element in querySnapshot.docs) {
          emptyListToFill.add(element.data());
        }
      });
      String? currentUserID = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance
          .collection("users")
          .where("userID", isEqualTo: currentUserID)
          .get()
          .then((value) {
        for (var result in value.docs) {
          userList.add(result.data());
        }
      });
      emit(HomeState.loaded(emptyListToFill, userList));
    } catch (_) {}
  }
}
