import 'package:as_player/Model/recentlyplayed.dart';
import 'package:as_player/Screens/likedsonds.dart';
import 'package:as_player/Screens/mostplayed.dart';
import 'package:as_player/Screens/recentlyply.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../Model/favorite.dart';
import '../Model/mostplayeddb.dart';

class CardsHome extends StatelessWidget {
  CardsHome({super.key});
  var size, width, heigth;

  @override
  Widget build(BuildContext context) {
    final boxcount = favoritesbox.getInstance();
    final boxrecentcount = RecentlyPlayedBox.getInstance();
    final boxMost = MostPlayedBox.getInstance();
    List<MostPlayed> mostfinalsongcount = [];
    size = MediaQuery.of(context).size;
    width = size.width;
    heigth = size.height;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: SizedBox(
          width: heigth * 0.900,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: width * 0.05,
              ),
              ValueListenableBuilder<Box<favorites>>(
                valueListenable: boxcount.listenable(),
                builder: (context, Box<favorites> favcount, child) {
                  return InkWell(
                    onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => LikedSongs(),
                    )),
                    child: AlbumArt(
                      imagename:
                          "assets/images/pexels-daniel-reche-3721941.jpg",
                      head: "Favorites",
                      songNumber: favcount.length.toString(),
                    ),
                  );
                },
              ),
              SizedBox(
                width: width * 0.05,
              ),
              ValueListenableBuilder<Box<RecentlyPlayed>>(
                valueListenable: boxrecentcount.listenable(),
                builder: (context, Box<RecentlyPlayed> Recentcount, child) {
                  return InkWell(
                    onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => RecentlyPlayedScreen(),
                    )),
                    child: AlbumArt(
                        imagename:
                            "assets/images/pexels-jessica-lewis-creative-1010519.jpg",
                        head: "Recently Played",
                        songNumber: Recentcount.length.toString()),
                  );
                },
              ),
              SizedBox(
                width: width * 0.05,
              ),
              ValueListenableBuilder<Box<MostPlayed>>(
                valueListenable: boxMost.listenable(),
                builder: (context, Box<MostPlayed> MostCount, child) {
                  return InkWell(
                    onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => MostPlayedScreen(),
                    )),
                    child: AlbumArt(
                      imagename: "assets/images/mostly played.jpg",
                      head: "Most Played",
                    ),
                  );
                },
              ),
            ],
          )),
    );
  }

  Widget AlbumArt({required imagename, required head, songNumber}) {
    return Stack(
      children: [
        Container(
          height: heigth * 0.250,
          width: width * 0.50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: AssetImage(imagename), fit: BoxFit.cover),
          ),
        ),
        Positioned(
            right: width * 0.05,
            top: width*0.35,
            
            child: Container(
              height: width*0.15,
              width: width * 0.40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        head,
                        style: TextStyle(
                            fontFamily: "Inter", fontWeight: FontWeight.bold),
                      ),
                      Text(
                        songNumber == null ? "song" : "$songNumber song",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.play_circle_fill,
                    size: 35,
                  )
                ],
              ),
            ))
      ],
    );
  }
}
