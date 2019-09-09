import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/database/database.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/model/main_page_model.dart';
import 'package:todo_list/model/search_page_model.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/widgets/loading_widget.dart';
import 'package:todo_list/widgets/net_loading_widget.dart';

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
        print("搜索完成:$queryText  $list");
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
    deleteTask(task, globalModel);
  }

  void doDelete(TaskBean task, GlobalModel globalModel) {
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

  void deleteTask(TaskBean taskBean, GlobalModel globalModel) async{
    final account = await SharedUtil.instance.getString(Keys.account) ?? 'default';
    if(account == "defalut"){
      doDelete(taskBean, globalModel);
    } else {
      if(taskBean.uniqueId == null){
        doDelete(taskBean, globalModel);
      } else {
        final token = await SharedUtil.instance.getString(Keys.token);
        showDialog(context: _model.context, builder: (ctx){
          return NetLoadingWidget();
        });
        ApiService.instance.postDeleteTask(
          success: (CommonBean bean) {
            Navigator.of(_model.context).pop();
            doDelete(taskBean, globalModel);
          },
          failed: (CommonBean bean) {
            Navigator.of(_model.context).pop();
            if(bean.description.contains("任务不存在")){
              doDelete(taskBean, globalModel);
            } else {
              _showTextDialog(bean.description);
            }
          },
          error: (msg) {
            Navigator.of(_model.context).pop();
            _showTextDialog(msg);
          },
          params: {
            "token": token,
            "account": account,
            "uniqueId": taskBean.uniqueId,
          },
          token: _model.cancelToken,
        );
      }
    }
  }

  void _showTextDialog(String text){
    final context = _model.context;
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(20.0))),
            content: Text(
                text),
          );
        });
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