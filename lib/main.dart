import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:Video_Player/features/home/home_page.dart';
import 'package:Video_Player/features/posts/ui/post_page.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:Video_Player/features/video_screen/ui/video_screen_ui.dart';

void main() {
  initializeDateFormatting('bn', null).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: posts());
  }
}
