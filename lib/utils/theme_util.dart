import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/theme_bean.dart';
import 'package:todo_list/utils/shared_util.dart';

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
    ThemeBean themeBean,
  ) {
    return _getThemeData(
        ColorBean.fromBean(themeBean.colorBean), themeBean.themeType);
  }

  ThemeData _getThemeData(Color color, String themeType) {
    if (themeType == MyTheme.darkTheme) {
      return ThemeData(
        brightness: Brightness.dark,
        appBarTheme: getAppBarTheme(Colors.grey[800], Colors.grey),
        scaffoldBackgroundColor: Colors.grey[800],
      );
    }
    return ThemeData(
      primaryColor: color,
      primaryColorDark: getDarkColor(color),
      primaryColorLight: getLightColor(color),
      appBarTheme: getAppBarTheme(color, Colors.white),
    );
  }

  Color getDarkColor(Color color) {
    int number = 20;
    int red = color.red - number <= 0 ? color.red : color.red - number;
    int green = color.green - number <= 0 ? color.green : color.green - number;
    int blue = color.blue - number <= 0 ? color.blue : color.blue - number;
    return Color.fromRGBO(red, green, blue, 1);
  }

  Color getLightColor(Color color) {
    int number = 30;
    int red = color.red + number >= 255 ? color.red : color.red + number;
    int green =
        color.green + number >= 255 ? color.green : color.green + number;
    int blue = color.blue + number >= 255 ? color.blue : color.blue + number;
    return Color.fromRGBO(red, green, blue, 1);
  }

  AppBarTheme getAppBarTheme(Color bgColor, Color iconColor) {
    return AppBarTheme(
      iconTheme: IconThemeData(color: iconColor),
      color: bgColor,
      elevation: 0.0,
      textTheme: TextTheme(
        subtitle1: TextStyle(color: iconColor, fontSize: 20),
      ),
    );
  }

  List<ThemeBean> defaultThemeBeans(BuildContext context) => [
        ThemeBean(
          themeName: IntlLocalizations.of(context).pink,
          colorBean: ColorBean.fromColor(MyThemeColor.defaultColor),
          themeType: MyTheme.defaultTheme,
        ),
        ThemeBean(
          themeName: IntlLocalizations.of(context).dark,
          colorBean: ColorBean.fromColor(MyThemeColor.darkColor),
          themeType: MyTheme.darkTheme,
        ),
        ThemeBean(
          themeName: IntlLocalizations.of(context).coffee,
          colorBean: ColorBean.fromColor(MyThemeColor.coffeeColor),
          themeType: MyTheme.coffeeTheme,
        ),
        ThemeBean(
          themeName: IntlLocalizations.of(context).green,
          colorBean: ColorBean.fromColor(MyThemeColor.greenColor),
          themeType: MyTheme.greenTheme,
        ),
        ThemeBean(
          themeName: IntlLocalizations.of(context).purple,
          colorBean: ColorBean.fromColor(MyThemeColor.purpleColor),
          themeType: MyTheme.purpleTheme,
        ),
        ThemeBean(
          themeName: IntlLocalizations.of(context).cyan,
          colorBean: ColorBean.fromColor(MyThemeColor.cyanColor),
          themeType: MyTheme.cyanTheme,
        ),
        ThemeBean(
          themeName: IntlLocalizations.of(context).blueGray,
          colorBean: ColorBean.fromColor(MyThemeColor.blueGrayColor),
          themeType: MyTheme.blueGrayTheme,
        ),
      ];

  Future<List<ThemeBean>> getThemeListWithCache(BuildContext context) async {
    List<String> strings = await SharedUtil.instance.readList(Keys.themeBeans);
    List<ThemeBean> list = [];
    for (var o in strings) {
      final data = jsonDecode(o);
      ThemeBean themeBean = ThemeBean.fromMap(data);
      list.add(themeBean);
    }
    final defaultList = defaultThemeBeans(context);
    return List.from(defaultList + list);
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
  static const String random = "random";
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
