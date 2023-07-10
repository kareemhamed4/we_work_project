/*
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:we_work/modules/user/drawer/navigation_drawer_widget.dart';
import 'package:we_work/modules/user/home/home.dart';
import 'package:we_work/shared/styles/colors.dart';

class DrawerMyUser extends StatelessWidget {
  DrawerMyUser({super.key});
  final _drawerController = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: _drawerController,
      mainScreenOverlayColor: myFavColor6.withOpacity(0.1),
      mainScreenTapClose: true,
      style: DrawerStyle.style1,
      menuScreen: const NavigationDrawerWidget(),
      mainScreen: const UserHomeScreen(),
      borderRadius: 24.0,
      showShadow: true,
      angle: 0,
      drawerShadowsBackgroundColor: myFavColor5,
      slideWidth: MediaQuery.of(context).size.width * .85,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
    );
  }
}
*/
