import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:todo_list/json/icon_json_bean.dart';
import 'package:todo_list/utils/icon_list_util.dart';


void main() {
  test("\n测试获取类中变量\n", () {
    File file = new File(
        "/Users/lichen/flutter/packages/flutter/lib/src/material/icons.dart");
    expect(true, file.existsSync());
    final text = file.readAsStringSync();
    final listOne = text.split("static const IconData ");
    List<String> names = [];
    for (var o in listOne) {
      final theNames = o.split(" = IconData(");
      names.add("\"${theNames[0]}\"");
    }
    print("结果：\n:${names}");
  });


  Map<String, dynamic> toMap(IconData icon) {
    return {
      '\"codePoint\"': "\"${icon.codePoint}\"",
      '\"fontFamily\"': "\"${icon.fontFamily}\"",
      '\"fontPackage\"': "\"${icon.fontPackage}\"",
      '\"matchTextDirection\"': "\"${icon.matchTextDirection}\""
    };
    //把list转换为string的时候不要直接使用tostring，要用jsonEncode
  }

  test("测试icondata转换", (){
    final list = IconListUtil.getInstance().icons;
    List<Map<String, dynamic>> jsons = List.generate(list.length, (index){
      return toMap(list[index]);
    });
    print("数据:${jsons}");
  });


  test("本地json转换测试", (){
    final data = IconJsonBean.loadAsset();
    print("data:${data}");
    data.then((list){
      print("list:${list}");
    });
  });

}