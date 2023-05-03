import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SavedJob extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              " Saved Job",
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:20,right: 7,left:7),
              child: Container(
                  height:  113,
                  width:  double.infinity,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.grey.withOpacity(.1),
                    ),
                  ]),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
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
                                      "assets/image/google (1) 1.png",
                                    )),
                                SizedBox(
                                  width: 10,
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
                                  ],
                                ),

                              ]),
                              SizedBox(
                                height: 8,
                              ),


                              Row(
                                children: const [
                                  Icon(
                                    Icons.location_pin,
                                    color: Color(0xff649344),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "Alex , EGYPT",
                                    style: TextStyle(fontSize: 18, color: Colors.grey),
                                  ),
                                  Flexible(
                                    child: SizedBox(
                                      width: double.infinity,
                                    ),
                                  ),
                                  Text(
                                   " 500\$/mo",
                                    style: TextStyle(
                                        fontSize: 18, color: Color(0xff649344)),
                                  ),
                                ],
                              )
                            ]),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),

    );
  }

}