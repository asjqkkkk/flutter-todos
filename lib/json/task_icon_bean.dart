import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TaskIconBean {
  String taskName;
  IconBean iconBean;
  ColorBean colorBean;

  TaskIconBean({this.taskName, this.iconBean, this.colorBean});

  static TaskIconBean fromMap(Map<String, dynamic> map) {
    TaskIconBean bean = new TaskIconBean();
    bean.taskName = map['taskName'];
    bean.colorBean = ColorBean.fromMap(map['colorData']);
    bean.iconBean = IconBean.fromMap(map['iconData']);
    return bean;
  }

  static List<TaskIconBean> fromMapList(dynamic mapList) {
    List<TaskIconBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class ColorBean {
  int red;
  int green;
  int blue;
  double opacity;

  ColorBean({this.red, this.green, this.blue, this.opacity});

  static Color fromBean(ColorBean bean) =>
      Color.fromRGBO(bean.red, bean.green, bean.blue, bean.opacity);

  static ColorBean fromMap(Map<String, dynamic> map) {
    ColorBean bean = new ColorBean();
    bean.red = int.parse(map['red']);
    bean.green = int.parse(map['green']);
    bean.blue = int.parse(map['blue']);
    bean.opacity = double.parse(map['opacity']);
    return bean;
  }

  static ColorBean fromColor(Color color) {
    ColorBean colorData = ColorBean();
    colorData.opacity = color.opacity;
    colorData.red = color.red;
    colorData.green = color.green;
    colorData.blue = color.blue;
    return colorData;
  }
}


class IconBean {
  int codePoint;
  String fontFamily;
  String fontPackage;
  bool matchTextDirection;

  IconBean(
      {this.codePoint,
        this.fontFamily,
        this.fontPackage,
        this.matchTextDirection});

  static IconData fromBean(IconBean bean) =>
      IconData(bean.codePoint, fontFamily: bean.fontFamily);

  static IconBean fromMap(Map<String, dynamic> map) {
    IconBean bean = new IconBean();
    bean.codePoint = int.parse(map['codePoint']);
    bean.fontFamily = map['fontFamily'];
    bean.fontPackage = map['fontPackage'];
    bean.matchTextDirection = map['taskStatus'] == 'ture';
    return bean;
  }

  static IconBean fromIconData(IconData iconData) {
    return IconBean(
      codePoint: iconData.codePoint,
      fontFamily: iconData.fontFamily,
      fontPackage: iconData.fontPackage,
      matchTextDirection: iconData.matchTextDirection,
    );
  }

  static List<IconBean> fromMapList(dynamic mapList) {
    List<IconBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  static Future<List<IconBean>> loadAsset() async {
    String json = await rootBundle.loadString('local_json/icon_json.json');
    return IconBean.fromMapList(jsonDecode(json));
  }
}