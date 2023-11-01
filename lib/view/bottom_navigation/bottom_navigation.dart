import 'package:flutter/material.dart';
import 'package:news_app/utils/color_constants/color_constants.dart';
import 'package:news_app/view/all-news_screen/all-news_screen.dart';
import 'package:news_app/view/home_screen/home_screen.dart';
import 'package:news_app/view/search_screen/search_screen.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  final List pages = [
    HomeScreen(),
    SearchScreen(),
    NewsScreen(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
            onTap: _onItemTap,
            currentIndex: _selectedIndex,
            backgroundColor: ColorConstants.backgroundColor,
            selectedItemColor: ColorConstants.bannerColor,
            unselectedItemColor: ColorConstants.primaryTxtColor,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
                  BottomNavigationBarItem(
                  icon: Icon(Icons.newspaper), label: 'All News'),
            ]));
  }
}
