import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../components/custom_button.dart';
import 'Upload_Cv.dart';
import 'job_details.dart';

class GobDetailsCompany extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Job Details",
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 76,
                width: 97,
                child: Image.asset(
                  "assets/image/Google.png",
                )),
            Text(
              "Google",
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.location_pin,
                  color: Color(0xff649344),
                ),
                Text(
                  "Alex , Egypt",
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                         Flexible(
                          child: CustomButton(
                            onPressed: () {
                              Navigator.push( context,MaterialPageRoute(builder: (context) => GobDetails()));

                            },
                            name: 'Description',
                            buttonColorName: Colors.white,
                            buttonColor: Colors.grey,
                            buttonWidth: double.infinity,
                            buttonHeight: 60,
                            buttonNameSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: 36,
                        ),
                         Flexible(
                          child: CustomButton(
                            buttonNameSize: 16,
                            onPressed: () {

                            },
                            name: 'Company',
                            buttonColorName: Colors.white,
                            buttonColor: Color(0xff649344),
                            buttonHeight: 60,
                            buttonWidth: double.infinity,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:15,bottom: 15),
                      child: Text(
                        "About Company",
                        style: TextStyle(fontSize: 14, color: Color(0xff649344)),
                      ),
                    ),
                    Text(
                      '''
Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,
''',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Text(
                      "Since",
                      style: TextStyle(fontSize: 14, color: Color(0xff649344)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15,bottom: 15),
                      child: Text(
                            "15-6-1999",
                            style:
                            TextStyle(fontSize: 14, color: Colors.grey),
                          ),

                     ),

                    Text(
                      "Industry",
                      style: TextStyle(fontSize: 14, color: Color(0xff649344)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15,bottom: 15),
                      child: Text(
                        "In marketing",
                        style:
                        TextStyle(fontSize: 14, color: Colors.grey),
                      ),

                    ),

                    Text(
                      "Number of Employee",
                      style: TextStyle(fontSize: 14, color: Color(0xff649344)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15,bottom: 15),
                      child: Text(
                        "120 employer",
                        style:
                        TextStyle(fontSize: 14, color: Colors.grey),
                      ),

                    ),

                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                onPressed: () {

                  Navigator.push( context,MaterialPageRoute(builder: (context) =>    UploadCv()));

                },
                name: 'Apply Job',
                buttonColorName: Colors.white,
                buttonColor: Color(0xff649344),
                buttonHeight: 60,
                buttonWidth: double.infinity,
                buttonNameSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}