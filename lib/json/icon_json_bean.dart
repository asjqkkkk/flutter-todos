import 'dart:convert';

import 'package:flutter/services.dart';

class IconJsonBean{

  int codePoint;
  String fontFamily;
  String fontPackage;
  bool matchTextDirection;


  static IconJsonBean fromMap(Map<String, dynamic> map) {
    IconJsonBean bean = new IconJsonBean();
    bean.codePoint = int.parse(map['codePoint']);
    bean.fontFamily = map['fontFamily'];
    bean.fontPackage = map['fontPackage'];
    bean.matchTextDirection = map['taskStatus'] == 'ture';
    return bean;
  }

  static List<IconJsonBean> fromMapList(dynamic mapList) {
    List<IconJsonBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  static Future<List<IconJsonBean>> loadAsset() async {
    String json = await rootBundle.loadString('local_json/icon_json.json');
    return IconJsonBean.fromMapList(jsonDecode(json));
  }

}