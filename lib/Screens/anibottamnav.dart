import 'package:as_player/Screens/home.dart';
import 'package:as_player/Screens/miniplayer.dart';
import 'package:as_player/Screens/minisecondplayer.dart';
import 'package:as_player/Screens/mylibrary.dart';
import 'package:as_player/Screens/playingnow.dart';
import 'package:as_player/Screens/search.dart';
import 'package:as_player/Screens/settings.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

class AniBottomnav extends StatefulWidget {
  const AniBottomnav({super.key});

  @override
  State<AniBottomnav> createState() => _AniBottomnavState();
}

class _AniBottomnavState extends State<AniBottomnav> {
  final _pageController = PageController(initialPage: 0);
  final List<Widget> screens = [
    const HomePage(),
    const SearchScreen(),
    const MyLibrary(),
    const Settings(),
  ];
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
  }
  

  int _currentIndex = 0;
 var size,width,height;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
   width = size.width;
    return Scaffold(
      bottomSheet: 
       MiniSecondPlayer(),

      // backgroundColor: Colors.black,

      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(screens.length, (index) => screens[index]),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      // floatingActionButton: Padding(
      //   padding:  EdgeInsets.only(left: width*0.060,),
      //   child: MiniSecondPlayer(),
      // ),

      bottomNavigationBar: AnimatedNotchBottomBar(
          notchColor: const Color.fromARGB(255, 6, 30, 43),
          color: const Color(0xFF091227),
          pageController: _pageController,
          bottomBarItems: const [
            BottomBarItem(
              inActiveItem: Icon(
                Icons.home,
                color: Colors.blueGrey,
              ),
              activeItem: Icon(
                Icons.home,
                color: Colors.blueAccent,
              ),
              itemLabel: ' Home',
            ),
            BottomBarItem(
              inActiveItem: Icon(
                Icons.search,
                color: Colors.blueGrey,
              ),
              activeItem: Icon(
                Icons.search,
                color: Colors.blueAccent,
              ),
              itemLabel: ' Search',
            ),
            BottomBarItem(
              inActiveItem: Icon(
                Icons.library_add,
                color: Colors.blueGrey,
              ),
              activeItem: Icon(
                Icons.library_add,
                color: Colors.blueAccent,
              ),
              itemLabel: ' My Library',
            ),
            BottomBarItem(
              inActiveItem: Icon(
                Icons.settings,
                color: Colors.blueGrey,
              ),
              activeItem: Icon(
                Icons.settings,
                color: Colors.blueAccent,
              ),
              itemLabel: ' Settings',
            ),
          ],
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeIn,
            );
          }
          //  setState(() => _currentIndex = index);

          ),
    );
  }
}
