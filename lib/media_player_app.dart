import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
class MediaPlayerApp extends StatefulWidget {
  const MediaPlayerApp({super.key});

  @override
  State<MediaPlayerApp> createState() => _MediaPlayerAppState();
}

class _MediaPlayerAppState extends State<MediaPlayerApp> {

  final AudioPlayer _audioPlayer=AudioPlayer();
  List _playlist=[
    'https://samplelib.com/lib/preview/mp3/sample-3s.mp3'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Media Player',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
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

                    Text('Song Name',style: Theme.of(context).textTheme.titleLarge,),
                Text('Artiest Name',style: Theme.of(context).textTheme.titleMedium,),
                Slider(value: 0, onChanged: (value){}),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Start:00:00'),
                    Text('End:00:00')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.skip_previous)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.play_arrow)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.skip_previous))
                  ],
                )

                    ],
                ),
              ),

            ),
            const SizedBox(height: 15,),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                  itemBuilder: (context,index){
                  return ListTile(
                    title: Text('Song Title'),
                    subtitle: Text('Artiest Name'),
                    trailing: Icon(Icons.play_arrow),
                    leading: CircleAvatar(
                      child: Text('${index+1}'),
                    ),
                    onTap: (){
                      _audioPlayer.play(UrlSource(_playlist[0]));
                    },
                  );

              }),
            )

          ],

        ),
      )

      );
  }
}
