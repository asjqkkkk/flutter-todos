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
        return _getThemeData(MyThemeColor.defaultColor);
        break;
      case MyTheme.darkTheme:
        return ThemeData(
            brightness: Brightness.dark,
            appBarTheme: getAppBarTheme(Colors.grey));
        break;
      case MyTheme.coffeeTheme:
        return _getThemeData(MyThemeColor.coffeeColor);
      case MyTheme.cyanTheme:
        return _getThemeData(MyThemeColor.cyanColor);
        break;
      case MyTheme.purpleTheme:
        return _getThemeData(MyThemeColor.purpleColor);
        break;
      case MyTheme.greenTheme:
        return _getThemeData(MyThemeColor.greenColor);
        break;
      case MyTheme.blueGrayTheme:
        return _getThemeData(MyThemeColor.blueGrayColor);
        break;
    }
  }

  ThemeData _getThemeData(Color color) {
    return ThemeData(
        primaryColor: color,
        primaryColorDark: _getDarkColor(color),
        primaryColorLight: _getLightColor(color),
        appBarTheme: getAppBarTheme(Colors.white));
  }

  Color _getDarkColor(Color color) {
    int red = color.red - 20 <= 0 ? color.red : color.red - 20;
    int green = color.green - 20 <= 0 ? color.green : color.green - 20;
    int blue = color.blue - 20 <= 0 ? color.blue : color.blue - 20;
    return Color.fromRGBO(red, green, blue, 1);
  }

  Color _getLightColor(Color color) {
    int red = color.red + 20 >= 255 ? color.red : color.red + 20;
    int green = color.green + 20 >= 255 ? color.green : color.green + 20;
    int blue = color.blue + 20 >= 255 ? color.blue : color.blue + 20;
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
  static const String blueGrayTheme = "blueGray";
}

class MyThemeColor {
  static const Color defaultColor = Color.fromRGBO(246, 200, 200, 1);
  static const Color darkColor = Colors.grey;
  static const Color coffeeColor = Color.fromRGBO(228, 183, 160, 1);
  static const Color cyanColor = Color.fromRGBO(143, 227, 235, 1);
  static const Color greenColor = Color.fromRGBO(151, 215, 178, 1);
  static const Color purpleColor = Color.fromRGBO(205, 188, 255, 1);
  static const Color blueGrayColor = Color.fromRGBO(135, 170, 171, 1);
}
