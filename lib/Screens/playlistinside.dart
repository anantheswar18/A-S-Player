import 'dart:developer';

import 'package:as_player/Model/playlistmodel.dart';
import 'package:as_player/Model/songmodel.dart';
import 'package:as_player/Screens/minisecondplayer.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

import '../Functions/createplaylist.dart';
import 'home.dart';

class PlaylistInside extends StatefulWidget {
  PlaylistInside({
    super.key,
    required int this.playindex,
    required this.playlistname,
  });
  int playindex;
  String playlistname;
  @override
  State<PlaylistInside> createState() => _PlaylistInsideState();
}

class _PlaylistInsideState extends State<PlaylistInside> {
  // final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer.withId('0');
  List<Audio> convertAudio = [];
  var size, height, width;
  @override
  void initState() {
    final playbox = PlaylistSongsBox.getInstance();
    List<PlaylistSongs> playlistsong = playbox.values.toList();
    for (var item in playlistsong[widget.playindex].playlistsSongs!) {
      convertAudio.add(Audio.file(item.songurl!,
          metas: Metas(
              title: item.songname,
              artist: item.artist,
              id: item.id.toString())));
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    final playbox = PlaylistSongsBox.getInstance();
    List<PlaylistSongs> playlistsong = playbox.values.toList();
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color(0xFF000428),
        title: Text(
          playlistsong[widget.playindex].playlistName!,
          style: GoogleFonts.kadwa(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
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
          child: Column(
            children: [
              SizedBox(height: height * 0.03),
              ValueListenableBuilder<Box<PlaylistSongs>>(
                valueListenable: playbox.listenable(),
                builder: (context, Box<PlaylistSongs> playlistsongs, child) {
                  log('ugybi');
                  List<PlaylistSongs> playlistsong =
                      playlistsongs.values.toList();
                  List<Songs>? playsong =
                      playlistsong[widget.playindex].playlistsSongs;
                  return playsong!.isNotEmpty
                      ? ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.05, right: width * 0.05),
                              child: Container(
                                height: height * 0.10,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF080E1D),
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  onTap: () {
                                    audioPlayer.open(
                                      Playlist(
                                          audios: convertAudio,
                                          startIndex: index),
                                      headPhoneStrategy: HeadPhoneStrategy
                                          .pauseOnUnplugPlayOnPlug,
                                      showNotification: true,
                                    );
                                  },
                                  leading: playlistsong[widget.playindex]
                                          .playlistsSongs!
                                          .isNotEmpty
                                      ? QueryArtworkWidget(
                                          keepOldArtwork: true,
                                          artworkBorder:
                                              BorderRadius.circular(10),
                                          id: playlistsong[widget.playindex]
                                              .playlistsSongs![index]
                                              .id!,
                                          type: ArtworkType.AUDIO,
                                          nullArtworkWidget: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.asset(
                                              'assets/images/disk.jpg',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.asset(
                                            'assets/images/disk.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                  title: Padding(
                                      padding:
                                          EdgeInsets.only(top: height * 0.02),
                                      child: TextScroll(
                                        playsong[index].songname!,
                                        style: GoogleFonts.kanit(
                                            color: Colors.white),
                                      )),
                                  subtitle: Text(
                                    playsong[index].artist!,
                                    style: GoogleFonts.kanit(
                                        fontSize: 14,
                                        color: Colors.white.withOpacity(0.7)),
                                  ),
                                  trailing: Padding(
                                    padding: EdgeInsets.only(
                                        right: width * 0.001,
                                        top: height * 0.008),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            playsong.removeAt(index);
                                            playlistsong
                                                .removeAt(widget.playindex);
                                            playbox.putAt(
                                                widget.playindex,
                                                PlaylistSongs(
                                                    playlistName:
                                                        widget.playlistname,
                                                    playlistsSongs: playsong));
                                          });
                                          Navigator.pushReplacement(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation1,
                                                      animation2) =>
                                                  PlaylistInside(
                                                      playindex:
                                                          widget.playindex,
                                                      playlistname:
                                                          widget.playlistname),
                                              transitionDuration: Duration.zero,
                                              reverseTransitionDuration:
                                                  Duration.zero,
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          size: 25,
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                height: height * 0.01,
                              ),
                          itemCount: playsong.length)
                      : Padding(
                          padding: EdgeInsets.only(top: height * 0.3),
                          child: Text(
                            "Please add a song!",
                            style: GoogleFonts.kanit(color: Colors.white),
                          ),
                        );
                },
              ),
              SizedBox(
                height: height * 0.02,
              )
            ],
          ),
        ),
      ),
      bottomSheet: MiniSecondPlayer(),
    );
  }

  PlaylistAddTo() {
    return Container(
      height: height * 0.10,
      decoration: BoxDecoration(
          color: const Color(0xFF080E1D),
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(),
    );
  }

  // playlistsong
  // playlistcol(index, playsong, playbox, playlistsong) {
  //   return Padding(
  //     padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
  //     child: Container(
  //       height: height * 0.10,
  //       decoration: BoxDecoration(
  //           color: const Color(0xFF080E1D),
  //           borderRadius: BorderRadius.circular(10)),
  //       child: ListTile(
  //         onTap: () {
  //           audioPlayer.open(
  //             Playlist(audios: convertAudio, startIndex: index),
  //             headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
  //             showNotification: true,
  //           );
  //         },
  //         leading: playlistsong[widget.playindex].playlistsSongs.isNotEmpty
  //             ? QueryArtworkWidget(
  //                 keepOldArtwork: true,
  //                 artworkBorder: BorderRadius.circular(10),
  //                 id: playlistsong[widget.playindex].playlistsSongs[index].id,
  //                 type: ArtworkType.AUDIO,
  //                 nullArtworkWidget: ClipRRect(
  //                   borderRadius: BorderRadius.circular(20),
  //                   child: Image.asset(
  //                     'assets/images/disk.jpg',
  //                     fit: BoxFit.cover,
  //                   ),
  //                 ),
  //               )
  //             : ClipRRect(
  //                 borderRadius: BorderRadius.circular(20),
  //                 child: Image.asset(
  //                   'assets/images/disk.jpg',
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //         title: Padding(
  //             padding: EdgeInsets.only(top: height * 0.02),
  //             child: TextScroll(
  //               playsong[index].songname!,
  //               style: GoogleFonts.kanit(color: Colors.white),
  //             )),
  //         subtitle: Text(
  //           playsong[index].artist,
  //           style: GoogleFonts.kanit(
  //               fontSize: 14, color: Colors.white.withOpacity(0.7)),
  //         ),
  //         trailing: Padding(
  //           padding: EdgeInsets.only(right: width * 0.001, top: height * 0.008),
  //           child: IconButton(
  //               onPressed: () {
  //                 setState(() {
  //                   playsong.removeAt(index);
  //                   playlistsong.removeAt(widget.playindex);
  //                   playbox.putAt(
  //                       widget.playindex,
  //                       PlaylistSongs(
  //                           playlistName: widget.playlistname,
  //                           playlistsSongs: playsong));
  //                 });
  //                 Navigator.pushReplacement(
  //                   context,
  //                   PageRouteBuilder(
  //                     pageBuilder: (context, animation1, animation2) =>
  //                         PlaylistInside(
  //                             playindex: widget.playindex,
  //                             playlistname: widget.playlistname),
  //                     transitionDuration: Duration.zero,
  //                     reverseTransitionDuration: Duration.zero,
  //                   ),
  //                 );
  //               },
  //               icon: const Icon(
  //                 Icons.delete,
  //                 size: 25,
  //                 color: Colors.white,
  //               )),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Future<void> PopUpPlaylistdelete(
      index, playsong, playlistsong, playbox) async {
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
            "Are You Sure",
            style: TextStyle(color: Colors.white),
          ),
          // content: ,
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Yes'),
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }
}
