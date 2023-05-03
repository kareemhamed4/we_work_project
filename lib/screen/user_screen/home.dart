import 'package:flutter/material.dart';
 import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import '../../components/custom_card.dart';
 import '../../components/text_field.dart';
import 'filter.dart';

class Home extends StatefulWidget{
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top:17),
          child: IconButton(
            icon: const Icon(Icons.sort),
            color: Colors.black,
            onPressed: () {
              setState(() {
                ZoomDrawer.of(context)?.open();
              });
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15,right: 17),
            child: GestureDetector(
              child: Container(
                  height: 47,
                  width: 47,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1,
                          offset: Offset(0, 0), // Shadow position
                        ),
                      ]),
                  child: Image.asset(
                    "assets/image/Frame 34.png",
                  )),
              onTap: () {},
            ),
          )
        ],
      ),

      body: SafeArea(

        child:  SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 16, left: 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 19, bottom: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: Custom_TextFormfield(
                          is_suffixIcon: true,
                          icon_suffix: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          label_Text: "Search",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 9),
                        child: Container(
                          height: 56,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Color(0xff649344),
                              borderRadius: BorderRadius.circular(4)
                            //more than 50% of width makes circle
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.tune,
                              color: Colors.white,
                              size: 25,
                            ),
                            color: Colors.black,
                            onPressed: () {
                              pushNewScreen(
                                context,
                                screen: Filter(),
                                withNavBar: false, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation: PageTransitionAnimation.cupertino,
                              );

                              //Navigator.push( context,MaterialPageRoute(builder: (context) =>Filter()));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Available Jobs",
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff649344),
                    ),
                  ),
                ),
                CustomCard(
                  pageTitle: 'Google',
                  imageLocation: "assets/image/google (1) 1.png",
                  jobTitle: 'Flutter Developer',
                  jobDescription:
                  ' Lorem Ipsum is simply dummy text of the printing and typesetting industry. learn more',
                  salary: "500 ",
                  location: 'Alex , EGYPT',
                )
              ],
            ),
          ),
        ),
      ),




    );
  }
}