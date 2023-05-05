import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:we_work/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  cardColor: myFavColor5,
  primaryColor: myFavColor,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.fromSwatch().copyWith(primary: myFavColor),
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
    bodyText1: TextStyle(fontFamily: "Roboto-Medium", color: myFavColor6),
    bodyText2: TextStyle(fontFamily: "Roboto-Medium", color: myFavColor7,fontSize: 16),
    subtitle1: TextStyle(fontFamily: "Roboto-Light", color: myFavColor6),
    subtitle2: TextStyle(fontFamily: "Roboto-Medium", color: myFavColor6),
    headline5: TextStyle(fontFamily: "Roboto-Medium", color: myFavColor6),
    headline6: TextStyle(fontFamily: "Roboto-Medium", color: myFavColor6),
    caption: TextStyle(fontFamily: "OpenSans", color: myFavColor4),
    button: TextStyle(fontFamily: "Roboto-Medium", color: myFavColor5),
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
