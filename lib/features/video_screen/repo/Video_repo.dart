import 'dart:convert';

import 'package:Video_Player/features/video_screen/models/Video_Screen_UI_Data_Model.dart';
import 'package:http/http.dart ' as http;

class VideoScreenRepo {
  static Future<List<VideoScreenUiDataModel>> fetchVideo() async {
    var client = http.Client();
    List<VideoScreenUiDataModel> posts = [];
    try {
      var response = await client.get(Uri.parse(
          'https://test-ximit.mahfil.net/api/trending-video/1?page=2'));
      List<dynamic> result = jsonDecode(response.body)["results"];
      for (int i = 0; i < result.length; i++) {
        VideoScreenUiDataModel post =
            VideoScreenUiDataModel.fromJson(result[i]);
        posts.add(post);
      }
      print("hello");
      print(posts);
      return posts;
    } catch (e) {
      print('Error: ${e.toString()}');
      return [];
    }
  }
}
