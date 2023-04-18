import 'dart:developer';

import 'package:as_player/Functions/addToFavorite.dart';
import 'package:as_player/Model/songmodel.dart';
import 'package:as_player/Screens/home.dart';
import 'package:as_player/Screens/playingnow.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

import '../Model/favorite.dart';

class LikedSongs extends StatefulWidget {
  const LikedSongs({super.key});

  @override
  State<LikedSongs> createState() => _LikedSongsState();
}

class _LikedSongsState extends State<LikedSongs> {
  var size, height, width;
  final _audioPlayer = AssetsAudioPlayer.withId('0');
  final box = favoritesbox.getInstance();
  List<Audio> favsong = [];
  List<Audio> allsongs = [];

  void initState() {
    final List<favorites> favitemsongs = box.values.toList().reversed.toList();
    for (var item in favitemsongs) {
      favsong.add(Audio.file(item.songurl.toString(),
          metas: Metas(
              artist: item.artist,
              title: item.songname,
              id: item.id.toString())));
    }
    setState(() {
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
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
          style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.bodyLarge,
              fontSize: 25,
              color: Colors.white),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 23, 35, 63),
                        borderRadius: BorderRadius.circular(50)),
                    height: height * 0.07,
                    width: width * 0.48,
                    child: Row(
                      children: [
                        SizedBox(
                          width: width * 0.01,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.shuffle,
                              size: 30,
                              color: Colors.white,
                            )),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Text(
                          "Shuffle All ",
                          style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.bodyLarge,
                              fontSize: 23,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 23, 35, 63),
                        borderRadius: BorderRadius.circular(50)),
                    height: height * 0.07,
                    width: width * 0.45,
                    child: Row(
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PlayingNow(),
                              ));
                            },
                            icon: const Icon(
                              Icons.play_circle_fill,
                              size: 40,
                              color: Color.fromARGB(255, 28, 37, 77),
                            )),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Text(
                          "Play",
                          style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.bodyLarge,
                              fontSize: 25,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ValueListenableBuilder<Box<favorites>>(
                  valueListenable: box.listenable(),
                  builder: (context, Box<favorites> favoritesdb, child) {
                    // log("hey anantheswara ");
                    List<favorites> favitemsongs =
                        favoritesdb.values.toList().reversed.toList();
                    return favitemsongs.isNotEmpty
                        ? Container(
                            height: height,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => likedList(
                                  favitemsongs[index].id,
                                  favitemsongs[index].songname,
                                  favitemsongs[index].artist,
                                  index,
                                  context,
                                  favoritesdb),
                              itemCount: favitemsongs.length,
                            ),
                          )
                        : Center(child: Text("You haven't liked any Songs"));
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget likedList(
      favitemsongs, songname, artist, index, context, favoritesdb) {
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
              _audioPlayer.open(Playlist(audios: favsong, startIndex: index),
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
              intervalSpaces: 10,
              velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
            ),
            // Text(
            //   songname,
            //   style: GoogleFonts.aBeeZee(
            //       textStyle: Theme.of(context).textTheme.bodyLarge,
            //       fontSize: 15,
            //       color: Colors.white),
            // ),
            subtitle: Text(
              artist ?? "<<Unknown>>",
              style: TextStyle(color: Colors.grey),
            ),
            trailing: IconButton(
                onPressed: ()  {
                  deleteFav(index, context);
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
