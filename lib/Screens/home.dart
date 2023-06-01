import 'dart:developer';
import 'dart:io';

import 'package:as_player/Functions/dbfunctions.dart';
import 'package:as_player/Model/favorite.dart';
import 'package:as_player/Model/mostplayeddb.dart';
import 'package:as_player/Model/recentlyplayed.dart';
import 'package:as_player/Model/songmodel.dart';
import 'package:as_player/widgets/Cards.dart';
import 'package:as_player/Screens/mostplayed.dart';
import 'package:as_player/Screens/playingnow.dart';
import 'package:as_player/Screens/playlist.dart';
import 'package:as_player/Screens/playlistinside.dart';
import 'package:as_player/Screens/recentlyply.dart';
import 'package:as_player/state_management/favoriteMangement.dart';
import 'package:as_player/state_management/homeManagement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:as_player/Functions/addToFavorite.dart';
import 'package:provider/provider.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../Functions/createplaylist.dart';
import '../Model/playlistmodel.dart';

late List<PlaylistSongs> playlistsong = playlistbox.values.toList();
List<Audio> recentaudiohome = [];
final boxrecent = RecentlyPlayedBox.getInstance();
final playlistbox = PlaylistSongsBox.getInstance();
final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
final mostbox = MostPlayedBox.getInstance();
final List<MostPlayed> mostplayedsong = mostbox.values.toList();
List<MostPlayed> mostfinalsonghome = [];
List<Audio> songshome = [];

class HomePage extends StatelessWidget {
  HomePage({super.key});

// static final alldbsongs = SongBox.getInstance();
// List<Songs> allDbsongs = alldbsongs.values.toList();
// final songbox = SongBox.getInstance();
  static final box3 = favoritesbox.getInstance();
  List<favorites> favdb = box3.values.toList();
  bool istapped = false;

  final List<PlaylistModel> playlistsonglist = [];

  @override
  var size, height, width;
  // bool _isChanged = false;
  // List<Audio> covertAudios = [];

