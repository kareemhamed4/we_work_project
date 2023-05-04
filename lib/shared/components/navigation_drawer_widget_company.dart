import 'package:flutter/material.dart';


class NavigationDrawerWidgetCompany extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {


    return Material(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Container(
            padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  backgroundImage: AssetImage("assets/image/google (1) 1.png"),

                ),
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
                const SizedBox(height: 15),
                buildMenuItem(
                  text: 'Number of employee',
                  icon: Icons.groups_outlined,
                  onClicked: () => selectedItem(context, 3),
                ),

                const SizedBox(height: 15),
                buildMenuItem(
                  text: 'Location',
                  icon: Icons.location_on_outlined,
                  onClicked: () => selectedItem(context, 2),
                ),

                const SizedBox(height: 15),

                buildMenuItem(
                  text: 'Adress',
                  icon: Icons.location_on_outlined,
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

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
         children: [
           Icon(icon, color: color),
           SizedBox(width: 10,),
           Flexible(child: Text(text, style: TextStyle(color: color))),

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