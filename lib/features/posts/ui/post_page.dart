import 'package:Video_Player/features/video_screen/ui/video_screen_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Video_Player/features/posts/bloc/posts_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timeago/timeago.dart' as timeago;

class posts extends StatefulWidget {
  const posts({super.key});

  @override
  State<posts> createState() => _postsState();
}

class _postsState extends State<posts> {
  final PostsBloc postsBloc = PostsBloc();
  @override
  void initState() {
    postsBloc.add(PostsInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Scaffold(
              body: BlocConsumer<PostsBloc, PostsState>(
                bloc: postsBloc,
                listenWhen: ((previous, current) =>
                    current is PostsActionState),
                buildWhen: ((previous, current) =>
                    current is! PostsActionState),
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case PostFetchingLoadingState:
                      return Scaffold(
                          body: Center(
                        child: CircularProgressIndicator(),
                      ));
                    case PostFetchingSuccessState:
                      final successState = state as PostFetchingSuccessState;
                      //String banglaText = String.('bn').format(successState.posts[index].title);
                      return Container(
                        child: ListView.builder(
                          itemCount: successState.posts.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(5),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => video(
                                                    thumbnail: successState
                                                        .posts[index].thumbnail,
                                                    id: successState
                                                        .posts[index].id,
                                                    title: successState
                                                        .posts[index].title,
                                                    dateAndTime: successState
                                                        .posts[index]
                                                        .dateAndTime,
                                                    slug: successState
                                                        .posts[index].slug,
                                                    createdAt: successState
                                                        .posts[index].createdAt,
                                                    manifest: successState
                                                        .posts[index].manifest,
                                                    liveStatus: successState
                                                        .posts[index]
                                                        .liveStatus,
                                                    liveManifest: successState
                                                        .posts[index]
                                                        .liveManifest,
                                                    isLive: successState
                                                        .posts[index].isLive,
                                                    channelImage: successState
                                                        .posts[index]
                                                        .channelImage,
                                                    channelName: successState
                                                        .posts[index]
                                                        .channelName,
                                                    channelUsername:
                                                        successState
                                                            .posts[index]
                                                            .channelUsername,
                                                    isVerified: successState
                                                        .posts[index]
                                                        .isVerified,
                                                    channelSlug: successState
                                                        .posts[index]
                                                        .channelSlug,
                                                    channelSubscriber:
                                                        successState
                                                            .posts[index]
                                                            .channelSubscriber,
                                                    channelId: successState
                                                        .posts[index].channelId,
                                                    type: successState.posts[index].type,
                                                    viewers: successState.posts[index].viewers,
                                                    duration: successState.posts[index].duration,
                                                    objectType: successState.posts[index].objectType)),
                                          );
                                          print(successState.posts[index].id);
                                        },
                                        child: Stack(children: [
                                          Image.network(
                                            successState.posts[index].thumbnail,
                                            height: 220,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                          Positioned(
                                              bottom: 8.0,
                                              right: 8.0,
                                              child: Container(
                                                color: Colors.black,
                                                child: Text(
                                                  successState
                                                      .posts[index].duration,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ))
                                        ])),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 40,
                                            child: GestureDetector(
                                              child: CircleAvatar(
                                                foregroundImage: NetworkImage(
                                                  successState.posts[index]
                                                      .channelImage,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Flexible(
                                                    child: Text(
                                                        successState
                                                            .posts[index].title,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                fontSize:
                                                                    20.0))),
                                                Flexible(
                                                    child: Text(
                                                        '${successState.posts[index].viewers} views . ${timeago.format(successState.posts[index].createdAt)} ',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption!
                                                            .copyWith(
                                                                fontSize:
                                                                    15.0))),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.more_vert,
                                            size: 20,
                                          )
                                        ],
                                      ),
                                    ),
                                  ]),
                            );
                          },
                        ),
                      );
                    case PostFetchingErrorState:
                      return Scaffold(
                        body: Center(
                            child: Text(
                          "Error Occured",
                          style: TextStyle(fontSize: 20),
                        )),
                      );
                    default:
                      return Text("sorry");
                  }
                },
              ),
            )));
  }
}
