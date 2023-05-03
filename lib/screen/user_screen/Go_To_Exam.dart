import 'package:flutter/material.dart';

import '../../components/custom_button.dart';
import 'exam_Form.dart';

class GoToExam extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            child: Image.asset("assets/image/Congratulation.png"),
          ),
          Text("Congratulation",style: TextStyle(color: Color(0xff649344)),),
          Text("Welcome and thank you for accepting our offer" ),
SizedBox(height: 180,),
          Padding(
            padding: const EdgeInsets.all(8),
            child: CustomButton(
              onPressed: () {
                Navigator.push( context,MaterialPageRoute(builder: (context) =>   ExamForm()));
              },
              name: 'Go To Exam',
              buttonColorName: Colors.white,
              buttonColor: Color(0xff649344),
              buttonHeight: 60,
              buttonNameSize: 16,
              buttonWidth: double.infinity,
            ),
          ),
        ],
      ),
    );
  }


}