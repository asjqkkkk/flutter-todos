import 'package:flutter/material.dart';
import 'package:todo_list/logic/all_logic.dart';

class TaskDetailPageModel extends ChangeNotifier{

  TaskDetailPageLogic logic;
  BuildContext context;
  bool isExisting = false;


  TaskDetailPageModel(){
    logic = TaskDetailPageLogic(this);
  }

  void setContext(BuildContext context){
    if(this.context == null){
        this.context = context;
    }
  }

  @override
  void dispose(){
    super.dispose();
    debugPrint("TaskDetailPageModel销毁了");
  }

  void refresh(){
    notifyListeners();
  }
}