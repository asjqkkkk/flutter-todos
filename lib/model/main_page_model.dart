import 'package:flutter/material.dart';
import 'package:todo_list/logic/all_logic.dart';

class MainPageModel extends ChangeNotifier{

  MainPageLogic logic;
  BuildContext context;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  MainPageModel(){
    logic = MainPageLogic(this);
  }

  void setContext(BuildContext context){
    if(this.context == null){
        this.context = context;
    }
  }

  @override
  void dispose(){
    super.dispose();
    scaffoldKey?.currentState?.dispose();
    debugPrint("MainPageModel销毁了");
  }

  void refresh(){
    notifyListeners();
  }
}