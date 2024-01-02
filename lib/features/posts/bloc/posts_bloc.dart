import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:Video_Player/features/posts/models/posts_ui_data_model.dart';
import 'package:Video_Player/features/posts/repos/posts_repo.dart';
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
  }

  FutureOr<void> postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostFetchingLoadingState());
    List<PostsUiDataModel> posts = await PostsRepo.fetchPosts();
    emit(PostFetchingSuccessState(posts: posts));
  }
}
