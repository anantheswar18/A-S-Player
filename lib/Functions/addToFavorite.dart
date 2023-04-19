// import 'package:as_player/Model/favorite.dart';
import 'package:as_player/Functions/dbfunctions.dart';
import 'package:as_player/Model/songmodel.dart';
import 'package:as_player/Screens/likedsonds.dart';
import 'package:as_player/Screens/mylibrary.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:as_player/Screens/playingnow.dart';
import 'package:as_player/Model/favorite.dart';

addToFav(int? id) async {
  final box = SongBox.getInstance();

  List<Songs> dbsongs = box.values.toList();

  List<favorites> favoritessongs = [];
  favoritessongs = favoritesdb.values.toList();
  bool isalready = favoritessongs
      .any((element) => element.id == id);
    
  if (!isalready) {
    Songs song =dbsongs.firstWhere((element) => element.id == id);
    favoritesdb.add(favorites(
        songname: song.songname,
        artist: song.artist,
        duration: song.duration,
        songurl: song.songurl,
        id: song.id));
  } else {
    
    int currentindex =
        favoritessongs.indexWhere((element) => element.id == id);
    await favoritesdb.deleteAt(currentindex);
  }
}

 removeFav(int? songid) async {
  final box = SongBox.getInstance();

  final boxremove = favoritesbox.getInstance();
  List<favorites> favsong = boxremove.values.toList();
  List<Songs> dbsongs = box.values.toList();
  int currentindex =
      favsong.indexWhere((element) => element.id == songid);
  await favoritesdb.deleteAt(currentindex);
}

deleteFav(int index, BuildContext context) async {
  await favoritesdb.deleteAt(favoritesdb.length - index - 1);
  // Navigator.pushReplacement(
  //     context,
  //     PageRouteBuilder(
  //         pageBuilder: (context, animation, secondaryAnimation) => LikedSongs(),
  //         transitionDuration: Duration.zero,
  //         reverseTransitionDuration: Duration.zero));
  // refresh();
  //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LikedSongs(),));
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) => LikedSongs(),
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
  );
}

bool checkFavStatus(int? songid, BuildContext) {
  final box = SongBox.getInstance();

  List<favorites> favoritessongs = [];
  List<Songs> dbsongs = box.values.toList();
  Songs song = dbsongs.firstWhere((element) => element.id == songid);
  favorites value = favorites(
      songname: song.songname,
      artist: song.artist,
      duration: song.duration,
      songurl: song.songurl,
      id: song.id);

  favoritessongs = favoritesdb.values.toList();
  bool isAlreadyThere = favoritessongs
      .where((element) => element.id == value.id)
      .isEmpty;
  return isAlreadyThere ? true : false;
}

refresh() {
  List<Audio> favsong = [];
  final box = favoritesbox.getInstance();

  //  final favsongsdb = Hive.box<favorites>("favsongs").values.toList();
  //   for (var item in favsongsdb) {
  //     allsongs.add(Audio.file(item.songurl.toString(),
  //         metas: Metas(
  //             artist: item.artist,
  //             title: item.songname,
  //             id: item.id.toString())));
  //   }
  final List<favorites> favitemsongs = box.values.toList().reversed.toList();
  for (var item in favitemsongs) {
    favsong.add(Audio.file(item.songurl.toString(),
        metas: Metas(
            artist: item.artist,
            title: item.songname,
            id: item.id.toString())));
  }
}
