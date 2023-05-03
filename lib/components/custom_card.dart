import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../screen/user_screen/job_details.dart';

class CustomCard extends StatelessWidget {
  CustomCard({
    required this.salary,
    required this.location,
    required this.jobDescription,
    required this.jobTitle,
    this.nav = true,
    this.height = 162,
    this.width = double.infinity,
    required this.imageLocation,
    this.fSize = 40,
    required this.pageTitle,
  });
  String salary;
  String location;
  String imageLocation;
  String jobTitle;
  String jobDescription;
  double height;
  double width;
  double fSize;
  String pageTitle;
  bool nav;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (nav == true) {
          pushNewScreen(
            context,
            screen: GobDetails(),
            withNavBar: false, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        //  Navigator.push( context,MaterialPageRoute(builder: (context) =>      GobDetails()));
        }
      },
      child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.grey.withOpacity(.1),
            ),
          ]),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 11, left: 14),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                            height: 32,
                            width: 32,
                            child: Image.asset(
                              imageLocation,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pageTitle,
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              jobTitle,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Flexible(
                          child: SizedBox(
                            width: double.infinity,
                          ),
                        ),
                        Icon(
                          Icons.bookmark_border,
                          color: Color(0xff649344),
                        ),
                      ]),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        jobDescription,
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Color(0xff649344),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            location,
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          Flexible(
                            child: SizedBox(
                              width: 160,
                            ),
                          ),
                          Text(
                            salary,
                            style: TextStyle(
                                fontSize: 18, color: Color(0xff649344)),
                          ),
                        ],
                      )
                    ]),
              ),
            ),
          )),
    );
  }
}
