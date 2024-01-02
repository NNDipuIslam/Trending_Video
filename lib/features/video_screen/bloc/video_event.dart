part of 'video_bloc.dart';

@immutable
sealed class VideoEvent {}

class VideoInitialFetchEvent extends VideoEvent {}
