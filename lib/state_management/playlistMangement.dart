

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import '../Model/playlistmodel.dart';
import '../Model/songmodel.dart';
import '../Screens/playlistinside.dart';

class PlaylistProvider extends ChangeNotifier {
  List<Audio> convertAudio = [];
  List<Songs> allsongsprovider=[];
  // List<PlaylistSongs> playlistsong =
  //                     playlistsongs.values.toList();
  //                 List<Songs>? playsong =
  //                     playlistsong[playindex].playlistsSong;
    List<PlaylistSongs> playlistsong=[];
  void playlistInit(playindex){
    convertAudio.clear();
    final playbox = PlaylistSongsBox.getInstance();
    playlistsong = playbox.values.toList();
    for (var item in playlistsong[playindex].playlistsSongs!) {
      convertAudio.add(Audio.file(item.songurl!,
          metas: Metas(
              title: item.songname,
              artist: item.artist,
              id: item.id.toString())));
    }
    notifyListeners();
  }
  void displaySongsProvider(index){
    final playbox = PlaylistSongsBox.getInstance();
    List<PlaylistSongs>playsongs = playbox.values.toList();
    allsongsprovider = playsongs[index].playlistsSongs!;
    notifyListeners();
  }
  
}