import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/logic/all_logic.dart';
import 'package:todo_list/utils/shared_util.dart';

class TaskDetailPageModel extends ChangeNotifier{

  TaskDetailPageLogic logic;
  BuildContext context;

  bool isExiting = false; //是否正在退出中
  bool isAnimationComplete = false;   //进入的动画是否完成
  Timer timer;
  TaskBean taskBean;
  List<double> progressList = [];



  TaskDetailPageModel(TaskBean taskBean){
    logic = TaskDetailPageLogic(this);
    this.taskBean = taskBean;
    this.progressList.clear();
    timer = Timer(Duration(seconds: 1), (){
      isAnimationComplete = true;
      notifyListeners();
      debugPrint("执行");
    });
  }

  void setContext(BuildContext context) async{
    if(this.context == null){
        this.context = context;
    }
  }

  @override
  void dispose(){
    timer?.cancel();
    debugPrint("TaskDetailPageModel销毁了");
    super.dispose();

  }

  void refresh(){
    notifyListeners();
  }
}