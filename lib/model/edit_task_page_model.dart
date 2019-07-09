import 'package:flutter/material.dart';
import 'package:todo_list/logic/all_logic.dart';

class EditTaskPageModel extends ChangeNotifier{

  EditTaskPageLogic logic;
  BuildContext context;

  bool canAddTask = false;    //能否添加任务

  EditTaskPageModel(){
    logic = EditTaskPageLogic(this);
  }

  void setContext(BuildContext context){
    if(this.context == null){
        this.context = context;
    }
  }

  @override
  void dispose(){
    super.dispose();
    debugPrint("EditTaskPageModel销毁了");
  }

  void refresh(){
    notifyListeners();
  }
}