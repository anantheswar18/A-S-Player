import 'package:as_player/Model/mostplayeddb.dart';
import 'package:as_player/Model/songmodel.dart';
import 'package:as_player/Screens/anibottamnav.dart';
import 'package:as_player/Screens/snakenavigation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Functions/dbfunctions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _audioQuery = new OnAudioQuery();
  final box = SongBox.getInstance();
  // final mostbox = MostPlayedBox.getInstance();

  List<SongModel> fetchSongs = [];
  List<SongModel> allSongs = [];
  // void initState() {
  //   gotoHome();
  //   super.initState();
  // }
  void initState() {
    requestpermission();

    super.initState();
  }

  void requestpermission() async {
    // Permission.storage.request();

    bool permissionstatus = await _audioQuery.permissionsStatus();
    if (!permissionstatus) {
      await _audioQuery.permissionsRequest();

      fetchSongs = await _audioQuery.querySongs();
      for (var element in fetchSongs) {
        if (element.fileExtension == "mp3") {
          allSongs.add(element);
        }
      }
      for (var element in allSongs) {
        await box.add(Songs(
            songname: element.title,
            artist: element.artist,
            duration: element.duration,
            id: element.id,
            songurl: element.uri));
      }

      for (var element in allSongs) {
        mostplayeddatabase.add(MostPlayed(
            songname: element.title,
            songurl: element.uri,
            duration: element.duration,
            artist: element.artist,
            count: 0,
            id: element.id));
      }
    }
    // if (!mounted) return;
    await Future.delayed(Duration(milliseconds: 500), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => SnakeNavbarScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF091227),
        body: Center(
            child: ClipRRect(
          child: Image.asset('assets/images/AS player Logo.jpg'),
        )));
  }
}
