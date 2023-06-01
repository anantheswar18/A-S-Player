import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';

import '../Model/recentlyplayed.dart';

class RecentlyProvider extends ChangeNotifier {
  List<Audio> recentaudio = [];
  final box = RecentlyPlayedBox.getInstance();
  // List<RecentlyPlayed> Recentplayed =
  //                     RecentDB.values.toList().reversed.toList();
  List<RecentlyPlayed> _Recentplayed = [];
  List<RecentlyPlayed> get Recentplayed => _Recentplayed;
  void recentlyInit() {
    // final List<RecentlyPlayed> recentlyplayed =
    //     box.values.toList().reversed.toList();
    _Recentplayed = box.values.toList().reversed.toList();
    for (var item in Recentplayed) {
      recentaudio.add(Audio.file(item.songurl.toString(),
          metas: Metas(
              artist: item.artist,
              title: item.songname,
              id: item.id.toString())));
    }
  }

  notifyListeners();
}
