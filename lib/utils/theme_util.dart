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
            primaryColor: MyThemeColor.defaultColor,
            primaryColorDark: _getDarkColor(MyThemeColor.defaultColor),
            appBarTheme: getAppBarTheme(Colors.white));
        break;
      case MyTheme.darkTheme:
        return ThemeData(
            brightness: Brightness.dark,
            appBarTheme: getAppBarTheme(Colors.grey));
        break;
      case MyTheme.coffeeTheme:
        return ThemeData(
            primaryColor: MyThemeColor.coffeeColor,
            primaryColorDark: _getDarkColor(MyThemeColor.coffeeColor),
            appBarTheme: getAppBarTheme(Colors.white));
      case MyTheme.cyanTheme:
        return ThemeData(
            primaryColor: MyThemeColor.cyanColor,
            primaryColorDark: _getDarkColor(MyThemeColor.cyanColor),
            appBarTheme: getAppBarTheme(Colors.white));
        break;
      case MyTheme.purpleTheme:
        return ThemeData(
            primaryColor: MyThemeColor.purpleColor,
            primaryColorDark: _getDarkColor(MyThemeColor.purpleColor),
            appBarTheme: getAppBarTheme(Colors.white));
        break;
      case MyTheme.greenTheme:
        return ThemeData(
            primaryColor: MyThemeColor.greenColor,
            primaryColorDark: _getDarkColor(MyThemeColor.greenColor),
            appBarTheme: getAppBarTheme(Colors.white));
        break;
    }
  }

  Color _getDarkColor(Color color) {
    int red = color.red;
    int green = color.green;
    int blue = color.blue;
    return Color.fromRGBO(red, green, blue, 1);
  }

  AppBarTheme getAppBarTheme(Color color) {
    return AppBarTheme(
        iconTheme: IconThemeData(color: color),
        textTheme: TextTheme(title: TextStyle(color: color, fontSize: 20)));
  }
}

class MyTheme {
  static const String defaultTheme = "pink";
  static const String darkTheme = "dark";
  static const String coffeeTheme = "coffee";
  static const String cyanTheme = "cyan";
  static const String purpleTheme = "purple";
  static const String greenTheme = "green";
}

class MyThemeColor {
  static const Color defaultColor = Color.fromRGBO(246, 200, 200, 1);
  static const Color darkColor = Colors.grey;
  static const Color coffeeColor = Color.fromRGBO(228, 183, 160, 1);
  static const Color cyanColor = Color.fromRGBO(143, 227, 235, 1);
  static const Color greenColor = Color.fromRGBO(151, 215, 178, 1);
  static const Color purpleColor = Color.fromRGBO(205, 188, 255, 1);
}
