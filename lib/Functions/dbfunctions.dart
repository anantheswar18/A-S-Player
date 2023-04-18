import 'package:as_player/Model/playlistmodel.dart';
import 'package:as_player/Screens/home.dart';
import 'package:as_player/Screens/mostplayed.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../Model/favorite.dart';
import '../Model/mostplayeddb.dart';
import '../Model/recentlyplayed.dart';

late Box<favorites> favoritesdb;
openFavoritesDB() async {
  favoritesdb = await Hive.openBox<favorites>(boxname3);
}

late Box<PlaylistSongs> playlistDb;
openplaylistDb() async {
  playlistDb = await Hive.openBox<PlaylistSongs>(boxnamePlaylist);
}

late Box<RecentlyPlayed> recentlyplayedDB;
openrecentlyplayedDB() async {
  recentlyplayedDB = await Hive.openBox<RecentlyPlayed>(boxnameRecently);
}

late Box<MostPlayed> mostplayeddatabase;
openmostplayeddatabase() async {
  mostplayeddatabase = await Hive.openBox<MostPlayed>('MostPlayed');
}

updatingRecentlyPlayed(RecentlyPlayed value) {
  List<RecentlyPlayed> list = recentlyplayedDB.values.toList();
  bool isAlready =
      list.where((element) => element.songname == value.songname).isEmpty;
  if (isAlready == true) {
    recentlyplayedDB.add(value);
  } else {
    int index =
        list.indexWhere((element) => element.songname == value.songname);
    recentlyplayedDB.deleteAt(index);
    recentlyplayedDB.add(value);
  }
}

frontrecent() {
  final List<RecentlyPlayed> recentlyplayed = boxrecent.values.toList();
  for (var item in recentlyplayed) {
    recentaudiohome.add(Audio.file(item.songurl.toString(),
        metas: Metas(
            artist: item.artist,
            title: item.songname,
            id: item.id.toString())));
  }
}

updatingMostPlayedSongs(MostPlayed value, int index) {
  final box = MostPlayedBox.getInstance();
  List<MostPlayed> lines = box.values.toList();
  bool isAlready =
      lines.where((element) => element.songname == value.songname).isEmpty;
  if (isAlready == true) {
    box.add(value);
  } else {
    int index =
        lines.indexWhere((element) => element.songname == value.songname);
    box.deleteAt(index);
    box.put(index, value);
  }
  int? count = value.count;
  value.count = count! + 1;
}

frontmost() {
  List<MostPlayed> songlist = mostbox.values.toList();
  int i = 0;
  for (var item in songlist) {
    if (item.count! > 5) {
      mostfinalsonghome.insert(i, item);
      i++;
    }
  }
  for (var items in mostfinalsonghome) {
    songshome.add(Audio.file(items.songurl!,
        metas: Metas(
            title: items.songname,
            artist: items.artist,
            id: items.id.toString())));
  }
}
