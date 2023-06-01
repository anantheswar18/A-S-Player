import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';

import '../Model/mostplayeddb.dart';

class MostPlayedProvider extends ChangeNotifier {
  final box = MostPlayedBox.getInstance();
  List<Audio> songs = [];
  List<MostPlayed> mostfinalsong = [];
// List<MostPlayed> mostplayedsongs =
//                         mostplayedDB.values.toList();
  void mostPlayedInit() {
    List<MostPlayed> songlist = box.values.toList();
    mostfinalsong.clear();
    int i = 0;
    for (var item in songlist) {
      if (item.count! > 3) {
        mostfinalsong.insert(i, item);
        i++;
      }
    }
    for (var items in mostfinalsong) {
      songs.add(Audio.file(items.songurl!,
          metas: Metas(
              title: items.songname,
              artist: items.artist,
              id: items.id.toString())));
    }
    notifyListeners();
  }
    

}
