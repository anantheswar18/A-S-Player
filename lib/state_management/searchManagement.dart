import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';

import '../Model/songmodel.dart';

class SearchProvider extends ChangeNotifier {
  final box = SongBox.getInstance();
  late List<Songs> dbsongs;
  List<Audio> allSongs = [];
    late List<Songs> another = List.from(dbsongs);

  void searchInit() {
    dbsongs = box.values.toList();
    for (var item in dbsongs) {
      allSongs.add(Audio.file(item.songurl!,
          metas: Metas(
              title: item.songname,
              artist: item.artist,
              id: item.id.toString())));
    }
  }

  void changeListProvider(String value) {
    
      another = dbsongs
          .where((element) =>
              element.songname!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      allSongs.clear();
      for (var item in another) {
        allSongs.add(Audio.file(item.songurl.toString(),
            metas: Metas(
                artist: item.artist,
                title: item.songname,
                id: item.id.toString())));
      }
      notifyListeners();
   
  }
}
