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

  Future getCurrentLanguage() async{
    final list = await SharedUtil.instance.getStringList(Keys.currentLanguage);
    if (list == null) return;
    if (list == _model.currentLanguage) return;
    _model.currentLanguage = list;
  }

  Future getCurrentTheme() async{
    final theme = await SharedUtil.instance.getString(Keys.currentThemeBean);
    if(theme == null) return;
    ThemeBean themeBean = ThemeBean.fromMap(jsonDecode(theme));
    if(themeBean.themeType == _model.currentThemeBean.themeType) return;
    _model.currentThemeBean = themeBean;
  }


  Future getIsBgGradient()async{
    final isBgGradient = await SharedUtil.instance.getBoolean(Keys.backgroundGradient);
    if(isBgGradient == null) return;
    if(isBgGradient == _model.isBgGradient) return;
    _model.isBgGradient = isBgGradient;
  }

  Future getIsBgChangeWithCard() async {
    final isBgChangeWithCard = await SharedUtil.instance.getBoolean(Keys.backgroundChangeWithCard);
    if(isBgChangeWithCard == null) return;
    if(isBgChangeWithCard == _model.isBgChangeWithCard) return;
    _model.isBgChangeWithCard = isBgChangeWithCard;
  }

  Future getIsCardChangeWithBg() async {
    final isCardChangeWithBg = await SharedUtil.instance.getBoolean(Keys.cardChangeWithBackground);
    if(isCardChangeWithBg == null) return;
    if(isCardChangeWithBg == _model.isCardChangeWithBg) return;
    _model.isCardChangeWithBg = isCardChangeWithBg;
  }

  Future getEnableInfiniteScroll() async{
    final enableInfiniteScroll = await SharedUtil.instance.getBoolean(Keys.enableInfiniteScroll);
    if(enableInfiniteScroll == null) return;
    if(enableInfiniteScroll == _model.enableInfiniteScroll) return;
    _model.enableInfiniteScroll = enableInfiniteScroll;
  }

}