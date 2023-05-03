import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AcpetedPeople extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

        ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text( "  Aceepted",style: TextStyle(color: Color(0xff649344),fontSize: 17),),
              Container(
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
                                    height: 40,
                                    width: 40,
                                    child: CircleAvatar(radius:50, backgroundImage: NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',))),
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
                                SizedBox(width: 100,),
                                Text( "Aceepted",style: TextStyle(color: Color(0xff649344)),)

                              ]),

                             ]),
                      ),
                    ),
                  )),
              SizedBox(height: 80,),
              Text( "  Not Accepted",style: TextStyle(color: Color(0xff649344),fontSize: 17),),
              Container(
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
                                    height: 40,
                                    width: 40,
                                    child: CircleAvatar(radius:50, backgroundImage: NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',))),
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
                                SizedBox(width: 100,),
                                Text( "Refused",style: TextStyle(color: Colors.red),)

                              ]),

                            ]),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),

    );
  }

}