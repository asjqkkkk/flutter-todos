import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/logic/all_logic.dart';
import 'package:todo_list/model/done_task_page_model.dart';
import 'package:todo_list/utils/shared_util.dart';

import 'global_model.dart';

class TaskDetailPageModel extends ChangeNotifier {
  TaskDetailPageLogic logic;
  BuildContext context;
  GlobalModel globalModel;

  bool isExiting = false; //是否正在退出中
  bool isAnimationComplete = false; //进入的动画是否完成

  //这个定时器是为了配合hero动画定时的
  Timer timer;
  TaskBean taskBean;

  //每一项任务的进度list
  List<double> progressList = [];

  //这个progress用于判断进度是否改变，当被改变后退出的时候就更新数据库
  double progress;

  //如果不为空，表示是否从"完成列表"过来的
  DoneTaskPageModel doneTaskPageModel;

  TaskDetailPageModel(TaskBean taskBean,
      { DoneTaskPageModel doneTaskPageModel,}) {
    logic = TaskDetailPageLogic(this);
    this.taskBean = taskBean;
    this.doneTaskPageModel = doneTaskPageModel;
    this.progress = taskBean.overallProgress;
    this.progressList.clear();
    if(doneTaskPageModel != null){
      isAnimationComplete = true;
      return;
    }
    timer = Timer(Duration(seconds: 1), () {
      isAnimationComplete = true;
      notifyListeners();
    });
  }

  void setContext(BuildContext context) async {
    if (this.context == null) {
      this.context = context;
    }
  }

  void setGlobalModel(GlobalModel globalModel) {
    if (this.globalModel == null) {
      this.globalModel = globalModel;
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    debugPrint("TaskDetailPageModel销毁了");
    super.dispose();
  }

  void refresh() {
    notifyListeners();
  }
}
