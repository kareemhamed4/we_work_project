import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'acpeted_people.dart';
import 'companyProfile.dart';
import 'company_notification_Screen.dart';
import 'drawer_company.dart';


class CompanyBodyOfBottomNavigationBar extends StatefulWidget {
  @override
  State<CompanyBodyOfBottomNavigationBar> createState() => _CompanyBodyOfBottomNavigationBarState();
}


class _CompanyBodyOfBottomNavigationBarState extends State<CompanyBodyOfBottomNavigationBar> {
  PersistentTabController _controller=PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreens() {

    return [
      DrawerCopany(),
      CompanNotificationScreen(),
      AcpetedPeople(),
      CompanyProfile()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_outlined),
        title: "Home",
        inactiveColorPrimary: Colors.white,
        activeColorPrimary: Colors.white

      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.notifications_none),
        title: "Notification",

          inactiveColorPrimary: Colors.white,
          activeColorPrimary: Colors.white

       ),
      PersistentBottomNavBarItem(
        icon: Icon( Icons.favorite_border),
        title: "SavedJob",

          inactiveColorPrimary: Colors.white,
          activeColorPrimary: Colors.white

       ),

      PersistentBottomNavBarItem(
        icon: Icon(Icons.person_outline),
        title: "MyProfile",

          inactiveColorPrimary: Colors.white,
          activeColorPrimary: Colors.white

       ),




    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      bottomNavigationBar: PersistentTabView(
        context,

        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Color(0xff649344), // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
           colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: false,
        popActionScreens: PopActionScreensType.once,
        itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style12, // Choose the nav bar style with this property.
      ),

    );
  }
}
