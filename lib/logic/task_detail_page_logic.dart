import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/database/database.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/widgets/net_loading_widget.dart';

class TaskDetailPageLogic {
  final TaskDetailPageModel _model;

  TaskDetailPageLogic(this._model);

  double _getOverallProgress() {
    int length = _model.taskBean.detailList.length;
    double overallProgress = 0.0;
    for (int i = 0; i < length; i++) {
      overallProgress += _model.taskBean.detailList[i].itemProgress / length;
    }
    _model.taskBean.overallProgress =
        overallProgress > 0.999 ? 1.0 : overallProgress;
    return overallProgress;
  }

  void refreshProgress(
      TaskDetailBean taskDetailBean, progress, MainPageModel model) {
    taskDetailBean.itemProgress = progress;
    _getOverallProgress();
    model.refresh();
    _model.refresh();
  }

  //页面退出需要执行的逻辑,isDeleting表示这个页面是否执行了删除当前任务的操作
  void exitPage({bool isDeleting = false}) {
    final context = _model.context;
    final mainPageModel = _model.globalModel.mainPageModel;
    bool needUpdate = needUpdateDatabase();
    if (needUpdate && !isDeleting) {
      ///如果一个任务中的所有任务项都完成了,因为主页面都是未完成任务，所以删除主页面的该任务
      if (_model.taskBean.overallProgress >= 1.0) {
        _model.taskBean.finishDate = DateTime.now().toIso8601String();

        ///下面这个延时操作，目的如下，如果一个任务完成了，主页面会把这个任务去除掉
        ///这个时候主页任务卡片的herotag就消失了，因为herotag不一致，会导致hero动画失效
        Future.delayed(
            Duration(
              milliseconds: 800,
            ), () {
          debugPrint("删除了");
          removeTask(mainPageModel);
          debugPrint("刷新main");
          mainPageModel.refresh();
        });
      }
      _model.taskBean.changeTimes++;
      DBProvider.db.updateTask(_model.taskBean).then((value) async{
        final account = await SharedUtil.instance.getString(Keys.account) ?? 'default';
        if(account != 'default'){
          _model.taskBean.uniqueId == null
              ? mainPageModel.logic.postCreateTask(_model.taskBean)
              : mainPageModel.logic.postUpdateTask(_model.taskBean);
        }
        ///如果是从"完成列表"过来
        if (_model.doneTaskPageModel != null) {
          mainPageModel.logic.getTasks();
          _model.doneTaskPageModel.logic.getDoneTasks().then((value) {
            _model.doneTaskPageModel.refresh();
            Navigator.of(context).pop();
          });
        }

        ///如果是从"搜索页面"过来
        else if (_model.searchPageModel != null) {
          _model.isExiting = true;
          _model.refresh();
          mainPageModel.logic.getTasks();
          _model.searchPageModel.logic.onEditingComplete();
          Navigator.of(context).pop();
        } else {
          debugPrint("退出了");
          _model.isExiting = true;
          _model.refresh();
          Navigator.of(context).pop();
        }
      });
      return;
    }
    _model.isExiting = true;
    _model.refresh();
    Navigator.of(context).pop();
  }

  bool needUpdateDatabase() {
    return _model.progress != _model.taskBean.overallProgress;
  }

  void deleteTask(MainPageModel mainPageModel) async {
    final account =
        await SharedUtil.instance.getString(Keys.account) ?? 'default';
    if (account == 'default') {
      deleteAndExit(mainPageModel);
    } else {
      deleteCloudTask(mainPageModel, account);
    }
  }

  void deleteCloudTask(MainPageModel mainPageModel, String account) async {
    showDialog(
        context: _model.context,
        builder: (ctx) {
          return NetLoadingWidget();
        });
    final token = await SharedUtil.instance.getString(Keys.token);
    ApiService.instance.postDeleteTask(
      success: (CommonBean bean) {
        Navigator.of(_model.context).pop();
        deleteAndExit(mainPageModel);
      },
      failed: (CommonBean bean) {
        Navigator.of(_model.context).pop();
        if(bean.description.contains("任务不存在")){
          deleteAndExit(mainPageModel);
        } else {
          _showTextDialog(bean.description, _model.context);
        }

      },
      error: (msg) {
        Navigator.of(_model.context).pop();
        _showTextDialog(msg, _model.context);
      },
      params: {
        "token": token,
        "account": account,
        "uniqueId": _model.taskBean.uniqueId,
      },
      token: _model.cancelToken,
    );
  }

  void deleteAndExit(MainPageModel mainPageModel) {
    removeTask(mainPageModel);
    DBProvider.db.deleteTask(_model.taskBean.id);
    _model.refresh();
    //如果是从“完成列表”过来
    final doneTaskPageModel = _model.doneTaskPageModel;
    if (doneTaskPageModel != null) {
      doneTaskPageModel.doneTasks.removeAt(doneTaskPageModel.currentTapIndex);
      doneTaskPageModel.refresh();
    }
    //如果是从"搜索界面"过来
    final searchPageModel = _model.searchPageModel;
    if (searchPageModel != null) {
      searchPageModel.searchTasks.removeAt(searchPageModel.currentTapIndex);
      searchPageModel.refresh();
    }
    exitPage(isDeleting: true);
  }

  void removeTask(MainPageModel mainPageModel) {
    for (var i = 0; i < mainPageModel.tasks.length; i++) {
      var task = mainPageModel.tasks[i];
      if (task.id == _model.taskBean.id) {
        mainPageModel.tasks.removeAt(i);
        return;
      }
    }
  }

  void editTask(MainPageModel mainPageModel) {
    Navigator.of(_model.context).push(
      new CupertinoPageRoute(
        builder: (ctx) {
          return ProviderConfig.getInstance().getEditTaskPage(
            _model.taskBean.taskIconBean,
            taskBean: _model.taskBean,
            taskDetailPageModel: _model,
          );
        },
      ),
    );
  }

  void _showTextDialog(String text, BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Text(text),
          );
        });
  }
}
