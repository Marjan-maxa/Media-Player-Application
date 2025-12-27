import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
class MediaPlayerApp extends StatefulWidget {
  const MediaPlayerApp({super.key});

  @override
  State<MediaPlayerApp> createState() => _MediaPlayerAppState();
}

class _MediaPlayerAppState extends State<MediaPlayerApp> {

  final AudioPlayer _audioPlayer=AudioPlayer();


  List<Song> _playlist=[
   Song(title: '3-second synth melody', artiest: 'Sample MP3 audio files', url: 'https://samplelib.com/lib/preview/mp3/sample-3s.mp3', duration: 3),
   Song(title: '6-second synth melody', artiest: 'Sample MP3 audio files', url: 'https://samplelib.com/lib/preview/mp3/sample-6s.mp3', duration: 6),
   Song(title: '9-second melody using background drums', artiest: 'Sample MP3 audio files', url: 'https://samplelib.com/lib/preview/mp3/sample-9s.mp3', duration: 9),
   Song(title: '12-second melody using flute and whole drum ensemble', artiest: 'Sample MP3 audio files', url: 'https://samplelib.com/lib/preview/mp3/sample-12s.mp3', duration: 12),

  ];

  int _currentindex=0;
  bool isPlaying=false;
  Duration _positions=Duration.zero;
  Duration _duration=Duration.zero;

  void _listenToPlay(){
    _audioPlayer.onDurationChanged.listen((duration){
     setState(() {
       _duration=duration;
     });
    });
    
    _audioPlayer.onPositionChanged.listen((position){
      setState(() {
        _positions=position;
      });

      _audioPlayer.onPlayerStateChanged.listen((state){
        setState(() {
          isPlaying=state==PlayerState.playing;
        });
      });
    });
  }

  Future<void>_playSong(int index) async {
    _currentindex=index;
    final  song=_playlist[index];
    setState(() {
      _positions=Duration.zero;
      _duration=Duration(seconds: song.duration);
    });
   await _audioPlayer.stop();
    await _audioPlayer.play(UrlSource(_playlist[index].url));
  }

  Future<void>_togglePlayPause()async {
    if(isPlaying){
      _audioPlayer.pause();
    }else{
      _audioPlayer.resume();
    }
  }

  Future<void>_nextSong()async {
   final int next=(_currentindex+1)%_playlist.length;
   _playSong(next);
  }

  Future<void>_previousSong()async {
    final int previous=(_currentindex-1+_playlist.length)%_playlist.length;
    _playSong(previous);
  }
  
  String _formatDuration(Duration duration){
    final int minute=duration.inMinutes;
    final int second=duration.inSeconds.remainder(60);
    return '$minute:${second.toString().padLeft(2,'0')}';
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listenToPlay();
  }


  @override
  Widget build(BuildContext context) {
    
    final Song song=_playlist[_currentindex];


    final double maxSecond=max(_duration.inSeconds.toDouble(), 1);
    final double currentSecond=_positions.inSeconds.toDouble().clamp(1, maxSecond);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Media Player',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          children:
          [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [

                    Text(song.title,style: Theme.of(context).textTheme.titleLarge,),
                Text(song.artiest,style: Theme.of(context).textTheme.titleMedium,),
                Slider(
                  min: 0,
                    max: maxSecond,

                    value: currentSecond,
                    onChanged: (value) async{
                   final position=Duration(seconds: value.toInt());
                   await _audioPlayer.seek(position);
                }
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_formatDuration(_positions)),
                    Text(_formatDuration(_duration))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(onPressed: _previousSong, icon: Icon(Icons.skip_previous)),
                    IconButton(onPressed: _togglePlayPause, icon: isPlaying? Icon(Icons.pause):Icon(Icons.play_arrow)),
                    IconButton(onPressed: _nextSong, icon: Icon(Icons.skip_next))
                  ],
                )

                    ],
                ),
              ),

            ),
            const SizedBox(height: 15,),
            Expanded(
              child: ListView.builder(
                itemCount: _playlist.length,
                  itemBuilder: (context,index){
                  Song song=_playlist[index];
                  final bool isCurrent=index==_currentindex;
                  return ListTile(
                    tileColor: Colors.grey,
                    style: ListTileStyle.list,
                    title: Text(song.title,),
                    subtitle: Text(song.artiest,),
                    trailing: isCurrent&& isPlaying? Icon(Icons.pause):Icon(Icons.play_arrow),
                    leading: CircleAvatar(
                      child: Text('${index+1}'),
                    ),
                    onTap: (){
                      print('Number of song play:  ${index.toString()}');
                      _playSong(index);
                    },
                    selected: isCurrent,
                  );

              }),
            )

          ],

        ),
      )

      );

  }


}
 class Song{
  final String title;
  final String artiest;
  final String url;
  final int duration;

  Song({ required this.title,
    required this.artiest
    ,required this.url,
    required this.duration,
  } );

}


