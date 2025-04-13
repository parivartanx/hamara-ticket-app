import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import '/extensions/media_query_ext.dart';

class HomeDrawer extends StatelessWidget {
  final ZoomDrawerController controller;
  final Widget mainScreen;
  final Widget menuScreen;

  const HomeDrawer({
    Key? key,
    required this.controller,
    required this.mainScreen,
    required this.menuScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: controller,
      borderRadius: 24,
      style: DrawerStyle.style2,
      openCurve: Curves.bounceInOut,
      disableDragGesture: true,
      mainScreenTapClose: true,
      menuScreenTapClose: true,
      // drawerShadowsBackgroundColor: Colors.black12,
      slideWidth: context.width * 0.70,
      duration: const Duration(milliseconds: 500),
      menuBackgroundColor: Colors.white24,
      showShadow: true,
      angle: 0.0,
      clipMainScreen: true,
      mainScreen: mainScreen,
      menuScreen: menuScreen,
    );
  }
}