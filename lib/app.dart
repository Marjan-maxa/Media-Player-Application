import 'package:flutter/material.dart';

import 'media_player_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MediaPlayerApp(),
    );
  }
}
