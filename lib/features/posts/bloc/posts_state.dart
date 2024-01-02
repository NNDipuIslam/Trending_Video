// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}

class PostsInitial extends PostsState {}

abstract class PostsActionState extends PostsState {}

class PostFetchingSuccessState extends PostsState {
  final List<PostsUiDataModel> posts;
  PostFetchingSuccessState({
    required this.posts,
  });
}

class PostFetchingLoadingState extends PostsState {}

class PostFetchingErrorState extends PostsState {}
