import 'package:as_player/Screens/mylibrary.dart';
import 'package:as_player/Screens/playingnow.dart';
import 'package:as_player/Screens/search.dart';
import 'package:as_player/Screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  final screens = [PlayingNow(), SearchScreen(), MyLibrary(), Settings()];
  var size,height,width;
  @override
  Widget build(BuildContext context) {
    size=MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Color(0xFF091227),
        leadingWidth: 80,
        leading: IconButton(
            onPressed: () {},
            icon: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/NightChanges.jpeg',
                  width: width * 0.100,
                  height: height * 0.10,
                ))),
                title:  Text("AS Player",style: GoogleFonts.aBeeZee(
                    textStyle: Theme.of(context).textTheme.bodyLarge,
                    fontSize: 30,
                    color: Colors.white),),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: screens),
        bottomNavigationBar: BottomNavigationBar(
            onTap: (index) => setState(() => _currentIndex = index),
            currentIndex: _currentIndex, 
            backgroundColor: const Color(0xFF091227),
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            
            items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_add),
          label: 'Library',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        )
            ],
          ));
  }
}
