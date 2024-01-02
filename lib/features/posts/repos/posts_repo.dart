import 'dart:convert';
import 'package:Video_Player/features/posts/models/posts_ui_data_model.dart';
import 'package:http/http.dart ' as http;

class PostsRepo {
  static Future<List<PostsUiDataModel>> fetchPosts() async {
    var client = http.Client();
    List<PostsUiDataModel> posts = [];
    try {
      var response = await client.get(Uri.parse(
          'https://test-ximit.mahfil.net/api/trending-video/1?page=1'));
      List<dynamic> result =
          jsonDecode(utf8.decode(response.bodyBytes))["results"];
      for (int i = 0; i < result.length; i++) {
        PostsUiDataModel post = PostsUiDataModel.fromJson(result[i]);
        posts.add(post);
      }
      print("hello");
      return posts;
    } catch (e) {
      print('Error: ${e.toString()}');
      return [];
    }
  }
}
