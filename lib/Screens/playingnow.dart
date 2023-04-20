import 'package:as_player/Functions/lyricsfunction.dart';
import 'package:as_player/Model/songmodel.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:marquee/marquee.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../Functions/addToFavorite.dart';
import '../Functions/createplaylist.dart';
import '../Model/playlistmodel.dart';
import 'home.dart';

class PlayingNow extends StatefulWidget {
  PlayingNow({super.key});

  List<Songs>? songs;
  static int? indexvalue = 0;
  static ValueNotifier<int> nowplayingindex = ValueNotifier<int>(indexvalue!);

  @override
  State<PlayingNow> createState() => _PlayingNowState();
}

class _PlayingNowState extends State<PlayingNow> {
  bool _isFavorite = false;
  double _sliderValue = 0.5; 
  var size, height, width;
  bool _isplayed = false;
  final audioPlayer1 = AssetsAudioPlayer.withId('0');
  // final AssetsAudioPlayer audioPlayer1 = AssetsAudioPlayer.withId('0');

  final box = SongBox.getInstance();
  bool isRepeat = false;
  bool isShuffleOn = false;

  void _updateSliderValue(double value) {
    setState(() {
      _sliderValue = value;
    });
  }

  void _togglefav() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  void _playpause() {
    setState(() {
      _isplayed = !_isplayed;
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    Duration duration = Duration.zero;
    Duration position = Duration.zero;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Playing Now ",
          style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.bodyLarge,
              fontSize: 30,
              color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          iconSize: 30,
          color: Colors.white,
        ),
        actions: [
          IconButton(onPressed: () {
            lyricsBottom(context,audioPlayer1.getCurrentAudioTitle,audioPlayer1.getCurrentAudioArtist);
          }, icon: Icon(Icons.lyrics_outlined))
        ],
      ),

      // Color(0xFF0141e30),Color(0xFF0243b55)
      // backgroundColor: const Color(0xFF091227),
      body: Container(
        // height: height,
        width: width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 97, 132, 170),
              Color(0xFF000428),
            ],
          ),
        ),
        child: ValueListenableBuilder(
          valueListenable: PlayingNow.nowplayingindex,
          builder: (BuildContext context, int playing, child) {
            return ValueListenableBuilder<Box<Songs>>(
                valueListenable: box.listenable(),
                builder: ((context, Box<Songs> allsongbox, child) {
                  List<Songs> allsongs = allsongbox.values.toList();
                  if (allsongs.isEmpty) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  // ignore: unnecessary_null_comparison
                  if (allsongs == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return audioPlayer1.builderCurrent(
                    builder: ((context, playing) {
                      return Column(
                        children: [
                          SizedBox(
                            height: height * 0.22,
                          ),
                          QueryArtworkWidget(
                            // size: 3000,
                            keepOldArtwork: true,
                            quality: 100,
                            artworkQuality: FilterQuality.high,
                            artworkHeight: height * 0.30,
                            artworkWidth: height * 0.30,
                            artworkBorder: BorderRadius.circular(30),
                            artworkFit: BoxFit.cover,
                            id: int.parse(playing.audio.audio.metas.id!),
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                "assets/images/AS player Logo png.png",
                                width: height * 0.30,
                                height: height * 0.30,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: height * 0.07),
                            child: SizedBox(
                              height: height * 0.20,
                              // width: double.infinity,
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: width * 0.05,
                                            right: width * 0.05),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: TextScroll(
                                            audioPlayer1.getCurrentAudioTitle,
                                            intervalSpaces: 50,
                                            style: TextStyle(fontSize: 20),
                                            velocity: Velocity(
                                                pixelsPerSecond:
                                                    Offset(100, 0)),
                                          ),
                                          // Text(
                                          //   _audioPlayer.getCurrentAudioTitle,
                                          //   style: TextStyle(
                                          //     fontSize: 20,
                                          //     color:
                                          //         Colors.white.withOpacity(0.7),
                                          //     // Color.fromARGB(
                                          //     //     255, 138, 135, 135)
                                          //   ),
                                          // ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: width * 0.04,right: width*0.04),
                                        child: TextScroll(
                                          audioPlayer1.getCurrentAudioArtist,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            // Color.fromARGB(
                                            //     255, 138, 135, 135)
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: width * 0.70),
                                          child: IconButton(
                                            color: Color.fromARGB(
                                                255, 224, 217, 217),
                                            iconSize: 27,
                                            icon: (checkFavStatus(
                                                    int.parse(playing
                                                        .audio.audio.metas.id!),
                                                    BuildContext))
                                                ? Icon(Icons
                                                    .favorite_border_outlined)
                                                : Icon(
                                                    Icons.favorite_rounded,
                                                    color: Colors.red,
                                                  ),
                                            onPressed: () {
                                              if (checkFavStatus(
                                                  int.parse(playing
                                                      .audio.audio.metas.id!),
                                                  BuildContext)) {
                                                addToFav(
                                                  int.parse(playing
                                                      .audio.audio.metas.id!),
                                                );
                                                final snackbar = SnackBar(
                                                  duration:
                                                      Duration(seconds: 1),
                                                  content: Text(
                                                    "Added to Favorites",
                                                    style: GoogleFonts.kanit(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  ),
                                                  backgroundColor:
                                                      Colors.black12,
                                                  dismissDirection:
                                                      DismissDirection.down,
                                                  elevation: 50,
                                                  padding: EdgeInsets.only(
                                                      bottom: 30, top: 10),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackbar);
                                              } else if (!checkFavStatus(
                                                  int.parse(playing
                                                      .audio.audio.metas.id!),
                                                  BuildContext)) {
                                                removeFav(
                                                  int.parse(playing
                                                      .audio.audio.metas.id!),
                                                );
                                                final snackbar2 = SnackBar(
                                                  duration:
                                                      Duration(seconds: 1),
                                                  content: Text(
                                                    "Removed from Favorites",
                                                    style: GoogleFonts.kanit(
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  ),
                                                  backgroundColor:
                                                      Colors.black12,
                                                  dismissDirection:
                                                      DismissDirection.down,
                                                  elevation: 50,
                                                  padding: EdgeInsets.only(
                                                      top: 10, bottom: 30),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackbar2);
                                              }
                                              setState(() {
                                                _isFavorite = !_isFavorite;
                                              });
                                            },
                                          )),
                                      IconButton(
                                          iconSize: 27,
                                          onPressed: () {
                                            ShowBottomSheetCreate(
                                                playing.index, context);
                                          },
                                          icon: Icon(
                                            Icons.more_vert,
                                            color: Color.fromARGB(
                                                255, 224, 217, 217),
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  PlayerBuilder.realtimePlayingInfos(
                                    player: audioPlayer1,
                                    builder: (context, RealtimePlayingInfos) {
                                      duration = RealtimePlayingInfos
                                          .current!.audio.duration;
                                      position =
                                          RealtimePlayingInfos.currentPosition;
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            right: width * 0.080,
                                            left: width * 0.080),
                                        child: ProgressBar(
                                          baseBarColor: Colors.grey,
                                          progressBarColor: Colors.white,
                                          thumbColor: Colors.white,
                                          thumbRadius: 5,
                                          timeLabelPadding: 10,
                                          progress: position,
                                          timeLabelTextStyle: const TextStyle(
                                            color: Colors.white,
                                            
                                          ),
                                          total: duration,
                                          onSeek: (duration) async {
                                            await audioPlayer1.seek(duration);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.03),
                          PlayerBuilder.isPlaying(
                            player: audioPlayer1,
                            builder: ((context, isPlaying) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      await audioPlayer1.previous();
                                    },
                                    icon: const Icon(
                                        Icons.skip_previous_outlined),
                                    iconSize: 50,
                                    color: Colors.white,
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      if (isPlaying) {
                                        await audioPlayer1.pause();
                                      } else {
                                        await audioPlayer1.play();
                                      }
                                      _playpause();
                                    },
                                    icon: (isPlaying)
                                        ? const Icon(Icons.pause_outlined)
                                        : Icon(Icons.play_arrow_outlined),
                                    iconSize: 50,
                                    color: Colors.white,
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await audioPlayer1.next();
                                    },
                                    icon: const Icon(Icons.skip_next_outlined),
                                    iconSize: 50,
                                    color: Colors.white,
                                  )
                                ],
                              );
                            }),
                          ),
                        ],
                      );
                    }),
                  );
                }));
          },
        ),
      ),
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
                  child: Text("Add To Playlist"),
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
                                    songindex);
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

  Future<void> PopUpPlaylistCreate(BuildContext context2) async {
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
                CreatePlaylist(myController.text, context2);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget playlistcol(playlistname, indexe, playlistsongs, songindex) {
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
              List<Songs> songDB = songbox.values.toList();
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
              showTopSnackBar(
                  Overlay.of(context),
                  CustomSnackBar.info(
                    message: "Added to Playlist",
                    backgroundColor: Color.fromARGB(255, 97, 132, 170),
                  ));

              // log("added to${playlistsong[indexe].playlistName!}");
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

void gradient() {
  Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.blue,
          Colors.red,
        ],
      ),
    ),
  );
}