  @override
  Widget build(BuildContext context) {
    Provider.of<HomeProvider>(context).homeProviderInit();
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      // bottomSheet: MiniPlayerScreen(),

      // extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: height * 0.08,
        backgroundColor: Color(0xFF000428),
        shadowColor: Color.fromARGB(255, 97, 132, 170),
        leadingWidth: 80,
        leading: IconButton(
            // iconSize: 55,
            onPressed: () {},
            icon: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/AS player Logo.jpg',
                  width: width * 0.100,
                  height: height * 0.10,
                ))),
        title: Row(
          children: [
            Text(
              "AS",
              style: GoogleFonts.oswald(
                textStyle: Theme.of(context).textTheme.bodyLarge,
                fontSize: 35,
                 fontWeight: FontWeight.w800,
                color: Color.fromARGB(255, 97, 132, 170),
              ),
            ),
            Text(
              " Play",
              style: GoogleFonts.oswald(
                  textStyle: Theme.of(context).textTheme.bodyLarge,
                  fontSize: 35,
                   fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            Text(
              "er",
              style: GoogleFonts.oswald(
                textStyle: Theme.of(context).textTheme.bodyLarge,
                fontSize: 35,
                 fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 97, 132, 170),
              ),
            ),
          ],
        ),
      ),

      body: Stack(children: [
        Container(
          height: height,
          // height: double.infinity,
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
                SizedBox(height: height * 0.15),
                CardsHome(),
                SizedBox(height: height * 0.02),
                SizedBox(
                  // height: height / 3,
                  width: width,
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.01),
                      // navMost(),
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.01, right: width * 0.5),
                        child: Text(
                          "All Songs  ",
                          style: GoogleFonts.lato(
                              textStyle: Theme.of(context).textTheme.bodyLarge,
                              fontSize: 30,
                              color: Colors.white),
                        ),
                      ),
                      // SizedBox(height: height*0.02,)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.2),
                  child: SizedBox(
                    child:
                        // List<Songs> allDbsongs = allsongbox.values.toList();
                        Container(
                      // height: height,
                      // height: double.infinity,
                      child: Consumer<HomeProvider>(
                        builder: (context, value, child) => ListView.builder(
                          padding: EdgeInsets.all(8),
                          // controller: _controller,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: value.allDbsongs.length,
                          itemBuilder: ((context, songindex) {
                            return con(
                                value.allDbsongs[songindex].songname,
                                value.allDbsongs[songindex].artist ?? 'unknown',
                                songindex,
                                QueryArtworkWidget(
                                  keepOldArtwork: true,
                                  id: value.allDbsongs[songindex].id!,
                                  type: ArtworkType.AUDIO,
                                  nullArtworkWidget: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      'assets/images/AS player Logo.jpg',
                                    ),
                                  ),
                                ),
                                songindex,
                                context);
                          }),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
      // bottomSheet: MiniPlayerScreen(),
    );
  }

  Widget sqr(index, context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            audioPlayer.open(
              Playlist(audios: songshome, startIndex: index),
              headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
              showNotification: true,
            );
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PlayingNow(),
            ));
          },
          child: Container(
            height: height * 0.17,
            width: width * 0.30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 22,
                  blurStyle: BlurStyle.normal,
                  color: const Color(0xFF091227),
                )
              ],
            ),
            child: QueryArtworkWidget(
              artworkFit: BoxFit.cover,
              id: mostfinalsonghome[index].id!,
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
            padding: EdgeInsets.only(left: width * 0.08, right: width * 0.05),
            child: TextScroll(
              mostfinalsonghome[index].songname!,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: width * 0.03, right: width * 0.07),
          child: TextScroll(
            mostfinalsonghome[index].artist!,
            style: TextStyle(fontSize: 10, color: Colors.white60),
          ),
        ),
      ],
    );
  }

  Widget sqr2(index, Recentplayed, context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            audioPlayer.open(
                Playlist(audios: recentaudiohome, startIndex: index),
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
                BoxShadow(
                  blurRadius: 15,
                  blurStyle: BlurStyle.normal,
                  color: const Color(0xFF091227),
                )
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
              // style: TextStyle(color: Colors.white),
              style: TextStyle(
                  // fontSize: 28,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: width * 0.05, right: width * 0.01),
          child: TextScroll(
            Recentplayed[index].artist ?? "No Artist",
            // style: GoogleFonts.lato(
            //     textStyle: Theme.of(context).textTheme.bodyLarge,
            //     fontSize: 12,
            //     color: const Color.fromARGB(255, 197, 190, 190)),
            style: TextStyle(
                fontSize: 12,
                fontFamily: "Inter",
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget navRecently(context) {
    return SizedBox(
      width: width * 0.90,
      height: height * 0.06,
      child: ElevatedButton.icon(
        onPressed: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context) => const RecentlyPlayedScreen(),
          // ));
          Navigator.push(
              context,
              CupertinoPageRoute(
                fullscreenDialog: true,
                // allowSnapshotting: true,
                builder: (context) => RecentlyPlayedScreen(),
              ));
        },
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 30,
        ),
        label: Text(""),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            backgroundColor: Color.fromARGB(255, 8, 29, 48)),
      ),
    );
  }

  Widget navMost(context) {
    return SizedBox(
      width: width * 0.90,
      height: height * 0.06,
      child: ElevatedButton.icon(
        onPressed: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => const MostPlayedScreen()));
          Navigator.push(
              context,
              CupertinoPageRoute(
                fullscreenDialog: true,
                // allowSnapshotting: true,
                builder: (context) => MostPlayedScreen(),
              ));
        },
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 30,
        ),
        label: Text(""),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            backgroundColor: Color.fromARGB(255, 19, 45, 68)),
      ),
    );
  }

  Widget con(String? musicname, String? subname, index, coverImage,
      int songindex, context) {
    RecentlyPlayed Rsongs;
    Songs songs = Provider.of<HomeProvider>(context).allDbsongs[songindex];
    MostPlayed mostsong = mostplayedsong[songindex];
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
              PlayingNow.nowplayingindex.value = songindex;
              audioPlayer.open(
                  Playlist(
                      audios: Provider.of<HomeProvider>(context, listen: false)
                          .covertAudios,
                      startIndex: songindex),
                  headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                  showNotification: true,
                  loopMode: LoopMode.playlist);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PlayingNow(),
              ));
              Rsongs = RecentlyPlayed(
                  id: songs.id,
                  index: songindex,
                  artist: songs.artist,
                  duration: songs.duration,
                  songname: songs.songname,
                  songurl: songs.songurl);
              updatingRecentlyPlayed(Rsongs);
              updatingMostPlayedSongs(mostsong, index);
            },
            leading: coverImage,
            title: TextScroll(
              musicname!,
              // style: TextStyle(color: Colors.white),
              style: TextStyle(
                  // fontSize: 28,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              intervalSpaces: 10,
              velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
            ),
            subtitle: Text(
              subname!,
              style: TextStyle(color: Colors.grey),
            ),
            trailing: PopupMenuButton(
              elevation: 30,
              color: Colors.white,
              // splashRadius: 10,
              // color: Color.fromARGB(255, 26, 23, 23),
              itemBuilder: (context) => [
                PopupMenuItem(
                    value: 1,
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        ShowBottomSheetCreate(songindex, context);
                        // Navigator.of(context).pop();
                      },
                      leading: Icon(Icons.playlist_add),
                      title: Text(
                        "Add To Playlist",
                        style: TextStyle(fontSize: 15),
                      ),
                    )),
                PopupMenuItem(
                  value: 2,
                  child: ListTile(
                    leading: (checkFavStatus(songs.id, BuildContext))
                        ? Icon(Icons.favorite_border_outlined)
                        : Icon(
                            Icons.favorite_rounded,
                            color: Colors.red,
                          ),
                    title: Text(
                        (checkFavStatus(songs.id, BuildContext))
                            ? "Add To favorite"
                            : " Remove ",
                        style: TextStyle(fontSize: 15)),
                  ),
                  onTap: () {
                    if (checkFavStatus(songs.id, BuildContext)) {
                      Provider.of<FavoriteProvider>(context, listen: false)
                          .addToFavProvider(songs.id);
                      // addToFav(songs.id);
                      final snackbar = SnackBar(
                        content: Text(
                          "Added to Favorites",
                          style: GoogleFonts.kanit(
                              color: Colors.white, fontSize: 15),
                        ),
                        backgroundColor: Colors.black12,
                        dismissDirection: DismissDirection.down,
                        elevation: 12,
                        padding: EdgeInsets.only(top: 10, bottom: 15),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    } else if (!checkFavStatus(songs.id, BuildContext)) {
                      // removeFav(songs.id);
                      Provider.of<FavoriteProvider>(context, listen: false)
                          .removeFavProvider(songs.id);
                      final snackbar2 = SnackBar(
                        content: Text(
                          "Removed from Favorites",
                          style: GoogleFonts.kanit(
                              color: Colors.white, fontSize: 15),
                        ),
                        backgroundColor: Colors.black12,
                        dismissDirection: DismissDirection.down,
                        elevation: 12,
                        padding: EdgeInsets.only(top: 10, bottom: 15),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar2);
                    }
                  },
                )
              ],
              // onSelected: (value) {
              //   if (value == 1) {
              //     // Navigator.of(context).pop();
              //     // ShowBottomSheetCreate(songindex);
              //   } else if (value == 2) {
              //     setState(() {
              //       _isChanged = !_isChanged;
              //     });
              //   }
              // },
            ),
          )),
    );
  }

  Future<void> ShowBottomSheetCreate(songindex, BuildContext context) async {
    return showModalBottomSheet(
      backgroundColor: Color.fromARGB(255, 41, 44, 68),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60), topRight: Radius.circular(60))),
      context: context,
      builder: (context) {
        return Container(
          height: height * 0.7,
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  thickness: 2,
                  height: 5,
                  endIndent: 122,
                  indent: 122,
                  color: Colors.grey,
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.01),
                  child: Text(
                    "Add To Playlist",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                    onPressed: () {
                      PopUpPlaylistCreate(context);
                    },
                    child: Text("Create Playlist ")),

                // That list in the bottom sheet

                SizedBox(
                  height: height * 0.01,
                ),
                ValueListenableBuilder<Box<PlaylistSongs>>(
                    valueListenable: playlistbox.listenable(),
                    builder:
                        (context, Box<PlaylistSongs> playlistsongs, child) {
                      List<PlaylistSongs> playlistsong =
                          playlistsongs.values.toList();
                      return playlistsong.isNotEmpty
                          ? ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) => SizedBox(
                                height: height * 0.01,
                              ),
                              itemCount: playlistsong.length,
                              itemBuilder: ((context, index) {
                                return playlistcol(
                                    playlistsong[index].playlistName!,
                                    index,
                                    playlistsongs,
                                    songindex,
                                    context);
                              }),
                            )
                          : Text(
                              "You haven't created any playlist!",
                              style: GoogleFonts.kanit(
                                  color: Colors.white, fontSize: 15),
                            );
                    })
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> PopUpPlaylistCreate(BuildContext context) async {
    final myController = TextEditingController();
    return showDialog(
      barrierColor: Color.fromARGB(255, 16, 36, 70),
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 5, 24, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "Create Playlist",
            style: TextStyle(color: Colors.white),
          ),
          content: TextFormField(
            style: const TextStyle(
                color: Color.fromARGB(255, 51, 48, 48),
                fontWeight: FontWeight.bold),
            cursorColor: Color.fromARGB(255, 43, 40, 40),
            controller: myController,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              alignLabelWithHint: true,
              hintText: "Create you Playlist ",
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Create'),
              onPressed: () {
                CreatePlaylist(myController.text, context);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget playlistcol(playlistname, indexe, playlistsongs, songindex, context) {
    return Padding(
      padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
      child: Container(
        height: height * 0.10,
        decoration: BoxDecoration(
            color: const Color(0xFF080E1D),
            borderRadius: BorderRadius.circular(10)),
        child: ListTile(
            onTap: () {
              PlaylistSongs? playsongs = playlistsongs.getAt(indexe);
              List<Songs> playsongDB = playsongs!.playlistsSongs!;
              List<Songs> songDB = HomeProvider.songbox.values.toList();
              bool AlreadyAdded = playsongDB
                  .any((element) => element.id == songDB[songindex].id);
              if (!AlreadyAdded) {
                playsongDB.add(Songs(
                    songname: songDB[songindex].songname,
                    artist: songDB[songindex].artist,
                    duration: songDB[songindex].duration,
                    id: songDB[songindex].id,
                    songurl: songDB[songindex].songurl));
              }
              playlistsongs.putAt(
                  indexe,
                  PlaylistSongs(
                      playlistName: playlistsong[indexe].playlistName!,
                      playlistsSongs: playsongDB));
              Navigator.of(context).pop();
              log("added to${playlistsong[indexe].playlistName!}");
              showTopSnackBar(
                  Overlay.of(context),
                  CustomSnackBar.info(
                    message: "Added to Playlist",
                    backgroundColor: Color.fromARGB(255, 97, 132, 170),
                  ));
            },
            leading: ClipRRect(

                // borderRadius: BorderRadius.circular(20),
                child: Padding(
              padding: EdgeInsets.only(left: width * 0.01, top: height * 0.02),
              child: CircleAvatar(
                radius: 30,
                child: Image.asset(
                  'assets/images/disk.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            )),
            title: TextScroll(
              playlistname,
              style: GoogleFonts.kanit(color: Colors.white),
            )),
        // trailing: Padding(
        //   padding: EdgeInsets.only(right: width * 0.001, top: height * 0.008),
        //   child: Wrap(children: [
        //     IconButton(
        //         onPressed: () {
        //           PopUpPlaylistEdit(index);
        //         },
        //         icon: const Icon(
        //           Icons.edit,
        //           size: 25,
        //           color: Colors.white,
        //         )),
        //     IconButton(
        //         onPressed: () {
        //           PopUpPlaylistdelete(index);
        //         },
        //         icon: const Icon(
        //           Icons.delete,
        //           size: 25,
        //           color: Colors.white,
        //         )),
        //   ]),
        // ),
      ),
    );
  }
}
