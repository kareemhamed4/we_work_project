import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:we_work/layout/layout_screen.dart';
import 'package:we_work/layout_company/layout_screen.dart';
import 'package:we_work/modules/common/login/user_login.dart';
import 'package:we_work/shared/styles/colors.dart';

class SplashScreen extends StatelessWidget {
  final bool isLoginBefore;
  final bool isCompany;
  const SplashScreen(
      {Key? key, required this.isLoginBefore, required this.isCompany})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: AnimatedSplashScreen(
        nextScreen: isLoginBefore
            ? isCompany
                ? const LayoutCompanyScreen()
                : const LayoutScreen()
            : LoginUser(),
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
                const SizedBox(
                  height: 38,
                ),
                Text(
                  "WE WORK",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontSize: 24.sp),
                ),
              ],
            ),
            if (Platform.isAndroid)
              SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  color: myFavColor5,
                  strokeWidth: 3,
                ),
              ),
            if (Platform.isIOS)
              CupertinoActivityIndicator(
                color: myFavColor5,
                radius: 15,
              ),
          ],
        ),
        splashIconSize: size.height - 50,
        backgroundColor: myFavColor,
      ),
    );
  }
}
