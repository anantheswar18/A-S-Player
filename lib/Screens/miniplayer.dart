import 'package:as_player/Screens/home.dart';
import 'package:as_player/Screens/playingnow.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

class MiniPlayerScreen extends StatefulWidget {
  const MiniPlayerScreen({super.key});

  @override
  State<MiniPlayerScreen> createState() => _MiniPlayerScreenState();
}

class _MiniPlayerScreenState extends State<MiniPlayerScreen> {
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return audioPlayer.builderCurrent(
      builder: (context, playing) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => PlayingNow(),
                ));
          },
          child: Container(
            
            decoration: BoxDecoration(
              
                color: const Color(0xFF091227),
                borderRadius: BorderRadius.circular(50),
                // boxShadow: [
                //   BoxShadow(
                //       color: const Color(0xFF091227),
                //       blurRadius: 50,
                //       blurStyle: BlurStyle.solid)
                // ]
                ),
            width: width,
            height: height * 0.10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: width * 0.03, right: width * 0.003),
                  child: QueryArtworkWidget(
                    quality: 100,
                    artworkHeight: height * 0.1,
                    artworkWidth: width * 0.2,
                    keepOldArtwork: true,
                    artworkBorder: BorderRadius.circular(10),
                    id: int.parse(playing.audio.audio.metas.id!),
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        "assets/images/AS player Logo png.png",
                        height: height * 0.15,
                        width: width * 0.15,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: width * 0.3,
                        child: TextScroll(
                          audioPlayer.getCurrentAudioTitle,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.004),
                      child: SizedBox(
                        width: width * 0.3,
                        child: TextScroll(audioPlayer.getCurrentAudioArtist),
                      ),
                    ),
                  ],
                ),
                PlayerBuilder.isPlaying(
                    player: audioPlayer,
                    builder: ((context, isPlaying) {
                      return Wrap(
                        spacing: 5,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white),
                            child: IconButton(
                                onPressed: () async {
                                  await audioPlayer.previous();
                                },
                                icon: Icon(
                                  Icons.skip_previous,
                                  color: Colors.black,
                                  size: 20,
                                )),
                          ),
                          Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.black),
                              child: IconButton(
                                icon: Icon(
                                  (isPlaying) ? Icons.pause : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () async {
                                  await audioPlayer.playOrPause();

                                  setState(() {
                                    isPlaying = !isPlaying;
                                  });
                                },
                              )),
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white),
                            child: IconButton(
                              onPressed: () async {
                                await audioPlayer.next();
                              },
                              icon: const Icon(
                                Icons.skip_next,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      );
                    }))
              ],
            ),
          ),
        );
      },
    );
  }
}
