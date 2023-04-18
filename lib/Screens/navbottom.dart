import 'package:as_player/Screens/playingnow.dart';
import 'package:as_player/Screens/search.dart';
import 'package:as_player/Screens/settings.dart';
import 'package:custom_bottom_navigation_bar/custom_bottom_navigation_bar_item.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

import 'package:custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';

import 'mylibrary.dart';

class CusBottomBar extends StatefulWidget {
  const CusBottomBar({super.key});

  @override
  State<CusBottomBar> createState() => _CusBottomBarState();
}

class _CusBottomBarState extends State<CusBottomBar> {
  PageController _pageController = PageController();
    final screens = [PlayingNow(), SearchScreen(), MyLibrary(), Settings()];
int _currentIndex =0;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
       body: IndexedStack(
        index: _currentIndex,
        children: screens),
     
          
      bottomNavigationBar: CustomBottomNavigationBar(
          onTap: (index) => setState(() => _currentIndex = index),
            
        items: [
        CustomBottomNavigationBarItem(icon: Icons.home, title: 'Home'),
        CustomBottomNavigationBarItem(icon: Icons.search, title: 'Search'),
        CustomBottomNavigationBarItem(icon: Icons.library_add, title: 'Library'),
        CustomBottomNavigationBarItem(icon: Icons.settings, title: 'Settings'),
      ],
    
        
        // _pageController.animateToPage(index, duration: const Duration(milliseconds: 600), curve: Curves.fastLinearToSlowEaseIn);

      
      
      ),

    );
    
  }
}
