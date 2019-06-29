import 'package:flutter/material.dart';
import 'package:todo_list/logic/all_logic.dart';

class GlobalModel extends ChangeNotifier{

  GlobalLogic logic;
  BuildContext context;


  List<String> currentLanguage = ["zh","CN"];


  GlobalModel(){
    logic = GlobalLogic(this);
  }

  void setContext(BuildContext context){
    if(this.context == null){
        this.context = context;
    }
  }

  @override
  void dispose(){
    super.dispose();
    debugPrint("GlobalModel销毁了");
  }

  void refresh(){
    notifyListeners();
  }
}