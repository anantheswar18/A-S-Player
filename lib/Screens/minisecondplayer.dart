import 'package:as_player/Screens/playingnow.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
// import 'package:blaze_player/styles/stile1.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

import 'home.dart';

class MiniSecondPlayer extends StatefulWidget {
  const MiniSecondPlayer({super.key});
  static int? index = 0;
  static ValueNotifier<int> enteredvalue = ValueNotifier<int>(index!);

  @override
  State<MiniSecondPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniSecondPlayer> {
  @override
  Widget build(BuildContext context) {
    var rheight = MediaQuery.of(context).size.height;
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
              // shape:BoxShape.circle,border: Border.all(),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 20,
                    color: const Color(0xFF091227),
                    blurRadius: 50,
                    blurStyle: BlurStyle.normal,
                    )
              ],
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  // buttoncolor,
                  Color(0xFF000428),
                  Color.fromARGB(255, 97, 132, 170),
                  // Colors.white10,
                ],
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            width: rheight,
            height: rheight * 0.09,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  // width: rheight * 0.01,
                ),
                QueryArtworkWidget(
                  // quality: 1000,
                  id: int.parse(playing.audio.audio.metas.id!),
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: SizedBox(
                    height: rheight * 0.06,
                    child: const ClipRRect(
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(
                          "assets/images/AS player Logo png.png",
                        ),
                      ),
                    ),
                  ),
                ),
                // SizedBox(width: rheight * 0.01),
                SizedBox(
                  width: rheight * 0.15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextScroll(
                        audioPlayer.getCurrentAudioTitle,
                      ),
                      TextScroll(
                        audioPlayer.getCurrentAudioArtist 
                        // == "<unknown>"
                            // ? 'Artist Not Found'
                            // : audioPlayer.getCurrentAudioArtist,
                      ),
                    ],
                  ),
                ),
                PlayerBuilder.isPlaying(
                  player: audioPlayer,
                  builder: (context, isPlaying) => Wrap(
                    // spacing: 5,
                    // crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                    IconButton(
                        onPressed: () {
                          audioPlayer.previous();
                        },
                        icon: const Icon(Icons.skip_previous)),
                    IconButton(
                        onPressed: () {
                          audioPlayer.playOrPause();
                          setState(() {
                            isPlaying != isPlaying;
                          });
                        },
                        icon:
                            Icon((isPlaying) ? Icons.pause : Icons.play_arrow)),
                    IconButton(
                        onPressed: () {
                          audioPlayer.next();
                        },
                        icon: const Icon(Icons.skip_next)),
                  ]),
                ),
              ],
            ),
            
          ),
        );
        
      },
    );
  }
}
