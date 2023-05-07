import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_work/modules/common/onboarding/onboarding-screen.dart';
import 'package:we_work/shared/styles/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedSplashScreen(
      nextScreen: const Onboarding(),
      splash: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                  "assets/image/Frame 34.png",
                width: 120,
                height: 114,
              ),
              const SizedBox(height: 38,),
              Text(
                "WE WORK",
                style: Theme.of(context).textTheme.button!.copyWith(fontSize: 24),
              ),
            ],
          ),
          if(Platform.isAndroid)
            CupertinoActivityIndicator(
              color: myFavColor5,
              radius: 15,
            ),
          if(Platform.isIOS)
            CupertinoActivityIndicator(
              color: myFavColor5,
              radius: 15,
            ),
        ],
      ),
      splashIconSize: size.height - 50,
      backgroundColor: myFavColor,
    );
  }
}
