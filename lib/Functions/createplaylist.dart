
import 'package:as_player/Model/playlistmodel.dart';
import 'package:as_player/Model/songmodel.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

CreatePlaylist(String name,BuildContext context) async {
  final boxnamePlaylist = PlaylistSongsBox.getInstance();
  List<Songs> SongPlaylist = [];
  List<PlaylistSongs> playlistnamedup = boxnamePlaylist.values.toList();
  bool isdup =
      playlistnamedup.where((element) => element.playlistName == name).isEmpty;
  if (name.isEmpty) {
    
    showTopSnackBar(Overlay.of(context), CustomSnackBar.error(message: "Name is Required"));
  } else if (isdup) {
    boxnamePlaylist
        .add(PlaylistSongs(playlistName: name, playlistsSongs: SongPlaylist));
  } else if (isdup == false) {
  showTopSnackBar(Overlay.of(context), CustomSnackBar.error(message: "The Playlist Named $name is already there"));
  } else {
    boxnamePlaylist
        .add(PlaylistSongs(playlistName: name, playlistsSongs: SongPlaylist));
  }
}

editPlaylist(String name, index) async {
  final playlistbox = PlaylistSongsBox.getInstance();
  List<PlaylistSongs> playlistsong = playlistbox.values.toList();
  final listbox = PlaylistSongsBox.getInstance();
  if (name.isEmpty) {
    return "This field is required ";
  } else {
    listbox.putAt(
        index,
        PlaylistSongs(
            playlistName: name,
            playlistsSongs: playlistsong[index].playlistsSongs));
  }
}

deletePlaylist(int index) {
  final delete = PlaylistSongsBox.getInstance();
  delete.deleteAt(index);
}
Container buildbutton(BuildContext context,String text){
 return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 6,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
}