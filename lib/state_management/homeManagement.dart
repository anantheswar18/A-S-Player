import 'package:as_player/Functions/dbfunctions.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';

import '../Model/songmodel.dart';
import '../Screens/home.dart';

class HomeProvider extends ChangeNotifier {
  List<Audio> covertAudios = [];
  static final songbox = SongBox.getInstance();


  void homeProviderInit() {
    List<Songs> dbsongs = songbox.values.toList();
    for (var item in dbsongs) {
      covertAudios.add(Audio.file(item.songurl!,
          metas: Metas(
            title: item.songname,
            artist: item.artist,
            id: item.id.toString(),
          )));
    }
    frontmost();
    frontrecent();
  }
  static final songbox1 = SongBox.getInstance();
  List<Songs>allDbsongs = songbox1.values.toList();
}
