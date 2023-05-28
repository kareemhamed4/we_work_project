import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:we_work/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  cardColor: myFavColor5,
  primaryColor: myFavColor,
  colorScheme: ColorScheme.fromSwatch(
    accentColor: myFavColor.withOpacity(0.4),
  ),
  scaffoldBackgroundColor: Colors.white,
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder:
        OutlineInputBorder(borderSide: BorderSide(color: myFavColor7)),
    border: OutlineInputBorder(
        borderSide: BorderSide(color: myFavColor.withOpacity(0.5))),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: myFavColor4),
    ),
  ),
  buttonTheme: ButtonThemeData(
      shape: OutlineInputBorder(borderSide: BorderSide(color: myFavColor4))),
  iconTheme: IconThemeData(
    color: myFavColor,
  ),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: myFavColor,
    ),
    color: Colors.white,
    systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark),
    elevation: 0,
  ),
  unselectedWidgetColor: myFavColor7,
  textTheme: TextTheme(
    bodyLarge: TextStyle(fontFamily: "Roboto-Medium", color: myFavColor6,fontSize: 18.sp),
    bodyMedium: TextStyle(fontFamily: "Roboto-Medium", color: myFavColor7,fontSize: 16.sp),
    headlineSmall: TextStyle(fontFamily: "Roboto-Medium", color: myFavColor6,fontSize: 24.sp),
    titleLarge: TextStyle(fontFamily: "Roboto-Medium", color: myFavColor6,fontSize: 22.sp),
    bodySmall: TextStyle(fontFamily: "OpenSans", color: myFavColor4,fontSize: 14.sp),
    labelLarge: TextStyle(fontFamily: "Roboto-Medium", color: myFavColor5,fontSize: 16.sp),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: myFavColor,
    elevation: 0,
    selectedIconTheme: IconThemeData(color: myFavColor5),
    unselectedIconTheme: IconThemeData(color: myFavColor5),
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: false,
    showUnselectedLabels: false,
  ),
);
