import 'package:flutter/material.dart';
import 'custom_button.dart';

class CompanyCustomCard extends StatelessWidget {
  CompanyCustomCard({
    required this.timeWork,
    required this.location,
     required this.jobTitle,
    this.nav = true,
    this.height = 162,
    this.width = double.infinity,
    required this.imageLocation,
    this.fSize = 40,
    required this.pageTitle,
  });
  String location;
  String timeWork;
  String imageLocation;
  String jobTitle;
   double height;
  double width;
  double fSize;
  String pageTitle;
  bool nav;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

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
                            height:40,
                            width: 40,
                            child: CircleAvatar(radius:50, backgroundImage: NetworkImage(imageLocation))),
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
                        SizedBox(
                          width:50,
                        ),
Container(
    height: 25,
    width: 25,
    child: Image.asset("assets/image/pdf 1.png")),
                        Text("Show cv",style: TextStyle(
                            decoration: TextDecoration.underline,
                            color:Color(0xff649344) ),)
                      ]),

                      SizedBox(
                        height: 13,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Color(0xff649344),
                          ),

                          Text(
                            location,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),

                          Icon(
                            Icons.calendar_month_outlined,
                            color: Color(0xff649344),
                          ),

                          Text(
                            timeWork,
                            style: TextStyle(fontSize:12, color: Colors.grey),
                          ),



                          Padding(
                            padding: const EdgeInsets.all(7),
                            child: CustomButton(
                              onPressed: () {
                               // Navigator.push( context,MaterialPageRoute(builder: (context) =>  NextExamForm()));
                              },
                              name: 'Create offor',
                              buttonColorName: Colors.white,
                              buttonColor: Color(0xff649344),
                              buttonHeight:40,
                              buttonNameSize:12,
                              buttonWidth:50,
                            ),
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
