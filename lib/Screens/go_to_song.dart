import 'package:audio_player/models/songs_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SongScreen extends StatefulWidget {
  const SongScreen({Key? key}) : super(key: key);

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  String formatTime(Duration duration) {
    String twoDigitSecond =
    duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSecond";

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Consumer<SongsProvider>(
      builder: (context, value, child) {
        final songList = value.songsList;
        final currentSong = songList[value.currentSongIndex ?? 0];

        return Scaffold(
          backgroundColor: Colors.grey.shade300,
          appBar: AppBar(
            title: const Text("M U S I C"),
            centerTitle: true,
            backgroundColor: Colors.blue.shade900,
          ),
          body: Column(

            children: [
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22.0,
                  vertical: 10.0,
                ),
                child: Container(

                  decoration :BoxDecoration(
                    color: Colors.blue.shade900,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 8.0),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          currentSong.albumArtImagePath,
                          height: 300,
                          width: 300,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentSong.songName,
                                  style:  TextStyle(
                                    color: Colors.grey.shade300,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  currentSong.artistName,
                                  style:  TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const Icon(CupertinoIcons.heart_fill, color: Colors.red),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatTime(value.currentDuration),
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const Icon(Icons.shuffle_outlined, color: Colors.black87),
                    const Icon(Icons.repeat, color: Colors.black87),
                    Text(
                      formatTime(value.totalDuration),
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),
                  ),
                  child: Slider(
                    min: 0,
                    max: value.totalDuration.inSeconds.toDouble(),
                    value: value.currentDuration.inSeconds.toDouble(),
                    activeColor: Colors.blue.shade900,
                    onChanged: (double sliderValue) {

                    },
                    onChangeEnd: (double sliderValue) {
                      value.seek(Duration(seconds: sliderValue.toInt()));
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildControlButton(Icons.skip_previous, value.previous),
                  const SizedBox(width: 20),
                  _buildControlButton(
                    value.isPlaying ? Icons.pause : Icons.play_arrow,
                    value.pauseOrResume,
                  ),
                  const SizedBox(width: 20),
                  _buildControlButton(Icons.skip_next, value.next),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildControlButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: 70,
        decoration: BoxDecoration(
          color: Colors.blue.shade900,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Icon(icon, color: Colors.grey.shade300),
      ),
    );
  }
}
