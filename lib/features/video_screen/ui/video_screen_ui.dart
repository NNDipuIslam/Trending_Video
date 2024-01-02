import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Video_Player/features/video_screen/bloc/video_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:video_player/video_player.dart';
import 'package:comment_box/comment/comment.dart';

class video extends StatefulWidget {
  final String thumbnail;
  final int id;
  final String title;
  final DateTime dateAndTime;
  final String slug;
  final DateTime createdAt;
  final Uri manifest;
  final int liveStatus;
  final dynamic liveManifest;
  final bool isLive;
  final String channelImage;
  final String channelName;
  final dynamic channelUsername;
  final bool isVerified;
  final String channelSlug;
  final String channelSubscriber;
  final int channelId;
  final String type;
  final String viewers;
  final String duration;
  final String objectType;
  const video(
      {required this.thumbnail,
      required this.id,
      required this.title,
      required this.dateAndTime,
      required this.slug,
      required this.createdAt,
      required this.manifest,
      required this.liveStatus,
      required this.liveManifest,
      required this.isLive,
      required this.channelImage,
      required this.channelName,
      required this.channelUsername,
      required this.isVerified,
      required this.channelSlug,
      required this.channelSubscriber,
      required this.channelId,
      required this.type,
      required this.viewers,
      required this.duration,
      required this.objectType,
      super.key});

  @override
  State<video> createState() => _videoState();
}

class _videoState extends State<video> {
  String commentText = "Please type a Comment ";
  late VideoPlayerController _videoController;
  late CustomVideoPlayerController _customVideoPlayerController;
  bool _ismuted = true;
  VideoBloc videoBloc = VideoBloc();
  TextEditingController _commentController = TextEditingController();
  @override
  void initState() {
    videoBloc.add(VideoInitialFetchEvent());
    super.initState();
    initializeVideoPlayer();
  }

  void initializeVideoPlayer() {
    _videoController = VideoPlayerController.networkUrl(widget.manifest)
      ..initialize().then((value) {
        setState(() {});
      });
    _customVideoPlayerController = CustomVideoPlayerController(
        context: context, videoPlayerController: _videoController);
  }

  @override
  void dispose() {
    _videoController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: BlocConsumer<VideoBloc, VideoState>(
                bloc: videoBloc,
                listenWhen: ((previous, current) =>
                    current is VideoActionState),
                buildWhen: ((previous, current) =>
                    current is! VideoActionState),
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case VideoFetchingLoadingState:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case VideoFetchingSuccessState:
                      return SingleChildScrollView(
                        child: Column(children: [
                          GestureDetector(
                            onTap: () {
                              _videoController.value.isPlaying
                                  ? _videoController.pause()
                                  : _videoController.play();
                            },
                            child: Stack(
                              children: [
                                Image.network(
                                  widget.thumbnail,
                                  height: 220,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                CustomVideoPlayer(
                                    customVideoPlayerController:
                                        _customVideoPlayerController),
                              ],
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row_Design(context, widget.title,
                                  widget.viewers, widget.createdAt)),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildAction(
                                  context, Icons.favorite_border, 'MASH ALLAH'),
                              _buildAction(
                                  context, Icons.thumb_up_alt_outlined, 'LIKE'),
                              _buildAction(context, Icons.share, 'SHARE'),
                              _buildAction(
                                  context, Icons.flag_outlined, 'REPORT'),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                  foregroundImage:
                                      NetworkImage(widget.channelImage),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                          child: Text(widget.channelName,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(fontSize: 25.0))),
                                      Flexible(
                                          child: Text(
                                              '${widget.channelSubscriber} Subscribers ',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(fontSize: 20.0))),
                                    ],
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    width: 90,
                                    decoration:
                                        BoxDecoration(color: Colors.blue),
                                    child: Center(
                                      child: Text(
                                        "Subscribe",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Divider(),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Comments  .  7.5K",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                              )
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              controller: _commentController,
                              decoration: InputDecoration(
                                hintText: 'Type your comment...',
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.send),
                                  onPressed: () {
                                    commentText = _commentController.text;
                                    print(commentText);
                                    setState(() {});
                                    _commentController.clear();
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  foregroundImage:
                                      NetworkImage(widget.channelImage),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    //mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                          child: Text('Anonymas member',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(fontSize: 20.0))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(52, 0, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  commentText,
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          Divider()
                        ]),
                      );

                    case VideoFetchingErrorState:
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
                })));
  }
}

Widget _buildAction(BuildContext context, IconData icon, String s) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: GestureDetector(
      onTap: () {},
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 11, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: Colors.black.withOpacity(0.5),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                s,
                style: TextStyle(
                    fontSize: 20, color: Colors.black.withOpacity(0.5)),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget Row_Design(context, String title, String viewers, DateTime createdAt) {
  return Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
                child: Text(title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 30.0))),
            SizedBox(
              height: 8,
            ),
            Flexible(
                child: Text('${viewers} views . ${timeago.format(createdAt)} ',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(fontSize: 20.0))),
          ],
        ),
      ),
    ],
  );
}
