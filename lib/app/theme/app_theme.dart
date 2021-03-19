import 'package:flutter/material.dart';

const firstColor = Colors.black;
const secondColor = Colors.white;
const thirdColor = Colors.blueGrey;
const fourthColor = Color(0xFF1282A2);
const fifthColor = Color(0xFFFEFCFB);

final ThemeData appThemeData = ThemeData(
  visualDensity: VisualDensity.comfortable,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: firstColor,
  primaryColor: secondColor,
  accentColor: thirdColor,
  appBarTheme: AppBarTheme(
    elevation: 0.0,
    backgroundColor: firstColor,
    titleTextStyle: TextStyle(
      color: fourthColor,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: secondColor,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
    iconTheme: IconThemeData(
      color: secondColor,
    ),
    actionsIconTheme: IconThemeData(
      color: secondColor,
    ),
  ),
);
