import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:we_work/shared/styles/colors.dart';

class NavigationDrawerWidgetCompany extends StatefulWidget {
  const NavigationDrawerWidgetCompany({super.key});

  @override
  State<NavigationDrawerWidgetCompany> createState() =>
      _NavigationDrawerWidgetCompanyState();
}

class _NavigationDrawerWidgetCompanyState
    extends State<NavigationDrawerWidgetCompany> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    Size size = MediaQuery.of(context).size;
    return Material(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Container(
            padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
            child: Center(
              child: SvgPicture.asset("assets/image/google.svg"),
            ),
          ),
          Container(
            padding: padding,
            child: Column(
              children: [
                buildMenuItem(
                  isChecked: currentIndex == 0 ? true : false,
                  text: 'Activity',
                  iconPath: "assets/icons/activity.png",
                  onTap: () {
                    setState(() {
                      currentIndex = 0;
                    });
                  },
                ),
                buildMenuItem(
                  isChecked: currentIndex == 1 ? true : false,
                  text: 'Number of employee',
                  iconPath: "assets/icons/activity.png",
                  onTap: () {
                    setState(() {
                      currentIndex = 1;
                    });
                  },
                ),
                buildMenuItem(
                  isChecked: currentIndex == 2 ? true : false,
                  text: 'Location',
                  iconPath: "assets/icons/location.png",
                  onTap: () {
                    setState(() {
                      currentIndex = 2;
                    });
                  },
                ),
                buildMenuItem(
                  isChecked: currentIndex == 3 ? true : false,
                  text: 'Address',
                  iconPath: "assets/icons/education.png",
                  onTap: () {
                    setState(() {
                      currentIndex = 3;
                    });
                  },
                ),
                SizedBox(height: size.height * 150 / size.height),
                buildMenuItem(
                  isChecked: currentIndex == 4 ? true : false,
                  text: 'Logout',
                  iconPath: "assets/icons/log-out.png",
                  onTap: () {
                    setState(() {
                      currentIndex = 4;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required String iconPath,
    required bool isChecked,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: isChecked ? myFavColor2 : myFavColor5,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: [
                Image.asset(iconPath),
                const SizedBox(
                  width: 15,
                ),
                Text(text, style: TextStyle(color: myFavColor))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
