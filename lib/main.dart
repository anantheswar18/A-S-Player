import 'package:as_player/Functions/dbfunctions.dart';
import 'package:as_player/Model/favorite.dart';
import 'package:as_player/Model/mostplayeddb.dart';
import 'package:as_player/Model/playlistmodel.dart';
import 'package:as_player/Model/recentlyplayed.dart';
import 'package:as_player/Model/songmodel.dart';
// import 'package:as_player/Screens/anibottamnav.dart';
// import 'package:as_player/Screens/mostplayed.dart';
// import 'package:as_player/Screens/playlist.dart';
import 'package:as_player/Screens/splash.dart';
// import 'package:as_player/bottom.dart';
// import 'package:as_player/home.dart';
// import 'package:as_player/mylibrary.dart';
// import 'package:as_player/navbottom.dart';
// import 'package:as_player/playingNow.dart';
// import 'package:as_player/search.dart';
// import 'package:as_player/settings.dart';
// import 'package:as_player/splash.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SongsAdapter());
  await Hive.openBox<Songs>(boxname);
  Hive.registerAdapter(favoritesAdapter());
  openFavoritesDB();
  Hive.registerAdapter(PlaylistSongsAdapter());
  openplaylistDb();
  Hive.registerAdapter(RecentlyPlayedAdapter());
  openrecentlyplayedDB();
  Hive.registerAdapter(MostPlayedAdapter());
  openmostplayeddatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,

        // primarySwatch:  Colors.transparent
      ),
      home: const SplashScreen(),
    );
  }
}
