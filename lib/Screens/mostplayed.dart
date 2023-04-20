import 'package:as_player/Screens/home.dart';
import 'package:as_player/Screens/minisecondplayer.dart';
import 'package:as_player/Screens/playingnow.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

import '../Model/mostplayeddb.dart';

class MostPlayedScreen extends StatefulWidget {
  const MostPlayedScreen({super.key});

  @override
  State<MostPlayedScreen> createState() => _MostPlayedState();
}

class _MostPlayedState extends State<MostPlayedScreen> {
  final box = MostPlayedBox.getInstance();
  List<Audio> songs = [];

  void initState() {
    List<MostPlayed> songlist = box.values.toList();
    int i = 0;
    for (var item in songlist) {
      if (item.count! > 5) {
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
    super.initState();
  }

  List<MostPlayed> mostfinalsong = [];
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      bottomSheet: MiniSecondPlayer(),
      appBar: AppBar(
        toolbarHeight: height * 0.08,
        backgroundColor: Color(0xFF000428),
        shadowColor: Color.fromARGB(255, 97, 132, 170),
        title: Text(
          "Most Played ",
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
        height: height,
        width: width,
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
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              // Padding(
              //   padding:
              //       EdgeInsets.only(top: height * 0.09, right: width * 0.4),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       IconButton(
              //           onPressed: () {
              //             Navigator.of(context).pop();
              //           },
              //           icon: const Icon(
              //             Icons.arrow_back_ios_new,
              //             size: 30,
              //             color: Colors.white,
              //           )),
              //       Text(
              //         "Most Played ",
              //         style: GoogleFonts.lato(
              //             textStyle: Theme.of(context).textTheme.bodyLarge,
              //             fontSize: 25,
              //             color: Colors.white),
              //       ),
              //     ],
              //   ),
              // ),
              // StaggeredGridView.countBuilder(
              //   crossAxisCount: 2,
              //   itemCount: 10,
              //   itemBuilder: (context, index) => gcol(index),
              //   staggeredTileBuilder: (index) =>
              //       StaggeredTile.count(1, index.isEven ? 2 : 1),
              //   mainAxisSpacing: 4.0,
              //   crossAxisSpacing: 4.0,
              // )
              // SizedBox(height: height * 0.03),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     sqr(),
              //     sqr()
              //   ],
              // ),
              //  SizedBox(height: height*0.03),
              //  Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     sqr(),
              //     sqr()
              //   ],
              // ),
              // SizedBox(height: height*0.03),
              //  Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     sqr(),
              //     sqr()
              //   ],
              // ),
              // SizedBox(height: height*0.03),
              //  Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     sqr(),
              //     sqr()
              //   ],
              // ),
              // SizedBox(height: height*0.03),
              //  Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     sqr(),
              //     sqr()
              //   ],
              // ),
              SizedBox(height: height * 0.05),
              ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder: (context, Box<MostPlayed> mostplayedDB, child) {
                    List<MostPlayed> mostplayedsongs =
                        mostplayedDB.values.toList();
                    return mostfinalsong.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.only(bottom: height * 0.1),
                            child: (GridView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: mostfinalsong.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 5.0, crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return sqr(index);
                              },
                            )),
                          )
                        : Padding(
                            padding: EdgeInsets.only(top: height * 0.3),
                            child: Text(
                              "Your most played songs will appear here!",
                              style: GoogleFonts.kanit(color: Colors.white),
                            ),
                          );
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget sqr(index) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            audioPlayer.open(Playlist(audios: songs, startIndex: index),
                headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                showNotification: true);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PlayingNow(),
            ));
          },
          child: Container(
            height: height * 0.15,
            width: width * 0.30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(blurRadius: 22, blurStyle: BlurStyle.solid)
              ],
            ),
            child: QueryArtworkWidget(
              id: mostfinalsong[index].id!,
              type: ArtworkType.AUDIO,
              keepOldArtwork: true,
              artworkBorder: BorderRadius.circular(10),
              nullArtworkWidget: ClipRRect(
                child: Image.asset(
                  "assets/images/AS player Logo png.png",
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: height * 0.01),
        Center(
          child: Padding(
            padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
            child: TextScroll(
              mostfinalsong[index].songname!,
            ),
          ),
        ),
        // Text(
        //   "Night Changes ",
        //   style: GoogleFonts.lato(
        //       textStyle: Theme.of(context).textTheme.bodyLarge,
        //       color: Colors.white),
        // ),
        Padding(
          padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
          child: TextScroll(
            mostfinalsong[index].artist!,
            style: TextStyle(fontSize: 10, color: Colors.white60),
          ),
        ),
      ],
    );
  }

  Widget gcol() {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/images/NightChanges.jpeg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
