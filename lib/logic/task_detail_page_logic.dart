import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/database/database.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/model/all_model.dart';

class TaskDetailPageLogic {
  final TaskDetailPageModel _model;

  TaskDetailPageLogic(this._model);

  double _getOverallProgress() {
    int length = _model.taskBean.detailList.length;
    double overallProgress = 0.0;
    for (int i = 0; i < length; i++) {
      overallProgress += _model.taskBean.detailList[i].itemProgress / length;
    }
    _model.taskBean.overallProgress = overallProgress;
    return overallProgress;
  }

  void refreshProgress(
      TaskDetailBean taskDetailBean, progress, MainPageModel model) {
    taskDetailBean.itemProgress = progress;
    _getOverallProgress();
    model.refresh();
    _model.refresh();
  }

  void exitPage({bool isDeleting = false}) {
    final context = _model.context;
    final mainPageModel = _model.globalModel.mainPageModel;
    bool needUpdate = needUpdateDatabase();
    if (needUpdate && !isDeleting) {
      if (_model.taskBean.overallProgress == 1.0) {
        _model.taskBean.finishDate = DateTime.now().toIso8601String();
        mainPageModel.tasks.removeAt(mainPageModel.currentTapIndex);
      }
      DBProvider.db.updateTask(_model.taskBean);
      if (_model.doneTaskPageModel != null) {
        mainPageModel.logic.getTasks();
        _model.doneTaskPageModel.logic.getDoneTasks().then((value) {
          _model.doneTaskPageModel.refresh();
          Navigator.of(context).pop();
        });
      } else {
        print("点击退出");
        _model.isExiting = true;
        _model.refresh();
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
      mainPageModel.refresh();
      return;
    }
    _model.isExiting = true;
    _model.refresh();
    Navigator.of(context).pop();
  }

  bool needUpdateDatabase() {
    return _model.progress != _model.taskBean.overallProgress;
  }

  void deleteTask(MainPageModel mainPageModel) {
    mainPageModel.tasks.removeAt(mainPageModel.currentTapIndex);
    mainPageModel.refresh();
    DBProvider.db.deleteTask(_model.taskBean.id);
    _model.refresh();
    final doneTaskPageModel = _model.doneTaskPageModel;
    if (doneTaskPageModel != null) {
      doneTaskPageModel.doneTasks
          .removeAt(doneTaskPageModel.currentTapIndex);
      if (doneTaskPageModel.doneTasks.length == 0)
        doneTaskPageModel.loadingFlag = LoadingFlag.empty;
      doneTaskPageModel.refresh();
    }
    exitPage(isDeleting: true);
  }

  void editTask(MainPageModel mainPageModel) {
    Navigator.of(_model.context).push(
      new CupertinoPageRoute(
        builder: (ctx) {
          return ProviderConfig.getInstance().getEditTaskPage(
            _model.taskBean.taskIconBean,
            mainPageModel: mainPageModel,
            taskBean: _model.taskBean,
            taskDetailPageModel: _model,
          );
        },
      ),
    );
  }
}
