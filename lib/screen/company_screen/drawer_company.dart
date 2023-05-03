import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../components/navigation_drawer_widget_company.dart';
import 'company_home.dart';

class DrawerCopany extends StatelessWidget{
  @override
  final _drawerController = ZoomDrawerController();
  Widget build(BuildContext context) {
   return ZoomDrawer(
     controller: _drawerController,
     style: DrawerStyle.defaultStyle,
     menuScreen:  NavigationDrawerWidgetCompany(),
     mainScreen: CompanyHome(),
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