import 'package:as_player/Model/songmodel.dart';
import 'package:as_player/Screens/playingnow.dart';
import 'package:as_player/state_management/searchManagement.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:text_scroll/text_scroll.dart';

import 'home.dart';

ValueNotifier<bool> ScrollNotifier = ValueNotifier(true);

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  @override

  // final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();

  // final box = SongBox.getInstance();
  late List<Songs> dbsongs;
  var size, height, width;
  final _searchController = TextEditingController();
  // List<Audio> allSongs = [];
  // void initState() {
  //   dbsongs = box.values.toList();
  //   for (var item in dbsongs) {
  //     allSongs.add(Audio.file(item.songurl!,
  //         metas: Metas(
  //             title: item.songname,
  //             artist: item.artist,
  //             id: item.id.toString())));
  //   }
  //   super.initState();
  // }

  // late List<Songs> another = List.from(dbsongs);

  @override
  Widget build(BuildContext context) {
    Provider.of<SearchProvider>(context).searchInit();
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: ScrollNotifier,
          builder: (context, index, _) {
            return NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                final ScrollDirection direction = notification.direction;
                // print(direction);
                if (direction == ScrollDirection.reverse) {
                  ScrollNotifier.value = false;
                } else if (direction == ScrollDirection.forward) {
                  ScrollNotifier.value = true;
                }

                return true;
              },
              child: Container(
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
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.07, left: width * 0.1),
                        child: Row(
                          children: [
                            Text(
                              "Se",
                              style: GoogleFonts.oswald(
                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge,
                                fontSize: 40,
                                 fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 97, 132, 170),
                              ),
                            ),
                            Text(
                              "ar",
                              style: GoogleFonts.oswald(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyLarge,
                                  fontSize: 40,
                                   fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            Text(
                              "ch",
                              style: GoogleFonts.oswald(
                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge,
                                fontSize: 40,
                                 fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 97, 132, 170),
                              ),
                            ),
                          ],
                        ),
                      ),
                      searchBox(context),
                      Padding(
                        padding: EdgeInsets.only(bottom: height * 0.10),
                        child: SizedBox(
                            height: height,
                            child: Consumer<SearchProvider>(
                              builder: (context, value, child) =>
                                  value.another.isEmpty
                                      ? Image.asset(
                                          "assets/gif/bubble-gum-error-404.gif")
                                      : ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: value.another.length,
                                          itemBuilder: (context, index) {
                                            return con(index, context);
                                          },
                                        ),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget searchBox(context) {
    return Padding(
      padding: EdgeInsets.only(
          top: height * 0.06, left: width * 0.090, right: width * 0.090),
      child: TextFormField(
        onTapOutside: (event) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        onChanged: (value) =>
            Provider.of<SearchProvider>(context, listen: false)
                .changeListProvider(value),
        autofocus: false,
        controller: _searchController,
        cursorColor: Colors.grey,
        style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.blueGrey.shade300,
          ),
          suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.blueGrey.shade300,
              ),
              onPressed: () {
                clearText(context);
              }),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(60)),
          hintText: 'search',
          hintStyle: const TextStyle(color: Colors.grey),
        ),
        // onChanged: (value) {
        //   _searchStudent(value);
        // },
      ),
    );
  }

  void clearText(context) {
    _searchController.clear();
  }

  void _onDismised() {}
  Widget con(index, context) {
    return Padding(
      padding: EdgeInsets.only(
          top: height * 0.02, left: width * 0.05, right: width * 0.05),
      child: SingleChildScrollView(
        child: Container(
            height: height * 0.10,
            decoration: BoxDecoration(
                color: const Color(0xFF091227),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 15,
                    // spreadRadius: 2,
                  )
                ]),
            child: ListTile(
              onTap: () {
                PlayingNow.nowplayingindex.value = index;
                audioPlayer.open(
                    Playlist(
                        audios:
                            Provider.of<SearchProvider>(context, listen: false)
                                .allSongs,
                        startIndex: index),
                    showNotification: true,
                    headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                    loopMode: LoopMode.playlist);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PlayingNow(),
                ));
              },
              leading: QueryArtworkWidget(
                id: Provider.of<SearchProvider>(context).another[index].id!,
                type: ArtworkType.AUDIO,
                keepOldArtwork: true,
                artworkBorder: BorderRadius.circular(10),
                nullArtworkWidget: ClipRRect(
                  child: Image.asset('assets/images/AS player Logo png.png'),
                ),
              ),
              title: TextScroll(
                Provider.of<SearchProvider>(context).another[index].songname!,
               style: TextStyle(
                  // fontSize: 28,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
                velocity: Velocity(pixelsPerSecond: Offset(100, 0)),
                intervalSpaces: 50,
              ),
              subtitle: TextScroll(
                Provider.of<SearchProvider>(context).another[index].artist ??
                    "No Artist",
                // overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey),
              ),
            )),
      ),
    );
  }

  // void changeList(String value) {

  //     another = dbsongs
  //         .where((element) =>
  //             element.songname!.toLowerCase().contains(value.toLowerCase()))
  //         .toList();
  //     allSongs.clear();
  //     for (var item in another) {
  //       allSongs.add(Audio.file(item.songurl.toString(),
  //           metas: Metas(
  //               artist: item.artist,
  //               title: item.songname,
  //               id: item.id.toString())));
  //     }

  // }
}
