import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_radio_button/group_radio_button.dart';

import '../../components/custom_button.dart';
import '../../components/text_field.dart';
import 'next_Exam_Form.dart';

class ExamForm extends StatefulWidget{
  @override
  State<ExamForm> createState() => _ExamFormState();
}

class _ExamFormState extends State<ExamForm> {
  @override
  Widget build(BuildContext context) {
    TextEditingController? textMessageController;
    String? messageEntrer;
    String  _verticalGroupValue="Yes";
    List<String> _status=["Yes","No"];

    String  _verticalGroupValue0="Yes";
    List<String> _status0=["Yes","No"];

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
          'Email',
          style: GoogleFonts.roboto(

            fontWeight: FontWeight.w600,

            color: Color(0xb5686868),
          ),
        ),
    Custom_TextFormfield(
        scure: true,
    ),
            SizedBox(height: 20,),

            Text(
              'Full_Name',
              style: GoogleFonts.roboto(

                fontWeight: FontWeight.w600,

                color: Color(0xb5686868),
              ),
            ),
            Custom_TextFormfield(
              scure: true,
            ),
            SizedBox(height: 20,),


            Text(
              'Experience in flutter',
              style: GoogleFonts.roboto(

                fontWeight: FontWeight.w600,

                color: Color(0xb5686868),
              ),
            ),
            Custom_TextFormfield(
              scure: true,
            ),
            SizedBox(height: 20,),


            Text(
              'Experience in programming',
              style: GoogleFonts.roboto(

                fontWeight: FontWeight.w600,

                color: Color(0xb5686868),
              ),
            ),
            Custom_TextFormfield(
              scure: true,
            ),
            SizedBox(height: 20,),


            Text(
              'Number of projects in google play',
              style: GoogleFonts.roboto(

                fontWeight: FontWeight.w600,

                color: Color(0xb5686868),
              ),
            ),
            Custom_TextFormfield(
              scure: true,
            ),
            SizedBox(height: 20,),
            Text(
              'Do You Work With restful app?',
              style: GoogleFonts.roboto(

                fontWeight: FontWeight.w600,

                color: Color(0xb5686868),
              ),
            ),
            RadioGroup<String>.builder(
              fillColor:Color(0xff649344) ,
              groupValue: _verticalGroupValue,
              onChanged: (value) => setState(() {
                _verticalGroupValue = value!;
              }),
              items: _status,
              itemBuilder: (item) => RadioButtonBuilder(
                item,
              ),
            ),
            Text(
              'What State mangment deal with this?',
              style: GoogleFonts.roboto(

                fontWeight: FontWeight.w600,

                color: Color(0xb5686868),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              height:120,
              width: double.infinity,
              child: TextField(
                controller: textMessageController,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                minLines: 1,
                maxLines: null,
                onChanged: ((value) {
                  setState(() {
                    messageEntrer = value;
                  });
                }),
                decoration: InputDecoration(

                  hintMaxLines: 1,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  hintStyle: TextStyle(
                    fontSize: 16,
                  ),
                  fillColor: Colors.white,
                  filled: false,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: .2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 0.2,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              'Do You Work on google map?',
              style: GoogleFonts.roboto(

                fontWeight: FontWeight.w600,

                color: Color(0xb5686868),
              ),
            ),
            RadioGroup<String>.builder(
              fillColor:Color(0xff649344) ,
              groupValue: _verticalGroupValue0,
              onChanged: (value) => setState(() {
                _verticalGroupValue0 = value!;
              }),
              items: _status0,
              itemBuilder: (item) => RadioButtonBuilder(
                item,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8),
              child: CustomButton(
                onPressed: () {
                  Navigator.push( context,MaterialPageRoute(builder: (context) =>  NextExamForm()));
                },
                name: 'Next',
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