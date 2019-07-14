import 'package:flutter/material.dart';
import 'package:todo_list/json/color_bean.dart';
import 'package:todo_list/json/theme_bean.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/utils/theme_util.dart';
import 'dart:convert';

class GlobalLogic{

  final GlobalModel _model;

  GlobalLogic(this._model);


  //当为夜间模式时候，白色替换为灰色
  Color getWhiteInDark(){
    final themeType = _model.currentThemeBean.themeType;
    return themeType == MyTheme.darkTheme ? Colors.grey : Colors.white;
  }

  //当为夜间模式时候，白色背景替换为特定灰色
  Color getBgInDark(){
    final themeType = _model.currentThemeBean.themeType;
    return themeType == MyTheme.darkTheme ? Colors.grey[800] : Colors.white;
  }

  void getCurrentLanguage(){
    SharedUtil.instance.getStringList(Keys.currentLanguage).then((list) {
      if (list == null) return;
      if (list == _model.currentLanguage) return;
      _model.currentLanguage = list;
      _model.refresh();
    });
  }

  void getCurrentTheme(){
    SharedUtil.instance.getString(Keys.currentThemeBean).then((theme){
      if(theme == null) return;
      ThemeBean themeBean = ThemeBean.fromMap(jsonDecode(theme));
      if(themeBean.themeType == _model.currentThemeBean.themeType) return;
      _model.currentThemeBean = themeBean;
      _model.refresh();
    });
  }


  void getIsBgGradient(){
    SharedUtil.instance.getBoolean(Keys.backgroundGradient).then((value){
      if(value == null) return;
      if(value == _model.isBgGradient) return;
      _model.isBgGradient = value;
      _model.refresh();
    });
  }

  void getIsBgChangeWithCard(){
    SharedUtil.instance.getBoolean(Keys.backgroundChangeWithCard).then((value){
      if(value == null) return;
      if(value == _model.isBgChangeWithCard) return;
      _model.isBgChangeWithCard = value;
      _model.refresh();
    });
  }

}