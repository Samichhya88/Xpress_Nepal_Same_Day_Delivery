// ignore_for_file: file_names

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final List<String>? labels;
  final List<IconData> icons;
  const NavBar(
      {super.key,
      required this.navigationShell,
      this.labels,
      required this.icons});

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
      height: 70,
      safeAreaValues: SafeAreaValues(bottom: false, top: false),
      splashRadius: 3,
      splashSpeedInMilliseconds: 900,
      scaleFactor: 1,
      activeIndex: navigationShell.currentIndex,
      elevation: 0,
      backgroundColor: Color.fromARGB(255, 240, 239, 239),
      itemCount: icons.length,
      tabBuilder: (int index, bool isActive) {
        return Icon(
          icons[index],
          size: 26,
          color: isActive ? Color.fromARGB(255, 224, 177, 36) : Colors.grey,
        );
      },
      onTap: (int index) => _onTap(context, index),
      gapLocation: GapLocation.none,
      notchSmoothness: NotchSmoothness.smoothEdge,
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(index,
        initialLocation: index == navigationShell.currentIndex);
  }
}
