import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_list/json/color_bean.dart';
export 'package:todo_list/json/color_bean.dart';

class TaskIconBean {
  String taskName;
  IconBean iconBean;
  ColorBean colorBean;

  TaskIconBean({this.taskName, this.iconBean, this.colorBean});

  static TaskIconBean fromMap(Map<String, dynamic> map) {
    TaskIconBean bean = new TaskIconBean();
    bean.taskName = map['taskName'];
    bean.colorBean = ColorBean.fromMap(map['colorBean']);
    bean.iconBean = IconBean.fromMap(map['iconBean']);
    return bean;
  }

  static List<TaskIconBean> fromMapList(dynamic mapList) {
    List<TaskIconBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'taskName': taskName,
      'iconBean': iconBean.toMap(),
      'colorBean': colorBean.toMap()
    };
  }
}

class IconBean {
  int codePoint;
  String fontFamily;
  String fontPackage;
  String iconName;
  bool matchTextDirection;

  IconBean(
      {this.codePoint,
      this.fontFamily,
      this.fontPackage,
      this.iconName,
      this.matchTextDirection});

  static IconData fromBean(IconBean bean) => IconData(bean.codePoint,
      fontFamily: bean.fontFamily,);

  static IconBean fromMap(Map<String, dynamic> map) {
    IconBean bean = new IconBean();
    bean.codePoint = map['codePoint'] is int ? map['codePoint'] : int.parse(map['codePoint']);
    bean.fontFamily = map['fontFamily'];
    bean.fontPackage = map['fontPackage'];
    bean.iconName = map['iconName'];
    bean.matchTextDirection = map['matchTextDirection'] == 'ture';
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

  Map<dynamic, dynamic> toMap() {
    return {
      'codePoint': codePoint.toString(),
      'fontFamily': fontFamily ?? "",
      'fontPackage': fontPackage ?? "",
      'iconName': iconName ?? "",
      'matchTextDirection': matchTextDirection.toString()
    };
  }
}
