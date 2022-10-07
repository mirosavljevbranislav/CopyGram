// ignore_for_file: must_be_immutable, void_checks, avoid_function_literals_in_foreach_calls


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igc2/blocs/auth/auth_bloc.dart';
import 'package:igc2/widgets/home/story/add_story.dart';
import 'package:igc2/widgets/home/story/no_story_widget.dart';
import 'package:igc2/widgets/home/story/circle_story_widget.dart';

import '../../blocs/home/home_bloc.dart';
import '../../blocs/story/story_bloc.dart';
import '../../models/post.dart';
import '../../models/user.dart';
import '../profile/post/single_post_widget.dart';

class HomeTest extends StatefulWidget {
  const HomeTest({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomeTest());

  @override
  State<HomeTest> createState() => _HomeTestState();
}

class _HomeTestState extends State<HomeTest> {
  final controller = PageController(
      initialPage:
          1); // OVDE SAM MENJAO INITIAL PAGE SA 0 NA 1 JER JE DEFAULT VREDNOST BILA 0 I NIJE HTELO DA MENJA
  @override
  Widget build(BuildContext context) {
    Color? themeColor = Theme.of(context).primaryColor;
    Color? secondaryColor = Theme.of(context).primaryColorLight;
    final authStateUser = context.select((AuthBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text(
          'CopyGram',
          style: TextStyle(
              fontFamily: 'DancingScript', fontSize: 34, color: secondaryColor),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.chat_bubble_rounded,
                color: secondaryColor,
              ),
              onPressed: () {}),
        ],
      ),
      body: PageView(children: [
        AddStoryWidget(
          user: authStateUser.toJson(),
        ),
        Container(
          color: themeColor,
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (((context, homeState) {
              if (homeState is HomeInitial) {
                return Center(
                    child: CircularProgressIndicator(
                  color: secondaryColor,
                ));
              } else {
                return Column(children: [
                  SizedBox(
                    height: 100,
                    child: Row(children: [
                      BlocBuilder<StoryBloc, StoryState>(
                        builder: (context, storystate) {
                          if (storystate is NoStoryState ||
                              authStateUser.stories!.isEmpty) {
                            return NoStoryWidget(
                              pictureID: authStateUser.pictureID!,
                              secondaryColor: secondaryColor,
                              user: authStateUser.toJson(),
                            );
                          } else if (storystate is StoryInitial) {
                            const CircularProgressIndicator();
                          }
                          return CircleStoryWidget(
                            storyText: 'Your story',
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
                                  description: authStateUser.description));
                        },
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: authStateUser.following!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          return StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .where('followers',arrayContains: authStateUser.userID)
                                .snapshots(),
                            builder: (_, AsyncSnapshot<QuerySnapshot> snapshots) {
                              var documents = snapshots.data?.docs;
                              return CircleStoryWidget(
                                storyText: documents![index]['username'],
                                secondaryColor: secondaryColor,
                                user: SearchedUser(
                                    email: documents[index]['email'],
                                    fullname: documents[index]['fullname'],
                                    username: documents[index]['username'],
                                    posts: documents[index]['posts'],
                                    followers: documents[index]['followers'],
                                    following: documents[index]['following'],
                                    postURL: documents[index]['postURL'],
                                    stories: documents[index]['stories'],
                                    viewedStories: documents[index]['viewedStories'],
                                    pictureID: documents[index]['pictureID'],
                                    userID: documents[index]['userID'],
                                    description: documents[index]['description']),
                              );
                            },
                          );
                        },
                      ),
                    ]),
                  ),
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
                                searchedUser: homeState.user,
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
