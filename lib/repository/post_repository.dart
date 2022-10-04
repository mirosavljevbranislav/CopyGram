import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/post.dart';

class PostRepository {
  final firebaseInstance = FirebaseFirestore.instance;

  PostRepository();

  Future<Post?> getPostByID(String postID) async {
    final post = await firebaseInstance
        .collection('posts')
        .where('postID', isEqualTo: postID)
        .get()
        .then((value) {
      for (var result in value.docs) {
        return Post(
            profilePictureID: result.data()['email'],
            username: result.data()['username'],
            userID: result.data()['userID'],
            postID: result.data()['postID'],
            picture: result.data()['picture'],
            location: result.data()['location'],
            description: result.data()['description'],
            pictureTakenAt: result.data()['pictureTakenAt'],
            likes: result.data()['likes'],
            comments: result.data()['comments']);
      }
    });
    return post;
  }
}
