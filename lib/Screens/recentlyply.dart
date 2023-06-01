import 'package:as_player/Screens/home.dart';
import 'package:as_player/Screens/playingnow.dart';
import 'package:as_player/state_management/recentlyManagement.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:text_scroll/text_scroll.dart';

import '../Model/recentlyplayed.dart';
import 'minisecondplayer.dart';

class RecentlyPlayedScreen extends StatelessWidget {
   RecentlyPlayedScreen({super.key});

  
  final List<RecentlyPlayed> recentlyplay = [];
  // final box = RecentlyPlayedBox.getInstance();
  // List<Audio> recentaudio = [];

  // void initState() {
  //   final List<RecentlyPlayed> recentlyplayed =
  //       box.values.toList().reversed.toList();
  //   for (var item in recentlyplayed) {
  //     recentaudio.add(Audio.file(item.songurl.toString(),
  //         metas: Metas(
  //             artist: item.artist,
  //             title: item.songname,
  //             id: item.id.toString())));
  //   }
  //   super.initState();
  // }

  var size, height, width;
  @override
  Widget build(BuildContext context) {
    Provider.of<RecentlyProvider>(context).recentlyInit();
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      bottomSheet: MiniSecondPlayer(),
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
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              
              SizedBox(height: height * 0.05),
              
                  
                   Consumer<RecentlyProvider>(
                     builder:(context, value, child) =>  value.Recentplayed.isNotEmpty
                        ? Padding(
                          padding:  EdgeInsets.only(bottom:height*0.1 ),
                          child: GridView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: value.Recentplayed.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 5.0, crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return sqr(index, value.Recentplayed,context);
                              }),
                        )
                        : Padding(
                            padding: EdgeInsets.only(top: height * 0.3),
                            child: Text(
                              "You Have't played any songs",
                              style: GoogleFonts.kanit(color: Colors.white),
                            ),
                          ),
                   ),
               
            ],
          ),
        ),
      ),
    );
  }

  Widget sqr(index, Recentplayed,context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            audioPlayer.open(Playlist(audios:Provider.of<RecentlyProvider>(context,listen: false).recentaudio, startIndex: index),
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
              style: TextStyle(color: Colors.white),
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
