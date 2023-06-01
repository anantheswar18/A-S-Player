// import 'package:as_player/Model/mostplayeddb.dart';
// import 'package:as_player/Model/songmodel.dart';
// import 'package:as_player/Screens/anibottamnav.dart';
// import 'package:as_player/Screens/snakenavigation.dart';
import 'package:as_player/state_management/splashManagement.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

// import '../Functions/dbfunctions.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<SplashProvider>(context).requestpermission(context);
    return Scaffold(
        backgroundColor: Color(0xFF091227),
        body: Center(
            child: ClipRRect(
          child: Image.asset('assets/images/AS player Logo.jpg'),
        )));
  }
}
