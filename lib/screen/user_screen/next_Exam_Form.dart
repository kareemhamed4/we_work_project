import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_radio_button/group_radio_button.dart';

import '../../components/custom_button.dart';
 import 'body_of_Bottom_Navigation_Bar.dart';


class NextExamForm extends StatefulWidget{
  @override
  State<NextExamForm> createState() => _NextExamFormState();
}

class _NextExamFormState extends State<NextExamForm> {
  @override
  Widget build(BuildContext context) {
    String  _verticalGroupValue1="Yes";
    List<String> _status1=["Yes","No"];

    String  _verticalGroupValue2="Yes";
    List<String> _status2=["Yes","No"];

    String  _verticalGroupValue3="Yes";
    List<String> _status3=["Yes","No"];

    String  _verticalGroupValue4="Yes";
    List<String> _status4=["Yes","No"];
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Exam Form",
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Do You Work on secket io?',
                style: GoogleFonts.roboto(

                  fontWeight: FontWeight.w600,

                  color: Color(0xb5686868),
                ),
              ),
              RadioGroup<String>.builder(
                fillColor:Color(0xff649344) ,
                groupValue: _verticalGroupValue1,
                onChanged: (value) => setState(() {
                  _verticalGroupValue1 = value!;
                }),
                items: _status1,
                itemBuilder: (item) => RadioButtonBuilder(
                  item,
                ),
              ),

              Text(
                'Do You Work on ML Moduel?',
                style: GoogleFonts.roboto(

                  fontWeight: FontWeight.w600,

                  color: Color(0xb5686868),
                ),
              ),
              RadioGroup<String>.builder(
                fillColor:Color(0xff649344) ,
                groupValue:_verticalGroupValue2 ,
                onChanged: (value) => setState(() {
                  _verticalGroupValue2  = value!;
                }),
                items: _status2 ,
                itemBuilder: (item) => RadioButtonBuilder(
                  item,
                ),
              )



              ,Text(
                'Do You have experience in animation?',
                style: GoogleFonts.roboto(

                  fontWeight: FontWeight.w600,

                  color: Color(0xb5686868),
                ),
              ),
              RadioGroup<String>.builder(
                fillColor:Color(0xff649344) ,
                groupValue: _verticalGroupValue3,
                onChanged: (value) => setState(() {
                  _verticalGroupValue3 = value!;
                }),
                items: _status3,
                itemBuilder: (item) => RadioButtonBuilder(
                  item,
                ),
              ),


              Text(
                'Do you known  responsive ui?',
                style: GoogleFonts.roboto(

                  fontWeight: FontWeight.w600,

                  color: Color(0xb5686868),
                ),
              ),
              RadioGroup<String>.builder(
                fillColor:Color(0xff649344) ,
                groupValue: _verticalGroupValue4,
                onChanged: (value) => setState(() {
                  _verticalGroupValue4 = value!;
                }),
                items: _status4,
                itemBuilder: (item) => RadioButtonBuilder(
                  item,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: CustomButton(
                  onPressed: () {
                    Navigator.push( context,MaterialPageRoute(builder: (context) =>   BodyOfBottomNavigationBar()));
                  },
                  name: 'Send',
                  buttonColorName: Colors.white,
                  buttonColor: Color(0xff649344),
                  buttonHeight: 60,
                  buttonNameSize: 20,
                  buttonWidth: double.infinity,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}