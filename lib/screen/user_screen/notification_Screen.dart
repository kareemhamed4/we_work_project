import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../components/custom_button.dart';
import 'Go_To_Exam.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final urlImage =
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Notification",
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                          radius: 30, backgroundImage: NetworkImage(urlImage)),
                      SizedBox(width: 20),
                      Flexible(
                          child: Text(
                        "manar you has apply to a job AS a ui ux designer",
                        style: TextStyle(color: Colors.grey),
                      )),
                      Container(
                          height: 40,
                          width: 40,
                          child: Image.asset(
                            "assets/image/google (1) 1.png",
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Divider(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(urlImage)),
                          SizedBox(width: 20),
                          Flexible(
                              child: Text(
                            "manar you has apply to a job AS a ui ux designer",
                            style: TextStyle(color: Colors.grey),
                          )),
                          Container(
                              height: 40,
                              width: 40,
                              child: Image.asset(
                                "assets/image/google (1) 1.png",
                              ))
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: CustomButton(
                            onPressed: () {
                              //Navigator.push( context,MaterialPageRoute(builder: (context) =>   ApplicateDetails()));
                            },
                            name: 'Deny',
                            buttonColorName: Color(0xff649344),
                            buttonColor: Colors.green.shade200,
                            buttonHeight: 50,
                            buttonNameSize: 16,
                            buttonWidth: double.infinity,
                          ),
                        ),
                      ),
                       Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: CustomButton(
                            onPressed: () {

    pushNewScreen(
    context,
    screen: GoToExam(),
    withNavBar: false, // OPTIONAL VALUE. True by default.
    pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
                             },
                            name: 'Accepted',
                            buttonColorName: Colors.white,
                            buttonColor: Color(0xff649344),
                            buttonHeight: 50,
                            buttonNameSize: 16,
                            buttonWidth: double.infinity,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Divider(
                      color: Colors.grey,
                      height: 20,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                          "assets/image/google (1) 1.png",
                        ),
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(width: 20),
                      Flexible(
                          child: Text(
                        "HI,,Manar, congratulation  i hope best wishes for you ",
                        style: TextStyle(color: Colors.grey),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Divider(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
