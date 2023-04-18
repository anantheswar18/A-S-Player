import 'package:as_player/Screens/popupsettings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      // backgroundColor: Color(0xFF091227),
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
              padding: EdgeInsets.only(top: height * 0.08, right: width * 0.5),
              child: Text(
                "Settings",
                style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.bodyLarge,
                    fontSize: 40,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: width * 0.10),
            //   child: Row(
            //     children: [
            //       const Icon(
            //         Icons.share,
            //         size: 30,
            //         color: Colors.white,
            //       ),
            //       SizedBox(
            //         width: width * 0.10,
            //       ),
            //       const Text(
            //         "Share App ",
            //         style: TextStyle(
            //             fontSize: 25,
            //             color: Colors.white,
            //             fontWeight: FontWeight.w500),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: height * 0.015,
            // ),
            // line(),
            // SizedBox(
            //   height: height * 0.030,
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: width * 0.10),
            //   child: Row(
            //     children: [
            //       const Icon(
            //         Icons.privacy_tip,
            //         size: 30,
            //         color: Colors.white,
            //       ),
            //       SizedBox(
            //         width: width * 0.10,
            //       ),
            //       const Text(
            //         "Privacy Policy ",
            //         style: TextStyle(
            //             fontSize: 25,
            //             color: Colors.white,
            //             fontWeight: FontWeight.w500),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: height * 0.018,
            // ),
            // line(),
            // SizedBox(
            //   height: height * 0.030,
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: width * 0.10),
            //   child: Row(
            //     children: [
            //       const Icon(
            //         Icons.info_outline,
            //         size: 30,
            //         color: Colors.white,
            //       ),
            //       SizedBox(
            //         width: width * 0.10,
            //       ),
            //       const Text(
            //         "About",
            //         style: TextStyle(
            //             fontSize: 25,
            //             color: Colors.white,
            //             fontWeight: FontWeight.w500),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: height * 0.013,
            // ),
            // line(),
            // SizedBox(
            //   height: height * 0.030,
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: width * 0.10),
            //   child: Row(
            //     children: [
            //       const Icon(
            //         Icons.document_scanner,
            //         size: 30,
            //         color: Colors.white,
            //       ),
            //       SizedBox(
            //         width: width * 0.10,
            //       ),
            //       const Text(
            //         "Terms and Condition",
            //         style: TextStyle(
            //             fontSize: 25,
            //             color: Colors.white,
            //             fontWeight: FontWeight.w500),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: height * 0.015,
            // ),
            // line(),
            // SizedBox(
            //   height: height * 0.030,
            // ),
            InkWell(
              onTap: () {
                Share.share("https://github.com/anantheswar18/A-S-Player.git",
                    subject: "A S Music Player");
              },
              child: items(
                  Icon(
                    Icons.share,
                    size: 30,
                    color: Colors.white,
                  ),
                  Text(
                    "Share App ",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  )),
            ),
            line(),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (builder) {
                    return settingmenupopup(mdFilename: 'privacypolicy.md');
                  },
                );
              },
              child: items(
                  Icon(
                    Icons.privacy_tip_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                  Text(
                    "Privacy Policy ",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  )),
            ),
            line(),
            InkWell(
              onTap: () {
                showAboutDialog(
                    context: context,
                    applicationName: "A S Player. ",
                    applicationIcon: Image.asset(
                      "assets/images/AS player Logo png.png",
                      height: 32,
                      width: 32,
                    ),
                    applicationVersion: "1.0.0",
                    children: [
                      Text(
                          "A S Player is an offline music player app which allows user to hear music from their local storage and also do functions like add to favorites,Create playlists,Recently played, Mostly Played etc....."),
                      SizedBox(height: 10),
                      Text("App development by Anantheswara Shenoy.V"),
                    ]);
              },
              child: items(
                  Icon(
                    Icons.info_outline,
                    size: 30,
                    color: Colors.white,
                  ),
                  Text(
                    "About  ",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  )),
            ),
            line(),
            InkWell(
              onTap: () {
                showDialog(context: context, builder: (context) {
                  return settingmenupopup(mdFilename: 'termsandconditons.md');
                },);
              },
              child: items(
                  Icon(
                    Icons.document_scanner_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                  Text(
                    "Terms And Conditions ",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  )),
            ),
            line()
          ],
        ),
      ),
    );
  }

  Widget items(
    Widget icon,
    Widget text,
  ) {
    return ListTile(
     
      leading: icon,
      title: text,
    );
  }
}

Widget line() {
  return const Divider(
    color: Colors.white,
    indent: 70,
    endIndent: 10,
  );
}
