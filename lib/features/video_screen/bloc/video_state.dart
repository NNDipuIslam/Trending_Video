part of 'video_bloc.dart';

@immutable
sealed class VideoState {}

final class VideoInitial extends VideoState {}

class VideoActionState extends VideoState {}

class VideoFetchingLoadingState extends VideoState {}

class VideoFetchingSuccessState extends VideoState {
  final List<VideoScreenUiDataModel> posts;

  VideoFetchingSuccessState({required this.posts});
}

class VideoFetchingErrorState extends VideoState {}
