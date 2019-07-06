import 'package:flutter/material.dart';

class ThemeUtil {
  static ThemeUtil _instance;

  static ThemeUtil getInstance() {
    if (_instance == null) {
      _instance = ThemeUtil._internal();
    }
    return _instance;
  }

  ThemeUtil._internal();

  ThemeData getTheme(
    String themeName,
  ) {
    switch (themeName) {
      case MyTheme.defaultTheme:
        return ThemeData(
            primaryColor: Color.fromRGBO(246, 200, 200, 1),
            primaryColorDark: Color.fromRGBO(255, 180, 180, 1),
            appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: Colors.white),
                textTheme: TextTheme(
                    title: TextStyle(color: Colors.white, fontSize: 20))));
        break;
      case MyTheme.darkTheme:
        return ThemeData(
            brightness: Brightness.dark,
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Colors.grey),
                textTheme: TextTheme(
                    title: TextStyle(color: Colors.grey, fontSize: 20))));
        break;
    }
  }
}

class MyTheme {
  static const String defaultTheme = "pink";
  static const String darkTheme = "dark";
}
