import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:igc2/repository/auth_repository.dart';

import '../../models/user.dart';


part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadingHome>(_loadPosts);
  }
 
  void _loadPosts(LoadingHome event, Emitter<HomeState> emit) async {
    emit(HomeInitial());
    try {
      AuthRepository authRepo = AuthRepository();
      var userID =  FirebaseAuth.instance.currentUser!.uid;
      List<Map> emptyListOfPosts = <Map>[];
      SearchedUser user = await authRepo.getUserById(userID);
      print('FF ' + user.username.toString());
      await FirebaseFirestore.instance
          .collection('posts')
          .get()
          .then((querySnapshot) {
        for (var element in querySnapshot.docs) {
          emptyListOfPosts.add(element.data());
        }
      });
      print('FF ' + user.username.toString());
      emit(HomeState.loaded(emptyListOfPosts, user));
    } catch (_) {}
  }
}
