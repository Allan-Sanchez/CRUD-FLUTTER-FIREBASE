import 'package:flutter/material.dart';

final themeData = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
  ),
  scaffoldBackgroundColor: const Color(0xff2c394a),
  primaryColor: Colors.white,
  canvasColor: const Color(0xfff47b03),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xfff47b03),
  ),
  // style form
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: const TextStyle(
      color: Colors.red,
    ),
    hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
    border: const OutlineInputBorder(),
    focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.yellow, width: 2)),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2),
    ),
  ),
  textTheme: const TextTheme(
    headline4: TextStyle(
      color: Colors.white,
    ),
    headline5: TextStyle(
      color: Colors.white,
    ),
    headline6: TextStyle(
      color: Color(0xfff47b03),
    ),
    bodyText1: TextStyle(
      color: Colors.yellow,
      // fontSize: 30,
    ),
    bodyText2: TextStyle(
      color: Colors.white,
    ),
    subtitle1: TextStyle(
      color: Colors.white,
    ),
    subtitle2: TextStyle(
      color: Colors.white,
    ),
  ),
);
