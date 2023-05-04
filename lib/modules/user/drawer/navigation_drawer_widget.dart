import 'package:flutter/material.dart';
import 'package:we_work/shared/styles/colors.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    const urlImage =
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';
    return Material(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Container(
            padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
            child: const Center(
              child: CircleAvatar(
                  radius: 30, backgroundImage: NetworkImage(urlImage)),
            ),
          ),
          Container(
            padding: padding,
            child: Column(
              children: [
                buildMenuItem(
                  isChecked: true,
                  text: 'Activity',
                  iconPath: "assets/icons/activity.png",
                  onClicked: () => selectedItem(context, 0),
                ),
                buildMenuItem(
                  isChecked: false,
                  text: 'Skills',
                  iconPath: "assets/icons/activity.png",
                  onClicked: () => selectedItem(context, 1),
                ),
                buildMenuItem(
                  isChecked: false,
                  text: 'Location',
                  iconPath: "assets/icons/location.png",
                  onClicked: () => selectedItem(context, 2),
                ),
                buildMenuItem(
                  isChecked: false,
                  text: 'Education',
                  iconPath: "assets/icons/education.png",
                  onClicked: () => selectedItem(context, 3),
                ),
                buildMenuItem(
                  isChecked: false,
                  text: 'Language',
                  iconPath: "assets/icons/language.png",
                  onClicked: () => selectedItem(context, 4),
                ),
                buildMenuItem(
                  isChecked: false,
                  text: 'Cv',
                  iconPath: "assets/icons/cv.png",
                  onClicked: () => selectedItem(context, 4),
                ),
                const SizedBox(height: 50),
                buildMenuItem(
                  isChecked: false,
                  text: 'Logout',
                  iconPath: "assets/icons/log-out.png",
                  onClicked: () => selectedItem(context, 5),
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
    VoidCallback? onClicked,
  }) {
    return Padding(
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
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => PeoplePage(),
        //));
        break;
      case 1:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => FavouritesPage(),
        // ));
        break;
    }
  }
}
