import 'package:audio_player/component/mydrawer.dart';
import 'package:audio_player/models/songs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/song.dart';
import 'go_to_song.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // get the songlist provider
  late final dynamic songListProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  //   get songlist provider
    songListProvider = Provider.of<SongsProvider>(context,listen: false);
  }

  // go to song
  void goToSong(int songIndex){
    songListProvider.currentSongIndex = songIndex;

    Navigator.push(context, MaterialPageRoute(builder: (context)=> SongScreen() ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text("M U S I C"),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: Consumer<SongsProvider>(builder: (context, value, child) {
        // get songs
        final List<Song> songsList = value.songsList;
        return ListView.builder(
            itemCount: songsList.length,
            itemBuilder: (context, index) {
              // get individual song
              final Song song = songsList[index];

              // list tile UI
              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artistName),
                leading: Image.asset(song.albumArtImagePath),
                onTap: () => goToSong(index),
              );
            });
      }),
    );
  }
}
