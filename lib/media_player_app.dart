import 'package:flutter/material.dart';

class MediaPlayerApp extends StatefulWidget {
  const MediaPlayerApp({super.key});

  @override
  State<MediaPlayerApp> createState() => _MediaPlayerAppState();
}

class _MediaPlayerAppState extends State<MediaPlayerApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Media Player',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
    );
  }
}
