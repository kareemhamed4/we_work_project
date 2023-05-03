import 'package:flutter/material.dart';


class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {

     final urlImage =
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

    return Material(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Container(
            padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
            child: Row(
              children: [
                CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
                SizedBox(width: 20),

              ],
            ),
          ),

          Container(
            padding: padding,
            child: Column(
              children: [

                 buildMenuItem(
                  text: 'Activity',
                  icon: Icons.local_activity_outlined,
                  onClicked: () => selectedItem(context, 0),
                ),
                const SizedBox(height: 10),
                buildMenuItem(
                  text: 'Skills',
                  icon: Icons.add,
                  onClicked: () => selectedItem(context, 1),
                ),
                const SizedBox(height: 10),
                buildMenuItem(
                  text: 'Location',
                  icon: Icons.location_on_outlined,
                  onClicked: () => selectedItem(context, 2),
                ),
                const SizedBox(height: 10),
                buildMenuItem(
                  text: 'Education',
                  icon: Icons.school_outlined,
                  onClicked: () => selectedItem(context, 3),
                ),
                const SizedBox(height: 10),

                buildMenuItem(
                  text: 'Language',
                  icon: Icons.g_translate,
                  onClicked: () => selectedItem(context, 4),
                ),
                const SizedBox(height: 10),

                buildMenuItem(
                  text: 'Cv',
                  icon: Icons.file_copy_outlined,
                  onClicked: () => selectedItem(context, 4),
                ),
                const SizedBox(height: 50),
                buildMenuItem(
                  text: 'Logout',
                  icon: Icons.power_settings_new_rounded,
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
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color =Color(0xff649344);
    final hoverColor = Colors.white70;

    return  Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(
children: [
  Icon(icon, color: color),
  SizedBox(width: 15,),
  Text(text, style: TextStyle(color: color))
],

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