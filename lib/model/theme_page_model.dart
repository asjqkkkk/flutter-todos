import 'package:flutter/material.dart';
import 'package:todo_list/json/theme_bean.dart';
import 'package:todo_list/logic/all_logic.dart';

class ThemePageModel extends ChangeNotifier{

  ThemePageLogic logic;
  BuildContext context;
  Color customColor = Colors.black;

  List<ThemeBean> themes = [];
  bool isDeleting = false;

  ThemePageModel(){
    logic = ThemePageLogic(this);
  }

  void setContext(BuildContext context){
    if(this.context == null){
        this.context = context;
        logic.getThemeList();
    }
  }

  @override
  void dispose(){
    super.dispose();
    debugPrint("ThemePageModel销毁了");
  }

  void refresh(){
    notifyListeners();
  }
}