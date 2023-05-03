 import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/custom_button.dart';

class ApplicateDetails extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Upload Cv      ",
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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.grey.shade300,),

                ),

                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                            height: 32,
                            width: 32,
                            child: Image.asset(
                              "assets/image/google (1) 1.png",
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Google",
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "UI,Ux Designer",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "This job posted in 10 dec 2022",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),

                      ]),
                      SizedBox(height: 10,),
                      Divider(color: Colors.grey,),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Job Details",
                        style: TextStyle(fontSize: 15, color: Color(0xff649344)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Color(0xff649344),
                          ),
                          Text(
                            "Alex , EGYPT",
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(
                      height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month_sharp,
                            color: Color(0xff649344),
                          ),
                          Text(
                            "Full time",
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
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
                        height: 15,
                      ),
                      Text(
                        "CV Resume",
                        style: TextStyle(fontSize: 15, color: Color(0xff649344)),
                      )
                ,SizedBox(height: 20,),

                Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: Colors.grey.shade300,),

                        ),
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                             children: [
                              Image.asset("assets/image/pdf 1.png"),
                              SizedBox(width: 10,)
                              , Text("Manar cv ui ux designer")
                            ],
                          ),
                        ),
                      ),                  SizedBox(height: 20,),

                      Text(
                        "Interview Details",
                        style: TextStyle(fontSize: 15, color: Color(0xff649344)),
                      ),
                      SizedBox(height: 20,),
Row(
  children: [
    Icon(
      Icons.update,
      color: Color(0xff649344),
    ),
    Text(
      "12:00Am",
      style: TextStyle(fontSize: 15, color: Colors.grey),
    ),

    SizedBox(width: 20,),
    Icon(
      Icons.calendar_month_sharp,
      color: Color(0xff649344),
    ),
    Text(
      "13 dec 2022",
      style: TextStyle(fontSize: 15, color: Colors.grey),
    ),
  ],
)
                      ,

                      ]
                  ),
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(right: 8,left: 8,top:50),
              child: CustomButton(
                onPressed: () {

                  // Navigator.push( context,MaterialPageRoute(builder: (context) =>   ApplicateDetails()));

                },
                name: 'Online Meeting',
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