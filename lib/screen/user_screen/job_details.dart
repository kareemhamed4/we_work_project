import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:we_work/screen/user_screen/Upload_Cv.dart';

import '../../components/custom_button.dart';
import 'Job_Details_Company.dart';

class GobDetails extends StatelessWidget {
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
                SizedBox(
                  width: 16,
                ),
                Icon(
                  Icons.calendar_month_sharp,
                  color: Color(0xff649344),
                ),
                Text(
                  "Full time",
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                SizedBox(
                  width: 16,
                ),
                Icon(
                  Icons.business,
                  color: Color(0xff649344),
                ),
                Text(
                  "Remotly",
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 120,
                width: double.infinity,
                child: Card(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        children: [
                          Image.asset("assets/image/positive-vote 1.png"),
                          Text(
                            "Senior",
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 80,
                      ),
                      Column(
                        children: [
                          Image.asset("assets/image/experience 1.png"),
                          Text(
                            "1-3 year",
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 80,
                      ),
                      Column(
                        children: [
                          Image.asset("assets/image/earning 1.png"),
                          Text(
                            "300\$",
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
              ),
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
                            onPressed: () {},
                            name: 'Description',
                            buttonColorName: Colors.white,
                            buttonColor: Color(0xff649344),
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
                              Navigator.push( context,MaterialPageRoute(builder: (context) => GobDetailsCompany()));

                            },
                            name: 'Company',
                            buttonColorName: Colors.white,
                            buttonColor: Colors.grey,
                            buttonHeight: 60,
                            buttonWidth: double.infinity,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:15,bottom: 15),
                      child: Text(
                        "Job Description",
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
                      "Job Requirment",
                      style: TextStyle(fontSize: 14, color: Color(0xff649344)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff649344)),
                          ),
                          SizedBox(
                            width: 13,
                          ),
                          Flexible(
                            child: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff649344)),
                          ),
                          SizedBox(
                            width: 13,
                          ),
                          Flexible(
                            child: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff649344)),
                          ),
                          SizedBox(
                            width: 13,
                          ),
                          Flexible(
                            child: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ),
                        ],
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
                  Navigator.push( context,MaterialPageRoute(builder: (context) =>     UploadCv()));
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
