import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:we_work/modules/company/home/home.dart';
import 'package:we_work/shared/components/navigation_drawer_widget_company.dart';
import 'package:we_work/shared/styles/colors.dart';

class DrawerCompany extends StatelessWidget{
  const DrawerCompany({super.key});

  @override
  Widget build(BuildContext context) {
    final drawerController = ZoomDrawerController();
   return ZoomDrawer(
     controller: drawerController,
     mainScreenOverlayColor: myFavColor6.withOpacity(0.1),
     style: DrawerStyle.style1,
     mainScreenTapClose: true,
     menuScreen: const NavigationDrawerWidgetCompany(),
     mainScreen: const CompanyHome(),
     borderRadius: 24.0,
     showShadow: true,
     angle: 0,
     drawerShadowsBackgroundColor: Colors.white,
     slideWidth: MediaQuery.of(context).size.width*.78,
     openCurve: Curves.fastOutSlowIn,
     closeCurve: Curves.bounceIn,
   );
  }

}