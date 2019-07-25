

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/database/database.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/model/main_page_model.dart';
import 'package:todo_list/model/search_page_model.dart';
import 'package:todo_list/widgets/loading_widget.dart';

class SearchPageLogic{
  final SearchPageModel _model;

  SearchPageLogic(this._model);

  void onEditingComplete (){
    final queryText = _model.textEditingController.text;
    if(queryText.isEmpty) return;
    if (!_model.isSearching) {
      _model. isSearching = true;
      DBProvider.db.queryTask(queryText).then((list) {
        _model.isSearching = false;
        _model.searchTasks.clear();
        _model.searchTasks.addAll(list);
        if(_model.searchTasks.length == 0) {
          _model.loadingFlag = LoadingFlag.empty;
        } else {
          _model.loadingFlag = LoadingFlag.success;
        }
        _model.refresh();
        print("搜索完成:${queryText}  ${list}");
      });
    }
  }

  void onTaskTap(int index,TaskBean taskBean){
    _model.currentTapIndex = index;
    Navigator.of(_model.context).push(new PageRouteBuilder(
        pageBuilder: (ctx, anm, anmS) {
          return ProviderConfig.getInstance()
              .getTaskDetailPage(taskBean.id, taskBean, searchPageModel: _model);
        },
        transitionDuration: Duration(milliseconds: 800)));
  }

  void onDelete(GlobalModel globalModel, TaskBean task) {
    DBProvider.db.deleteTask(task.id);
    final mainPageModel = globalModel.mainPageModel;
    removeTask(mainPageModel, task.id);
    onEditingComplete();
  }

  void onEdit(TaskBean taskBean, MainPageModel mainPageModel){
    Navigator.of(_model.context).push(
      new CupertinoPageRoute(
        builder: (ctx) {
          return ProviderConfig.getInstance().getEditTaskPage(
              taskBean.taskIconBean,
              taskBean: taskBean,);
        },
      ),
    );
  }

  void removeTask(MainPageModel mainPageModel, int id) {
    for (var i = 0; i < mainPageModel.tasks.length; i++) {
      var task = mainPageModel.tasks[i];
      if(task.id == id){
        mainPageModel.tasks.removeAt(i);
        mainPageModel.refresh();
        return;
      }
    }
  }

}