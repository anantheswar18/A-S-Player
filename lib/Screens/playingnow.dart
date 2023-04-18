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
  final _audioPlayer = AssetsAudioPlayer.withId('0');
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
                  return _audioPlayer.builderCurrent(
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
                                            _audioPlayer.getCurrentAudioTitle,
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
                                            EdgeInsets.only(left: width * 0.02),
                                        child: Text(
                                          _audioPlayer.getCurrentAudioArtist,
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
                                            icon: _isFavorite
                                                ? Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                  )
                                                : Icon(Icons.favorite_border),
                                            onPressed: () {
                                              setState(() {
                                                _isFavorite = !_isFavorite;
                                              });
                                            },
                                          )),
                                      IconButton(
                                          iconSize: 27,
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.more_vert,
                                            color: Color.fromARGB(
                                                255, 224, 217, 217),
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  PlayerBuilder.realtimePlayingInfos(
                                    player: _audioPlayer,
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
                                          timeLabelPadding: 5,
                                          progress: position,
                                          timeLabelTextStyle: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          total: duration,
                                          onSeek: (duration) async {
                                            await _audioPlayer.seek(duration);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                          PlayerBuilder.isPlaying(
                            player: _audioPlayer,
                            builder: ((context, isPlaying) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      await _audioPlayer.previous();
                                    },
                                    icon: const Icon(
                                        Icons.skip_previous_outlined),
                                    iconSize: 50,
                                    color: Colors.white,
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      if (isPlaying) {
                                        await _audioPlayer.pause();
                                      } else {
                                        await _audioPlayer.play();
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
                                      await _audioPlayer.next();
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
