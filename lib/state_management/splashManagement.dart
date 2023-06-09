

import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Functions/dbfunctions.dart';
import '../Model/mostplayeddb.dart';
import '../Model/songmodel.dart';
import '../Screens/snakenavigation.dart';

class SplashProvider extends ChangeNotifier {

   final audioQuerysplash = new OnAudioQuery();
  final box = SongBox.getInstance();
    List<SongModel> fetchSongs = [];
  List<SongModel> allSongs = [];

  requestpermission(BuildContext context) async {
    // Permission.storage.request();

    bool permissionstatus = await audioQuerysplash.permissionsStatus();
    if (!permissionstatus) {
      await audioQuerysplash.permissionsRequest();

      fetchSongs = await audioQuerysplash.querySongs();
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
  
  
}