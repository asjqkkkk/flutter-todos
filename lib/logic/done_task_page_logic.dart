import 'package:flutter/cupertino.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/database/database.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/model/all_model.dart';

class DoneTaskPageLogic {
  final DoneTaskPageModel _model;

  DoneTaskPageLogic(this._model);

  Future getDoneTasks() async {
    final tasks = await DBProvider.db.getTasks(isDone: true);
    if (tasks.length == 0) {
      _model.loadingFlag = LoadingFlag.empty;
      _model.doneTasks.clear();
      return;
    }
    _model.doneTasks.clear();
    _model.doneTasks.addAll(tasks);
    _model.loadingFlag = LoadingFlag.success;
  }

  void onTaskTap(int index, TaskBean task) {
    _model.currentTapIndex = index;
    Navigator.of(_model.context).push(new CupertinoPageRoute(builder: (ctx) {
      return ProviderConfig.getInstance().getTaskDetailPage(
        task.id,
        task,
        doneTaskPageModel: _model,
      );
    }));
  }

  //将时间做转换
  String getTimeText(String date) {
    if(date.isEmpty){
      date = DateTime.now().toIso8601String();
    }
    DateTime time = DateTime.parse(date);
    return "${time.year}-${time.month}-${time.day}";
  }

  String getDiffTimeText(String dateStart, String dateEnd) {
    if(dateEnd.isEmpty){
      dateEnd = DateTime.now().toIso8601String();
    }
    DateTime timeStart = DateTime.parse(dateStart);
    DateTime timeEnd = DateTime.parse(dateEnd);
    Duration diff = timeEnd.difference(timeStart);
    final context = _model.context;


    return diff.inDays == 0
        ? "${DemoLocalizations.of(context).hours(diff.inHours.abs())}"
        : "${DemoLocalizations.of(context).days(diff.inDays.abs())}";
  }
}
