import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:Video_Player/features/video_screen/models/Video_Screen_UI_Data_Model.dart';
import 'package:Video_Player/features/video_screen/repo/Video_repo.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc() : super(VideoInitial()) {
    on<VideoInitialFetchEvent>(videoInitialFetchEvent);
  }

  FutureOr<void> videoInitialFetchEvent(
      VideoInitialFetchEvent event, Emitter<VideoState> emit) async {
    emit(VideoFetchingLoadingState());
    List<VideoScreenUiDataModel> posts = await VideoScreenRepo.fetchVideo();
    emit(VideoFetchingSuccessState(posts: posts));
  }
}
