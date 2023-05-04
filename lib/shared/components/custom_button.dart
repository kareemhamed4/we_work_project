 import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    required this.onPressed,
    required this.buttonColor,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.name,
    required this.buttonColorName,
    required this.buttonNameSize
  });
  final GestureTapCallback onPressed;
  double buttonWidth;
  double buttonNameSize;
  double buttonHeight;
Color buttonColor;
  Color buttonColorName;
String name;
  @override
  Widget build(BuildContext context) {
    return   ElevatedButton(

      style:
      ButtonStyle(
      //  maximumSize:MaterialStateProperty.all(const Size(400,100)),
        minimumSize: MaterialStateProperty.all(  Size(buttonWidth,buttonHeight)),
        backgroundColor:MaterialStateProperty.all<Color>(buttonColor),
        textStyle: MaterialStateProperty.resolveWith((states) {

            return TextStyle(fontSize: buttonNameSize, );

        }),
      ) ,
      child:Text(name,style: TextStyle(color: buttonColorName),),
      onPressed:onPressed,
    );
  }
}