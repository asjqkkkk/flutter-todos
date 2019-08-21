import 'package:flutter/material.dart';
import 'package:todo_list/logic/all_logic.dart';

class RegisterPageModel extends ChangeNotifier{

  RegisterPageLogic logic;
  BuildContext context;

  RegisterPageModel(){
    logic = RegisterPageLogic(this);
  }

  void setContext(BuildContext context){
    if(this.context == null){
        this.context = context;
    }
  }

  @override
  void dispose(){
    super.dispose();
    debugPrint("RegisterPageModel销毁了");
  }

  void refresh(){
    notifyListeners();
  }
}