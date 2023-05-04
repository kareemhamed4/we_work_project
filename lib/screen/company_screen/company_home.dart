import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:we_work/shared/components/custom_Companycard.dart';
import 'package:we_work/shared/components/text_field.dart';
import 'company_filter.dart';


class CompanyHome extends StatefulWidget{
  @override
  State<CompanyHome> createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: Padding(
          padding: const EdgeInsets.only(top: 20),
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
            padding: const EdgeInsets.only(top:10,right: 17),
            child: GestureDetector(
              child: Container(
                  height: 50,
                  width: 48,
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
      body: SingleChildScrollView(
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
                              screen: CompanyFilter() ,
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
                  "Most Popular",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              CompanyCustomCard(
                pageTitle: 'Manar Maher',
                imageLocation: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
                jobTitle: 'UI,Ux Designer',
                location: 'Alex , EGYPT',
                timeWork: 'Full time' ,
              )
            ],
          ),
        ),
      ),




    );
  }
}