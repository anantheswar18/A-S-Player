import 'package:as_player/Functions/createplaylist.dart';
import 'package:as_player/Model/playlistmodel.dart';
import 'package:as_player/Model/playlistmodel.dart';
import 'package:as_player/Model/playlistmodel.dart';
import 'package:as_player/Screens/playlistinside.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

import '../Model/playlistmodel.dart';
import '../Model/playlistmodel.dart';

class PlayList extends StatefulWidget {
  const PlayList({super.key});

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  var size, height, width;
  final playlistbox = PlaylistSongsBox.getInstance();
  late List<PlaylistSongs> playlistsong = playlistbox.values.toList();
  final List<PlaylistModel> playlistsonglist = [];
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: height * 0.08,
        backgroundColor: const Color(0xFF000428),
        // shadowColor: Color.fromARGB(255, 97, 132, 170),
        title: Text(
          "PlayList ",
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
          child: Column(
            children: [
              SizedBox(
                height: height * 0.03,
              ),
              col(
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                  const Text(
                    "Create PlayList ",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  )),
              SizedBox(
                height: height * 0.01,
              ),
              ValueListenableBuilder<Box<PlaylistSongs>>(
                  valueListenable: playlistbox.listenable(),
                  builder: (context, Box<PlaylistSongs> playlistsongs, child) {
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
                              return playlistcol(index, playlistsong);
                            }),
                          )
                        : Padding(
                            padding: EdgeInsets.only(top: height * 0.3),
                            child: Text(
                              "You haven't created any playlist!",
                              style: GoogleFonts.kanit(
                                  color: Colors.white, fontSize: 15),
                            ),
                          );
                  })
              // col(
              //     Image.asset(
              //       'assets/images/romantic.jpeg',
              //       fit: BoxFit.cover,
              //       width: 70,
              //     ),
              //     const Text(
              //       'Romantic Songs',
              //       style: TextStyle(
              //           fontSize: 20,
              //           color: Colors.white,
              //           fontWeight: FontWeight.w500),
              //     )),
              // SizedBox(
              //   height: height * 0.01,
              // ),
              // col(
              //     Image.asset(
              //       'assets/images/workout.jpeg',
              //       height: height * 0.5,
              //     ),
              //     const Text(
              //       'WorkOut Songs',
              //       style: TextStyle(
              //           fontSize: 20,
              //           color: Colors.white,
              //           fontWeight: FontWeight.w500),
              //     )),
              // SizedBox(
              //   height: height * 0.01,
              // ),
              // col(
              //     Image.asset(
              //       'assets/images/party.jpeg',
              //       width: 60,
              //       height: 60,
              //       fit: BoxFit.cover,
              //     ),
              //     const Text(
              //       'Party Songs',
              //       style: TextStyle(
              //           fontSize: 20,
              //           color: Colors.white,
              //           fontWeight: FontWeight.w500),
              //     ))
            ],
          ),
        ),
      ),
    );
  }

  Widget col(Widget icon, Widget head) {
    return Padding(
      padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
      child: Container(
        height: height * 0.10,
        decoration: BoxDecoration(
            color: const Color(0xFF080E1D),
            borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          onTap: () {
            PopUpPlaylistCreate();
          },
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: icon,
          ),
          title: Padding(
            padding: EdgeInsets.only(top: height * 0.02),
            child: head,
          ),
          trailing: Padding(
            padding: EdgeInsets.only(top: height * 0.02),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 30,
                  color: Colors.white,
                )),
          ),
        ),
      ),
    );
  }

  Widget playlistcol(index, playlistsong) {
    return Padding(
      padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
      child: Container(
        height: height * 0.10,
        decoration: BoxDecoration(
            color: const Color(0xFF080E1D),
            borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PlaylistInside(
                playindex: index,
                playlistname: playlistsong[index].playlistName,
              ),
            ));
          },
          leading: ClipRRect(
            
            // borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding:  EdgeInsets.only(left: width*0.01,top: height*0.02),
              child: CircleAvatar(
                radius: 30,
                child:  Image.asset(
                'assets/images/disk.jpg',
                fit: BoxFit.cover,
              ),
              ),
            )
            // Image.asset(
            //   'assets/images/disk.jpg',
            //   fit: BoxFit.cover,
            // ),
          ),
          title: Padding(
              padding: EdgeInsets.only(top: height * 0.02),
              child: TextScroll(
                playlistsong[index].playlistName!,
                style: GoogleFonts.kanit(color: Colors.white),
              )),
          trailing: Padding(
            padding: EdgeInsets.only(right: width * 0.001, top: height * 0.008),
            child: Wrap(children: [
              IconButton(
                  onPressed: () {
                    PopUpPlaylistEdit(index);
                  },
                  icon: const Icon(
                    Icons.edit,
                    size: 25,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {
                    PopUpPlaylistdelete(index);
                  },
                  icon: const Icon(
                    Icons.delete,
                    size: 25,
                    color: Colors.white,
                  )),
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> PopUpPlaylistCreate() async {
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
                CreatePlaylist(myController.text,context);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> PopUpPlaylistEdit(index) async {
    final editController = TextEditingController();
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
            "Edit Playlist",
            style: TextStyle(color: Colors.white),
          ),
          content: TextFormField(
            style: const TextStyle(
                color: Color.fromARGB(255, 51, 48, 48),
                fontWeight: FontWeight.bold),
            cursorColor: Color.fromARGB(255, 43, 40, 40),
            controller: editController,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              alignLabelWithHint: true,
              hintText: " Rename ",
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
              child: const Text('Rename'),
              onPressed: () {
                editPlaylist(editController.text, index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> PopUpPlaylistdelete(index) async {
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
              onPressed: () {
                deletePlaylist(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
