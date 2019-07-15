import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/database/database.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/model/all_model.dart';

class TaskDetailPageLogic{

  final TaskDetailPageModel _model;

  TaskDetailPageLogic(this._model);

  double _getOverallProgress(){
    int length = _model.taskBean.detailList.length;
    double overallProgress = 0.0;
    for(int i = 0; i < length;i++){
      overallProgress += _model.taskBean.detailList[i].itemProgress / length;
    }
    _model.taskBean.overallProgress = overallProgress;
    return overallProgress;
  }

  void refreshProgress(TaskDetailBean taskDetailBean, progress, MainPageModel model) {
    taskDetailBean.itemProgress = progress;
    _getOverallProgress();
    model.refresh();
    _model.refresh();
  }


  void exitPage(){
    _model.isExiting = true;
    _model.refresh();
    if(needUpdateDatabase()) {
      DBProvider.db.updateTask(_model.taskBean);
      Navigator.of(_model.context).popUntil((route) => route.isFirst);
      return;
    }
    Navigator.of(_model.context).pop();
  }

  bool needUpdateDatabase(){
    return _model.progress != _model.taskBean.overallProgress;
  }


  void deleteTask(MainPageModel mainPageModel){
    exitPage();
    mainPageModel.logic.deleteTask(_model.taskBean.id);
    mainPageModel.logic.getTasks();
  }

  void editTask(MainPageModel mainPageModel){
    Navigator.of(_model.context).push(
      new CupertinoPageRoute(
        builder: (ctx) {
          return ProviderConfig.getInstance()
              .getEditTaskPage(
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