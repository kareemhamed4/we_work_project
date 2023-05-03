import 'package:flutter/material.dart';
import 'package:we_work/screen/other%20screens/onboarding-screen.dart';
 void main() {
   runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Color(0xff649344)
          ),
          iconTheme: IconThemeData(color: Color(0xff649344)),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        primaryColor: const Color(0xff649344),
      ),
      home: Onboarding(),
    );
  }
}
