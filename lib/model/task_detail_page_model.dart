import 'package:flutter/material.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/logic/all_logic.dart';

class TaskDetailPageModel extends ChangeNotifier{

  TaskDetailPageLogic logic;
  BuildContext context;

  bool isExiting = false;
  TaskBean taskBean;
  List<double> progressList = [];



  TaskDetailPageModel(TaskBean taskBean){
    logic = TaskDetailPageLogic(this);
    this.taskBean = taskBean;
    this.progressList.clear();
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