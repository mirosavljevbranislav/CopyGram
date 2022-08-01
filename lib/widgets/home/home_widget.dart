// ignore_for_file: must_be_immutable, void_checks, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igc2/blocs/auth/auth_bloc.dart';
import 'package:igc2/widgets/home/story/no_story_widget.dart';
import 'package:igc2/widgets/home/story/your_story_widget.dart';

import '../../blocs/posts/posts_bloc.dart';
import '../../models/post.dart';
import '../../models/user.dart';
import '../profile/post/single_post_widget.dart';

class HomeTest extends StatefulWidget {
  static const routeName = '/home';
  HomeTest({Key? key}) : super(key: key);

  static Page page() => MaterialPage<void>(child: HomeTest());

  @override
  State<HomeTest> createState() => _HomeTestState();
}

class _HomeTestState extends State<HomeTest> {
  @override
  Widget build(BuildContext context) {
    Color? themeColor = Theme.of(context).primaryColor;
    Color? secondaryColor = Theme.of(context).primaryColorLight;
    final userID = context.select((AuthBloc bloc) => bloc.state.userID);
    final following = [];
    FirebaseFirestore.instance
        .collection("users")
        .where("userID", isEqualTo: userID)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        following.add(result.data()['following']);
      });
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: const Text(
          'CopyGram',
          style: TextStyle(fontFamily: 'DancingScript', fontSize: 34),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.chat_bubble_rounded), onPressed: () {}),
        ],
      ),
      body: Container(
        color: themeColor,
        child: Column(children: [
          Row(children: [
            Container(
              alignment: Alignment.centerLeft,
              color: themeColor,
              height: 100,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .snapshots(),
                  builder: (ctx, AsyncSnapshot<QuerySnapshot> streamsnapshot) {
                    if (streamsnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final documents = streamsnapshot.data?.docs;
                    for (int i = 0; i < documents!.length; i++) {
                      if (documents[i]['userID'] == userID) {
                        SearchedUser user = SearchedUser(
                            email: documents[i]['email'],
                            fullname: documents[i]['fullname'],
                            username: documents[i]['username'],
                            posts: documents[i]['posts'],
                            followers: documents[i]['followers'],
                            following: documents[i]['following'],
                            postURL: documents[i]['postURL'],
                            stories: documents[i]['stories'],
                            viewedStories: documents[i]['viewedStories'],
                            pictureID: documents[i]['pictureID'],
                            userID: documents[i]['userID']);
                        if (documents[i]['stories'].length == 0) {
                          return NoStoryWidget(
                            pictureID: documents[i]['pictureID'],
                            secondaryColor: secondaryColor,
                            user: user.toJson(),
                          );
                        }
                      }
                      SearchedUser user = SearchedUser(
                          email: documents[i]['email'],
                          fullname: documents[i]['fullname'],
                          username: documents[i]['username'],
                          posts: documents[i]['posts'],
                          followers: documents[i]['followers'],
                          following: documents[i]['following'],
                          postURL: documents[i]['postURL'],
                          stories: documents[i]['stories'],
                          viewedStories: documents[i]['viewedStories'],
                          pictureID: documents[i]['pictureID'],
                          userID: documents[i]['userID']);
                      YourStoryWidget(
                          secondaryColor: secondaryColor, user: user);
                    }
                    return Container();
                  }),
            ),
            following.isEmpty
                ? const Text(
                    'No stories',
                    style: TextStyle(color: Colors.red),
                  )
                : Row(
                    children: [],
                  )
          ]),
          const SizedBox(height: 1),
          Expanded(
            child:
                BlocBuilder<PostsBloc, PostState>(builder: ((context, state) {
              if (state is PostsInitial) {
                return const CircularProgressIndicator();
              } else if (state is PostsLoaded) {
                return Container(
                  color: themeColor,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.posts.length,
                    itemBuilder: (ctx, index) => Container(
                        color: themeColor,
                        padding: const EdgeInsets.all(10),
                        child: SinglePostWidget(
                          post: Post(
                              profilePictureID: state.posts[index]
                                  ['profilePictureID'],
                              username: state.posts[index]['username'],
                              userID: state.posts[index]['userID'],
                              postID: state.posts[index]['postID'],
                              picture: state.posts[index]['picture'],
                              location: state.posts[index]['location'],
                              description: state.posts[index]['description'],
                              likes: state.posts[index]['likes'],
                              comments: state.posts[index]['comments'],
                              pictureTakenAt: state.posts[index]
                                  ['pictureTakenAt']),
                        )),
                  ),
                );
              }
              return Text(
                'Error',
                style: TextStyle(color: secondaryColor, fontSize: 13),
              );
            })),
          ),
        ]),
      ),
    );
  }
}







// child: StreamBuilder(
            //   stream:
            //       FirebaseFirestore.instance.collection('posts').snapshots(),
            //   builder: (ctx, AsyncSnapshot<QuerySnapshot> streamsnapshot) {
            //     if (streamsnapshot.connectionState == ConnectionState.waiting) {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     }
            //     final documents = streamsnapshot.data?.docs;
            //     return Container(
            //       color: themeColor,
            //       child: ListView.builder(
            //         shrinkWrap: true,
            //         itemCount: documents?.length,
            //         itemBuilder: (ctx, index) => Container(
            //             color: themeColor,
            //             padding: const EdgeInsets.all(10),
            //             child: SinglePostWidget(
            //               post: Post(
            //                   profilePictureID: documents![index]
            //                       ['profilePictureID'],
            //                   username: documents[index]['username'],
            //                   userID: documents[index]['userID'],
            //                   postID: documents[index]['postID'],
            //                   picture: documents[index]['picture'],
            //                   location: documents[index]['location'],
            //                   description: documents[index]['description'],
            //                   likes: documents[index]['likes'],
            //                   comments: documents[index]['comments'],
            //                   pictureTakenAt: documents[index]
            //                       ['pictureTakenAt']),
            //             )),
            //       ),
            //     );
            //   },
            // ),