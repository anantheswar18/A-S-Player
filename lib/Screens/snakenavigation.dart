import 'package:as_player/Screens/minisecondplayer.dart';
import 'package:as_player/Screens/search.dart';
import 'package:as_player/Screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import 'home.dart';
import 'mylibrary.dart';

class SnakeNavbarScreen extends StatefulWidget {
  const SnakeNavbarScreen({super.key});

  @override
  State<SnakeNavbarScreen> createState() => _SnakeNavbarScreenState();
}

class _SnakeNavbarScreenState extends State<SnakeNavbarScreen> {
  SnakeShape snakeShape = SnakeShape.circle;
  Color selectedColor = Color.fromARGB(255, 9, 41, 58);
  Color unselectedColor = const Color(0xFF091227);

  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  int _selectedItemPosition = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: MiniSecondPlayer(),
      body: PageView(
        controller: _pageController,
        // onPageChanged: _onpagechange,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(screens.length, (index) => screens[index]),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.pinned,
        backgroundColor: const Color(0xFF091227), 
        snakeShape: snakeShape,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        padding: EdgeInsets.only(top: 5,left: 12,right: 12,bottom: 10),
        snakeViewColor: selectedColor,
        selectedItemColor:
            snakeShape == SnakeShape.indicator ? selectedColor : null,
        unselectedItemColor: unselectedColor,
        showSelectedLabels: showSelectedLabels,
        showUnselectedLabels: showUnselectedLabels,
        currentIndex: _selectedItemPosition,
        // onTap: (index) => setState(() => _selectedItemPosition = index),
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 1), curve: Curves.bounceIn);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.blueGrey,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: Colors.blueGrey,
              ),
              label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.library_add,
                color: Colors.blueGrey,
              ),
              label: 'My Library'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: Colors.blueGrey,
              ),
              label: 'Settings'),
              
        ],
         selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
    );
  }

  void _onpagechange(int page) {
    switch (page) {
      case 0:
        setState(() {
          HomePage();
        });
        break;
      case 1:
        setState(() {
          SearchScreen();
        });
        break;
      case 2:
        setState(() {
          MyLibrary();
        });
        break;
      case 3:
        setState(() {
          Settings();
        });
        break;
    }
  }
}
