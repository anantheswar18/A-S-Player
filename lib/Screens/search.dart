import 'package:as_player/Model/songmodel.dart';
import 'package:as_player/Screens/playingnow.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

import 'home.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();
  final box = SongBox.getInstance();
  late List<Songs> dbsongs;
  var size, height, width;
  final _searchController = TextEditingController();
  List<Audio> allSongs = [];
  void initState() {
    dbsongs = box.values.toList();
    for (var item in dbsongs) {
      allSongs.add(Audio.file(item.songurl!,
          metas: Metas(
              title: item.songname,
              artist: item.artist,
              id: item.id.toString())));
    }
    super.initState();
  }

  late List<Songs> another = List.from(dbsongs);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   title: Text(
      //     "Playing Now ",
      //     style: GoogleFonts.lato(
      //         textStyle: Theme.of(context).textTheme.bodyLarge,
      //         fontSize: 30,
      //         color: Colors.white),
      //   ),
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //     icon: const Icon(Icons.arrow_back_ios_new_outlined),
      //     iconSize: 30,
      //     color: Colors.white,
      //   ),
      //   actions: [
      //     IconButton(onPressed: () {}, icon: Icon(Icons.lyrics_outlined))
      //   ],
      // ),
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
              Padding(
                padding:
                    EdgeInsets.only(top: height * 0.07, right: width * 0.4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // IconButton(
                    //     onPressed: () {},
                    //     icon: const Icon(
                    //       Icons.arrow_back_ios_new,
                    //       size: 30,
                    //       color: Colors.white,
                    //     )),
                    Text(
                      "Search ",
                      style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.bodyLarge,
                          fontSize: 40,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              searchBox(),
              Padding(
                padding:  EdgeInsets.only(bottom: height* 0.10),
                child: SizedBox(
                    height: height,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: another.length,
                        itemBuilder: (context, index) {
                          return  con(index);
                          // return Slidable(
                              // closeOnScroll: true,
                              // useTextDirection: true,
                              // endActionPane: ActionPane(
                              //     motion: const StretchMotion(),
                              //     children: [
                              //       // SlidableAction(
                              //       //   borderRadius: BorderRadius.circular(20),
                              //       //   padding: EdgeInsets.only(
                              //       //       top: height * 0.02,
                              //       //       left: width * 0.05,
                              //       //       right: width * 0.05),
                              //       //   autoClose: false,
                              //       //   onPressed: (context) {
                              //       //     return _onDismised();
                              //       //   },
                              //       //   backgroundColor: const Color.fromARGB(
                              //       //       255, 97, 132, 170),
                              //       //   icon: Icons.playlist_add,
                              //       //   label: 'Add To Playlist',
                              //       // )
                              //     ]),
                              // startActionPane: ActionPane(
                              //     motion: const StretchMotion(),
                              //     children: [
                              //       SlidableAction(
                              //         borderRadius: BorderRadius.circular(20),
                              //         padding: EdgeInsets.only(
                              //             top: height * 0.02,
                              //             left: width * 0.05,
                              //             right: width * 0.05),
                              //         autoClose: true,
                              //         onPressed: (context) {
                              //           return _onDismised();
                              //         },
                              //         backgroundColor: Colors.red,
                              //         icon: Icons.favorite_border_outlined,
                              //         label: 'Add To Favorite',
                              //       )
                              // //     ]),
                              // child: con(index)
                              // );
                        })),
              )
              // Container(
              //   height: height,
              //   child: con(),
              // )
              // ListView.separated(itemBuilder: (context,index){
              //   return ListTile(
              //     leading: Image.asset('assets/images/NightChanges.jpeg',),
              //     title: Text("One Direction"),
              //   );
              // }, separatorBuilder: (context,index){
              //   return Divider();
              // }, itemCount: 10)
            ],
          ),
        ),
      ),
    );
  }

  Widget searchBox() {
    return Padding(
      padding: EdgeInsets.only(top: height*0.06,left: width*0.090,right: width*0.090),
      child: TextFormField(
        
        onTapOutside: (event) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        onChanged: (value) => changeList(value),
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
            onPressed: () => clearText(),
          ),
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

  void clearText() {
    _searchController.clear();
  }

  // Widget sections() {
  //   return ListView.separated(
  //       shrinkWrap: true,
  //       itemBuilder: (context, index) {
  //         return ListTile(
  //           leading: ClipRect(
  //             child: Image.asset(
  //               'assets/images/NightChanges.jpeg',
  //               width: 50,
  //             ),
  //           ),
  //           title: Text(
  //             "Night Changes ",
  //             style: GoogleFonts.aBeeZee(
  //                 textStyle: Theme.of(context).textTheme.bodyLarge,
  //                 fontSize: 20,
  //                 color: Colors.white),
  //           ),
  //           subtitle: const Text(
  //             "one Direction ",
  //             style: TextStyle(color: Colors.grey),
  //           ),
  //           trailing: IconButton(
  //               onPressed: () {},
  //               icon: const Icon(
  //                 Icons.more_vert_rounded,
  //                 color: Colors.white,
  //               )),
  //         );
  //       },
  //       separatorBuilder: (context, index) {
  //         return const Divider();
  //       },
  //       itemCount: 30);
  // }
  void _onDismised() {}
  Widget con(index) {
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
                audioPlayer.open(Playlist(audios: allSongs, startIndex: index),
                    showNotification: true,
                    headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                    loopMode: LoopMode.playlist);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PlayingNow(),));
              },
              leading: QueryArtworkWidget(
                id: another[index].id!,
                type: ArtworkType.AUDIO,
                keepOldArtwork: true,
                artworkBorder: BorderRadius.circular(10),
                nullArtworkWidget: ClipRRect(
                  child: Image.asset('assets/images/AS player Logo png.png'),
                ),
              ),
              title: TextScroll(
                another[index].songname!,
                style: GoogleFonts.aBeeZee(
                    textStyle: Theme.of(context).textTheme.bodyLarge,
                    fontSize: 20,
                    color: Colors.white),
                velocity: Velocity(pixelsPerSecond: Offset(100, 0)),
                intervalSpaces: 50,
              ),
              subtitle: TextScroll(
                another[index].artist ?? "No Artist",
                // overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey),
              ),
            )),
      ),
    );
  }

  void changeList(String value) {
    setState(() {
      another = dbsongs
          .where((element) =>
              element.songname!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      allSongs.clear();
      for (var item in another) {
        allSongs.add(Audio.file(item.songurl.toString(),
            metas: Metas(
                artist: item.artist,
                title: item.songname,
                id: item.id.toString())));
      }
    });
  }
}
