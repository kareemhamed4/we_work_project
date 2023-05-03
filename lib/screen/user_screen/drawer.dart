import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

 import '../../components/navigation_drawer_widget.dart';
import 'home.dart';

class DrawerMyUser  extends StatelessWidget{
  @override
  final _drawerController = ZoomDrawerController();
  Widget build(BuildContext context) {
   return ZoomDrawer(
     controller: _drawerController,
     style: DrawerStyle.defaultStyle,
     menuScreen:  NavigationDrawerWidget() ,
     mainScreen:  Home(),
     borderRadius: 24.0,
     showShadow: true,
     angle: 0,
     drawerShadowsBackgroundColor: Colors.white,
     slideWidth: MediaQuery.of(context).size.width*.65,
     openCurve: Curves.fastOutSlowIn,
     closeCurve: Curves.bounceIn,
   );
  }

}