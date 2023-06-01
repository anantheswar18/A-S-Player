import 'package:as_player/Screens/likedsonds.dart';
import 'package:as_player/Screens/playlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class MyLibrary extends StatelessWidget {
  MyLibrary({super.key});

  var size, height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
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
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: height * 0.09, left: width * 0.1),
              child: Row(
                children: [
                  Text(
                    "My ",
                    style: GoogleFonts.oswald(
                        textStyle: Theme.of(context).textTheme.bodyLarge,
                        fontSize: 40,
                        color: Color.fromARGB(255, 97, 132, 170)),
                    // style: TextStyle(
                    //   fontSize: 40,
                    //   fontFamily: "Inter",
                    //   fontWeight: FontWeight.bold,
                    //   color: Colors.white
                    // ),
                  ),
                  Text(
                    "Libr",
                    style: GoogleFonts.oswald(
                        textStyle: Theme.of(context).textTheme.bodyLarge,
                        fontSize: 40,
                        color: Colors.white),
                    
                  ),
                  Text(
                    "ary",
                    style: GoogleFonts.oswald(
                        textStyle: Theme.of(context).textTheme.bodyLarge,
                        fontSize: 40,
                        color: Color.fromARGB(255, 97, 132, 170)),
                    
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LikedSongs(),
                  ));
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color(0xFF091227),

                      // gradient: LinearGradient(
                      //   begin: Alignment.topLeft,
                      //   end: Alignment.bottomRight,
                      //   colors: [
                      //     Color.fromARGB(255, 26, 29, 59),
                      //     Color.fromARGB(255, 50, 65, 83),
                      //   ],
                      // ),
                      boxShadow: [
                        BoxShadow(blurRadius: 5, offset: Offset.zero)
                      ]),
                  height: height * 0.09,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(
                        Icons.favorite_border,
                        size: 30,
                        color: Colors.white,
                      ),
                      Text(
                        "Liked Songs ",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 25,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PlayList(),
                  ));
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color(0xFF091227),
                      // color: Colors.,
                      // gradient: LinearGradient(
                      //   begin: Alignment.topLeft,
                      //   end: Alignment.bottomRight,
                      //   colors: [
                      //     Color.fromARGB(255, 26, 29, 59),
                      //     Color.fromARGB(255, 50, 65, 83),
                      //   ],
                      // ),
                      boxShadow: [
                        BoxShadow(blurRadius: 5, offset: Offset.zero)
                      ]),
                  height: height * 0.09,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(
                        Icons.music_note,
                        size: 30,
                        color: Colors.white,
                      ),
                      Text(
                        "PlayLists ",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 25,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
