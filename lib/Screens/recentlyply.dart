import 'package:as_player/Screens/home.dart';
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

import '../Model/recentlyplayed.dart';
import 'miniplayer.dart';
import 'minisecondplayer.dart';

class RecentlyPlayedScreen extends StatefulWidget {
  const RecentlyPlayedScreen({super.key});

  @override
  State<RecentlyPlayedScreen> createState() => _RecentlyPlayedScreenState();
}

class _RecentlyPlayedScreenState extends State<RecentlyPlayedScreen> {
  final List<RecentlyPlayed> recentlyplay = [];
  final box = RecentlyPlayedBox.getInstance();
  List<Audio> recentaudio = [];

  void initState() {
    final List<RecentlyPlayed> recentlyplayed =
        box.values.toList().reversed.toList();
    for (var item in recentlyplayed) {
      recentaudio.add(Audio.file(item.songurl.toString(),
          metas: Metas(
              artist: item.artist,
              title: item.songname,
              id: item.id.toString())));
    }
    super.initState();
  }

  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      floatingActionButton: Padding(
        padding:  EdgeInsets.only(left: width*0.065),
        child: MiniSecondPlayer(),
      ),
      // bottomSheet: MiniPlayerScreen(),
      appBar: AppBar(
        toolbarHeight: height * 0.08,
        backgroundColor: Color(0xFF000428),
        shadowColor: Color.fromARGB(255, 97, 132, 170),
        title: Text(
          "Recently Played ",
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
          // physics: NeverScrollableScrollPhysics(),
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
              //         "Recently Played ",
              //         style: GoogleFonts.lato(
              //             textStyle: Theme.of(context).textTheme.bodyLarge,
              //             fontSize: 25,
              //             color: Colors.white),
              //       ),
              //     ],
              //   ),
              // ),
              // StaggeredGridView.countBuilder(
              //   shrinkWrap: true,
              //   crossAxisCount: 2,
              //   itemCount: 10,
              //   itemBuilder: (context, index) => gcol(),
              //   staggeredTileBuilder: (index) =>
              //       StaggeredTile.count(1, index.isEven ? 2 : 1),
              //   mainAxisSpacing: 4.0,
              //   crossAxisSpacing: 4.0,
              // ),
              // SizedBox(height: height * 3),
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
              // SingleChildScrollView(
              //   child: Container(
              //     child: ListView.builder(
              //       itemCount: 10,
              //       // physics: const NeverScrollableScrollPhysics(),
              //       shrinkWrap: true,
              //       itemBuilder: (context, index) {
              //      return Padding(
              //        padding: const EdgeInsets.all(8.0),
              //        child: sqr(),
              //      );
              //     },),
              //   ),
              // )
              SizedBox(height: height * 0.05),
              ValueListenableBuilder<Box<RecentlyPlayed>>(
                valueListenable: box.listenable(),
                builder: ((context, Box<RecentlyPlayed> RecentDB, child) {
                  List<RecentlyPlayed> Recentplayed =
                      RecentDB.values.toList().reversed.toList();
                  return Recentplayed.isNotEmpty
                      ? GridView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: Recentplayed.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 5.0, crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return sqr(index, Recentplayed);
                          })
                      : Padding(
                          padding: EdgeInsets.only(top: height * 0.3),
                          child: Text(
                            "You Have't played any songs",
                            style: GoogleFonts.kanit(color: Colors.white),
                          ),
                        );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget sqr(index, Recentplayed) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            audioPlayer.open(Playlist(audios: recentaudio, startIndex: index),
                showNotification: true,
                headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                loopMode: LoopMode.playlist);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PlayingNow(),
            ));
          },
          child: Container(
            height: height * 0.17,
            width: width * 0.30,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(blurRadius: 15, blurStyle: BlurStyle.normal)
              ],
            ),
            child: QueryArtworkWidget(
              artworkFit: BoxFit.cover,
              id: Recentplayed[index].id!,
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
              Recentplayed[index].songname!,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
          child: TextScroll(
            Recentplayed[index].artist ?? "No Artist",
            style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.bodyLarge,
                fontSize: 12,
                color: const Color.fromARGB(255, 197, 190, 190)),
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