import 'package:flutter/material.dart';

const kPrimaryColor = Colors.blue;
const kAccentColor = Colors.blueAccent;

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: kPrimaryColor,
  colorScheme: ColorScheme.light(secondary: kAccentColor),
  scaffoldBackgroundColor: Colors.grey[100],
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: kPrimaryColor,
  colorScheme: ColorScheme.dark(secondary: kAccentColor),
  scaffoldBackgroundColor: Colors.grey[900],
);
