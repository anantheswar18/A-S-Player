import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';

import '../Functions/dbfunctions.dart';
import '../Model/favorite.dart';
import '../Model/songmodel.dart';
import '../Screens/likedsonds.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Audio> favsong = [];
  final box = favoritesbox.getInstance();
  // List<favorites> favitemsongs =
  //                       favoritesdb.values.toList().reversed.toList();
    
 List<favorites> _favitemsongs = [];
List<favorites>get favitemsongs => _favitemsongs;
  void FavInit() {
   _favitemsongs = box.values.toList().reversed.toList();
   favsong.clear();
    for (var item in favitemsongs) {
      favsong.add(Audio.file(item.songurl.toString(),
          metas: Metas(
              artist: item.artist,
              title: item.songname,
              id: item.id.toString())));
    }
     notifyListeners();
  }

  addToFavProvider(int? id) async {
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

  notifyListeners();
}

deleteFavProvider(int index, BuildContext context) async {
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
    notifyListeners();
}
removeFavProvider(int? songid) async {
  final box = SongBox.getInstance();

  final boxremove = favoritesbox.getInstance();
  List<favorites> favsong = boxremove.values.toList();
  List<Songs> dbsongs = box.values.toList();
  int currentindex =
      favsong.indexWhere((element) => element.id == songid);
  await favoritesdb.deleteAt(currentindex);

    notifyListeners();
}
  
}
