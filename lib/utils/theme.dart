import 'package:flutter/material.dart';

final darkTheme = ThemeData.dark();
final primaryTheme = ThemeData(
    primaryColor:  Colors.deepPurple,
    primarySwatch: Colors.red,
    brightness: Brightness.dark,
    backgroundColor: Colors.deepPurple,
    accentColor: Colors.cyan,
    scaffoldBackgroundColor: Colors.deepPurpleAccent,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
    iconTheme: IconThemeData(
        color: Colors.white
    )
);

final lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,

    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
    primaryIconTheme: IconThemeData(),
    iconTheme: IconThemeData(
        color: Colors.deepPurpleAccent
    )
);

List<ThemeName> appThemesList = [
  ThemeName('Primary Name', primaryTheme),
  ThemeName('Light Name', lightTheme),
  ThemeName('Dark Name', darkTheme)
];

class ThemeName  {
  final String themeName;
  final ThemeData themeData;
  ThemeName(this.themeName, this.themeData);
}
