import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/logic/all_logic.dart';
import 'package:todo_list/model/done_task_page_model.dart';
import 'package:todo_list/model/search_page_model.dart';

import 'global_model.dart';

class TaskDetailPageModel extends ChangeNotifier {
  TaskDetailPageLogic logic;
  BuildContext context;
  GlobalModel globalModel;

  int heroTag;

  //是否正在退出中，如果是，任务详情列表就消失，如果不是就展示
  bool isExiting = false;

  //进入的动画是否完成,完成后左上角的退出按钮就可以显示了，同时任务详情列表也开始展示
  bool isAnimationComplete = false;

  //这个定时器是为了配合hero动画定时的
  Timer timer;
  TaskBean taskBean;

  CancelToken cancelToken = CancelToken();


  //这个progress用于判断进度是否改变，当被改变后退出的时候就更新数据库
  double progress;

  //如果不为空，表示是否从"完成列表"过来的
  DoneTaskPageModel doneTaskPageModel;

  //如果不为空，表示是否从"搜索界面"过来的
  SearchPageModel searchPageModel;

  TaskDetailPageModel(
    TaskBean taskBean, {
    DoneTaskPageModel doneTaskPageModel,
    SearchPageModel searchPageModel,
        int heroTag,
  }) {
    logic = TaskDetailPageLogic(this);
    this.taskBean = taskBean;
    this.heroTag = heroTag;
    this.doneTaskPageModel = doneTaskPageModel;
    this.searchPageModel = searchPageModel;
    this.progress = taskBean.overallProgress;
    //如果是从"完成列表"进来，就不搞hero动画了
    if (doneTaskPageModel != null) {
      isAnimationComplete = true;
      return;
    }
    timer = Timer(Duration(seconds: 1), () {
      isAnimationComplete = true;
      notifyListeners();
    });
  }

  void setContext(BuildContext context, GlobalModel globalModel) async {
    if (this.context == null) {
      this.context = context;
      this.globalModel = globalModel;
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
    if(!cancelToken.isCancelled) cancelToken.cancel();
    super.dispose();
    globalModel.taskDetailPageModel = null;
    debugPrint("TaskDetailPageModel销毁了");

  }

  void refresh() {
    notifyListeners();
  }
}
