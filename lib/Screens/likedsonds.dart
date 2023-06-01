import 'dart:developer';

import 'package:as_player/Functions/addToFavorite.dart';
import 'package:as_player/Model/songmodel.dart';
import 'package:as_player/Screens/home.dart';
import 'package:as_player/Screens/minisecondplayer.dart';
import 'package:as_player/Screens/playingnow.dart';
import 'package:as_player/state_management/favoriteMangement.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:text_scroll/text_scroll.dart';

import '../Model/favorite.dart';

class LikedSongs extends StatelessWidget {
  LikedSongs({super.key});

  var size, height, width;
  final _audioPlayer = AssetsAudioPlayer.withId('0');
  // final box = favoritesbox.getInstance();
  // List<Audio> favsong = [];
  List<Audio> allsongs = [];

  // void initState() {
  //   final List<favorites> favitemsongs = box.values.toList().reversed.toList();
  //   for (var item in favitemsongs) {
  //     favsong.add(Audio.file(item.songurl.toString(),
  //         metas: Metas(
  //             artist: item.artist,
  //             title: item.songname,
  //             id: item.id.toString())));
  //   }
  //   setState(() {
  //     super.initState();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Provider.of<FavoriteProvider>(context).FavInit();
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.08,
        backgroundColor: Color(0xFF000428),
        // shadowColor: Color.fromARGB(255, 97, 132, 170),
        title: Text(
          "Liked Songs ",
          // style: GoogleFonts.lato(
          //     textStyle: Theme.of(context).textTheme.bodyLarge,
          //     fontSize: 25,
          //     color: Colors.white),
          style: TextStyle(
                  fontSize: 28,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 30,
              color: Colors.white,
            )),
      ),
      body: Container(
        // height: height,
        height: double.infinity,
        // width: width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF000428),
              Color.fromARGB(255, 97, 132, 170),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height * 0.01),

              // log("hey anantheswara ");
              // List<favorites> favitemsongs =
              //     favoritesdb.values.toList().reversed.toList();
              Consumer<FavoriteProvider>(
                builder: (context, value, child) =>
                    Provider.of<FavoriteProvider>(context)
                            .favitemsongs
                            .isNotEmpty
                        ? Container(
                            height: height,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => likedList(
                                value.favitemsongs[index].id,
                                value.favitemsongs[index].songname,
                                value.favitemsongs[index].artist,
                                index,
                                context,
                              ),
                              itemCount: value.favitemsongs.length,
                            ),
                          )
                        : SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding:  EdgeInsets.only(top:height/3 ),
                            child: Column(
                              children: [
                                // Image.asset("assets/gif/animation_500_libbj07p.gif"),
                                Text(
                                  "You haven't liked any Songs",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: MiniSecondPlayer(),
    );
  }

  Widget likedList(
    favitemsongs,
    songname,
    artist,
    index,
    context,
  ) {
    return Padding(
      padding: EdgeInsets.only(
          top: height * 0.02, left: width * 0.05, right: width * 0.05),
      child: Container(
          height: height * 0.10,
          decoration: BoxDecoration(
              color: const Color(0xFF091227),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 15,
                )
              ]),
          child: ListTile(
            onTap: () {
              refresh();
              _audioPlayer.open(
                  Playlist(
                      audios: Provider.of<FavoriteProvider>(context,listen: false).favsong,
                      startIndex: index),
                  showNotification: true,
                  headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                  loopMode: LoopMode.playlist);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PlayingNow(),
              ));
            },
            leading: QueryArtworkWidget(
              keepOldArtwork: true,
              artworkBorder: BorderRadius.circular(50),
              id: favitemsongs,
              type: ArtworkType.AUDIO,
              nullArtworkWidget: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset('assets/images/AS player Logo png.png'),
              ),
            ),
            title: TextScroll(
              songname,
              style: TextStyle(color: Colors.white),
              intervalSpaces: 10,
              velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
            ),
            subtitle: Text(
              artist ?? "<<Unknown>>",
              style: TextStyle(color: Colors.grey),
            ),
            trailing: IconButton(
                onPressed: () {
                  // deleteFav(index, context);
                  Provider.of<FavoriteProvider>(context,listen: false).deleteFavProvider(index, context);
                  //  refresh();

                  // removeFav(index);
                  // favoritesdb.deleteAt(favoritesdb.length - index -1);
                  // removeFav(index);
                  //  refresh();
                  //  Navigator.pop(context);
                  // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LikedSongs(),));
                  // setState(() {
                  //   refresh();
                  // });
                  // refresh();
                },
                icon: Icon(
                  Icons.favorite_rounded,
                  color: Colors.red,
                )),
          )),
    );
  }

  refresh() {
    final favsongsdb = Hive.box<favorites>(boxname3).values.toList();
    for (var item in favsongsdb) {
      allsongs.add(Audio.file(item.songurl.toString(),
          metas: Metas(
              artist: item.artist,
              title: item.songname,
              id: item.id.toString())));
    }
    // final List<favorites> favitemsongs = box.values.toList().reversed.toList();
    // for (var item in favitemsongs) {
    //   favsong.add(Audio.file(item.songurl.toString(),
    //       metas: Metas(
    //           artist: item.artist,
    //           title: item.songname,
    //           id: item.id.toString())));
    // }
  }
}
