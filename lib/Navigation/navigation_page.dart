import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hand_one/BookMark/bookmark_page.dart';
import 'package:hand_one/Home_Tab/home_tab_bar_page.dart';
import 'package:hand_one/Maps/google_map.dart';

class BottomNavigationPage extends ConsumerStatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  BottomNavigationState createState() => BottomNavigationState();
}

class BottomNavigationState extends ConsumerState<BottomNavigationPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedIndex: currentIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'ホーム',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_outline),
            label: 'ブックマーク',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.map),
            icon: Icon(Icons.map_outlined),
            label: '地図',
          ),
        ],
      ),
      body: <Widget>[
        const HomeTabBarPage(),
        const BookmarkList(),
        const GoogleMapPage(),
      ][currentIndex],
    );
  }
}
