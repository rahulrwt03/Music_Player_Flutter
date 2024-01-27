

import 'package:audio_player/models/song.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

class SongsProvider extends ChangeNotifier {
  //list of song
  final List<Song> _songsList = [
    // song1
    Song(
        songName: "Baaraat",
        artistName: "Neyo",
        albumArtImagePath: "assets/images/a.jpg",
        audioPath: "audio/a.mp3"),

    // song2
    Song(
        songName: "Kheriyat",
        artistName: "Arjit Singh",
        albumArtImagePath: "assets/images/a.jpg",
        audioPath: "audio/b.mp3"),

    //   song3
    Song(
        songName: "Banjaara",
        artistName: "SJ",
        albumArtImagePath: "assets/images/a.jpg",
        audioPath: "audio/c.mp3"),
  ];

  // current song playing index
  int? _currentSongIndex;

//   getter

  List<Song> get songsList => _songsList;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

// setter

  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play();
    }
  }

// audio player

  final AudioPlayer _audioPlayer = AudioPlayer();

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  SongsProvider() {
    listenToDuration();
  }

  bool _isPlaying = false;

  // play
  void play() async {
    final String songPath = _songsList[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(songPath));
    _isPlaying = true;
    notifyListeners();
  }

  //   pause
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // resume
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // pause or resume

  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  // seekbar duration

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // next
  void next() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _songsList.length - 1) {
        //   go to next song
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        //   loop it
        currentSongIndex = 0;
      }
    }
  }

  // previous
  void previous() async {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _songsList.length - 1;
      }
    }
  }

  // listen to duration
  void listenToDuration() {
    //   total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });
    //   current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    //   completion
    _audioPlayer.onPlayerComplete.listen((event) {
      next();
    });
  }

// update
  notifyListeners();
}
