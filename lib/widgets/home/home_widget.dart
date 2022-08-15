// ignore_for_file: must_be_immutable, void_checks, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igc2/blocs/auth/auth_bloc.dart';
import 'package:igc2/widgets/home/story/add_story.dart';
import 'package:igc2/widgets/home/story/no_story_widget.dart';
import 'package:igc2/widgets/home/story/your_story_widget.dart';

import '../../blocs/home/home_bloc.dart';
import '../../blocs/story/story_bloc.dart';
import '../../models/post.dart';
import '../../models/user.dart';
import '../profile/post/single_post_widget.dart';

class HomeTest extends StatefulWidget {
  HomeTest({Key? key}) : super(key: key);

  static Page page() => MaterialPage<void>(child: HomeTest());

  @override
  State<HomeTest> createState() => _HomeTestState();
}

class _HomeTestState extends State<HomeTest> {
  final controller = PageController(
      initialPage: 1); // OVDE SAM MENJAO INITIAL PAGE SA 0 NA 1 JER JE DEFAULT VREDNSOT BILA 0 I NIJE HTELO DA MENJA
  @override
  Widget build(BuildContext context) {
    Color? themeColor = Theme.of(context).primaryColor;
    Color? secondaryColor = Theme.of(context).primaryColorLight;
    final authStateUser = context.select((AuthBloc bloc) => bloc.state.user);
    final homeBlocState =
        context.select((HomeBloc homeBloc) => homeBloc.state.user);
    final following = [];
    FirebaseFirestore.instance
        .collection("users")
        .where("userID", isEqualTo: authStateUser.userID)
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
      body: PageView(children: [
        AddStoryWidget(
          user: homeBlocState[0],
        ),
        Container(
          color: themeColor,
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (((context, homeState) {
              if (homeState is HomeInitial) {
                return const CircularProgressIndicator();
              } else {
                return Column(children: [
                  Row(children: [
                    BlocBuilder<StoryBloc, StoryState>(
                      builder: (context, storystate) {
                        if (storystate is NoStoryState || authStateUser.stories!.isEmpty) {
                          return NoStoryWidget(
                            pictureID: authStateUser.pictureID!,
                            secondaryColor: secondaryColor,
                            user: authStateUser.toJson(),
                          );
                        } else if (storystate is StoryInitial) {
                          const CircularProgressIndicator();
                        }
                        return YourStoryWidget(
                            secondaryColor: secondaryColor,
                            user: SearchedUser(
                              email: authStateUser.email,
                              fullname: authStateUser.fullname,
                              username: authStateUser.username,
                              posts: authStateUser.posts,
                              followers: authStateUser.followers,
                              following: authStateUser.following,
                              postURL: authStateUser.postURL,
                              stories: authStateUser.stories,
                              viewedStories: authStateUser.viewedStories,
                              pictureID: authStateUser.pictureID,
                              userID: authStateUser.userID,
                            ));
                      },
                    ),
                    Row(
                      children: [],
                    )
                  ]),
                  const SizedBox(height: 1),
                  Expanded(
                    child: Center(
                      child: Container(
                        color: themeColor,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: homeState.posts.length,
                          itemBuilder: (ctx, index) => Container(
                              color: themeColor,
                              padding: const EdgeInsets.all(10),
                              child: SinglePostWidget(
                                post: Post(
                                    profilePictureID: homeState.posts[index]['profilePictureID'],
                                    username: homeState.posts[index]['username'],
                                    userID: homeState.posts[index]['userID'],
                                    postID: homeState.posts[index]['postID'],
                                    picture: homeState.posts[index]['picture'],
                                    location: homeState.posts[index]['location'],
                                    description: homeState.posts[index]['description'],
                                    likes: homeState.posts[index]['likes'],
                                    comments: homeState.posts[index]['comments'],
                                    pictureTakenAt: homeState.posts[index]['pictureTakenAt']),
                              )),
                        ),
                      ),
                    ),
                  ),
                ]);
              }
            })),
          ),
        ),
        Container(
          color: Colors.amber,
          child: const Center(
            child: Text(
              'Chat page',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ]),
    );
  }
}


