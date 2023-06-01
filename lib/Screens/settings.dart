import 'package:as_player/Functions/notifications.dart';
import 'package:as_player/widgets/popupsettings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

  var size, height, width;

  // bool status = false;
  // late bool notificationStatus = true;

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
          // mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: height * 0.08, left: width * 0.05),
              child: Row(
                children: [
                  Text(
                    "Se",
                    style: GoogleFonts.oswald(
                        textStyle: Theme.of(context).textTheme.bodyLarge,
                        fontSize: 35,
                         fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 97, 132, 170)),
                    // style: TextStyle(
                    //   fontSize: 28,
                    //   fontFamily: "Inter",
                    //   fontWeight: FontWeight.bold,
                    //   color: Colors.white
                    // ),
                  ),
                  Text(
                    "tti",
                    style: GoogleFonts.oswald(
                        textStyle: Theme.of(context).textTheme.bodyLarge,
                        fontSize: 35,
                         fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  Text(
                    "ngs",
                    style: GoogleFonts.oswald(
                        textStyle: Theme.of(context).textTheme.bodyLarge,
                        fontSize: 35,
                         fontWeight: FontWeight.w800,
                        color: Color.fromARGB(255, 97, 132, 170)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),

            // *****************About*********************
            ListTile(
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
              leading: const Icon(
                Icons.person,
                size: 35,
                color: Colors.white,
              ),
              title: Text(
                "About",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inter",
                    fontSize: 18),
              ),
            ),
            // **********************Share**********************

            ListTile(
              onTap: () {
                Share.share(
                    "https://play.google.com/store/apps/details?id=apps.musicplayer.as_player",
                    subject: "A S Music Player");
              },
              leading: const Icon(
                Icons.share,
                size: 35,
                color: Colors.white,
              ),
              title: Text(
                "Share",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inter",
                    fontSize: 18),
              ),
            ),
            // ******************************NOtifications**********************
            NotificationList(
              title: "Notifications",
              logo: Icons.notifications,
            ),
            // ListTile(
            //   leading: Icon(
            //     Icons.notifications,
            //     size: 35,
            //     color: Colors.white,
            //   ),
            //   title: Text(
            //     "Notifications",
            //     style: const TextStyle(
            //         color: Colors.white,
            //         fontWeight: FontWeight.bold,
            //         fontFamily: "Inter",
            //         fontSize: 18),
            //   ),
            //   trailing: Switch(
            //     activeTrackColor: Colors.white,
            //     activeColor: Colors.grey,
            //     inactiveTrackColor: Colors.grey,
            //     value: notificationStatus,
            //     onChanged: (value) {
            //       setState(() {
            //         notificationStatus = value;
            //       });
            //     },
            //   ),
            // ),
            // ****************Terms and  condition *************************
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return settingmenupopup(mdFilename: 'termsandconditons.md');
                  },
                );
              },
              leading: const Icon(
                Icons.book,
                size: 35,
                color: Colors.white,
              ),
              title: Text(
                "Terms And Conditions",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inter",
                    fontSize: 18),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.white,
              ),
            ),
            // *************Privacy policy*************************
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (builder) {
                    return settingmenupopup(mdFilename: 'privacypolicy.md');
                  },
                );
              },
              leading: const Icon(
                Icons.privacy_tip,
                size: 35,
                color: Colors.white,
              ),
              title: const Text(
                "Privacy policy",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inter",
                    fontSize: 18),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
