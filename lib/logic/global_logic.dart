import 'package:flutter/material.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/utils/theme_util.dart';

class GlobalLogic{

  final GlobalModel _model;

  GlobalLogic(this._model);


  //当为夜间模式时候，白色替换为灰色
  Color getWhiteInDark(){
    return _model.currentThemeType == MyTheme.darkTheme ? Colors.grey : Colors.white;
  }

  //当为夜间模式时候，白色背景替换为特定灰色
  Color getBgInDark(){
    return _model.currentThemeType == MyTheme.darkTheme ? Colors.grey[800] : Colors.white;
  }

}