// child: Container(
//                       alignment: Alignment.centerLeft,
//                       color: themeColor,
//                       height: 100,
//                       child: homeState.user[0]['stories'].isEmpty
//                           ? NoStoryWidget(
//                               pictureID: homeState.user[0]['pictureID'],
//                               secondaryColor: secondaryColor,
//                               user: homeState.user[0],
//                             )
//                           : YourStoryWidget(
//                               secondaryColor: secondaryColor,
//                               user: SearchedUser(
//                                 email: homeState.user[0]['email'],
//                                 fullname: homeState.user[0]['fullname'],
//                                 username: homeState.user[0]['username'],
//                                 posts: homeState.user[0]['posts'],
//                                 followers: homeState.user[0]['followers'],
//                                 following: homeState.user[0]['following'],
//                                 postURL: homeState.user[0]['postURL'],
//                                 stories: homeState.user[0]['stories'],
//                                 viewedStories: homeState.user[0]['viewedStories'],
//                                 pictureID: homeState.user[0]['pictureID'],
//                                 userID: homeState.user[0]['userID'],
//                               )),
//                     ),


// Column(children: [
//             Row(children: [
//               Container(
//                 alignment: Alignment.centerLeft,
//                 color: themeColor,
//                 height: 100,
//                 child: StreamBuilder(
//                     stream: FirebaseFirestore.instance
//                         .collection('users')
//                         .snapshots(),
//                     builder:
//                         (ctx, AsyncSnapshot<QuerySnapshot> streamsnapshot) {
//                       if (streamsnapshot.connectionState ==
//                           ConnectionState.waiting) {
//                         return const Center(child: CircularProgressIndicator());
//                       }
//                       final documents = streamsnapshot.data?.docs;
//                       for (int i = 0; i < documents!.length; i++) {
//                         if (documents[i]['userID'] == userID) {
//                           SearchedUser user = SearchedUser(
//                               email: documents[i]['email'],
//                               fullname: documents[i]['fullname'],
//                               username: documents[i]['username'],
//                               posts: documents[i]['posts'],
//                               followers: documents[i]['followers'],
//                               following: documents[i]['following'],
//                               postURL: documents[i]['postURL'],
//                               stories: documents[i]['stories'],
//                               viewedStories: documents[i]['viewedStories'],
//                               pictureID: documents[i]['pictureID'],
//                               userID: documents[i]['userID']);
//                           if (documents[i]['stories'].length == 0) {
//                             return NoStoryWidget(
//                               pictureID: documents[i]['pictureID'],
//                               secondaryColor: secondaryColor,
//                               user: user.toJson(),
//                             );
//                           }
//                         }
//                         SearchedUser user = SearchedUser(
//                             email: documents[i]['email'],
//                             fullname: documents[i]['fullname'],
//                             username: documents[i]['username'],
//                             posts: documents[i]['posts'],
//                             followers: documents[i]['followers'],
//                             following: documents[i]['following'],
//                             postURL: documents[i]['postURL'],
//                             stories: documents[i]['stories'],
//                             viewedStories: documents[i]['viewedStories'],
//                             pictureID: documents[i]['pictureID'],
//                             userID: documents[i]['userID']);
//                         YourStoryWidget(
//                             secondaryColor: secondaryColor, user: user);
//                       }
//                       return Container();
//                     }),
//               ),
//               following.isEmpty
//                   ? const Text(
//                       'No stories',
//                       style: TextStyle(color: Colors.red),
//                     )
//                   : Row(
//                       children: [],
//                     )
//             ]),
//             const SizedBox(height: 1),
//             Expanded(
//               child:
//                   BlocBuilder<HomeBloc, HomeState>(builder: ((context, state) {
//                 if (state is HomeInitial) {
//                   return const CircularProgressIndicator();
//                 } else if (state is HomeLoaded) {
//                   return Container(
//                     color: themeColor,
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: state.posts.length,
//                       itemBuilder: (ctx, index) => Container(
//                           color: themeColor,
//                           padding: const EdgeInsets.all(10),
//                           child: SinglePostWidget(
//                             post: Post(
//                                 profilePictureID: state.posts[index]['profilePictureID'],
//                                 username: state.posts[index]['username'],
//                                 userID: state.posts[index]['userID'],
//                                 postID: state.posts[index]['postID'],
//                                 picture: state.posts[index]['picture'],
//                                 location: state.posts[index]['location'],
//                                 description: state.posts[index]['description'],
//                                 likes: state.posts[index]['likes'],
//                                 comments: state.posts[index]['comments'],
//                                 pictureTakenAt: state.posts[index]['pictureTakenAt']),
//                           )),
//                     ),
//                   );
//                 }
//                 return Text(
//                   'Error',
//                   style: TextStyle(color: secondaryColor, fontSize: 13),
//                 );
//               })),
//             ),
//           ]),