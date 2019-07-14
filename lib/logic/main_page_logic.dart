import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/database/database.dart';
import 'package:todo_list/items/task_item.dart';
import 'package:todo_list/json/color_bean.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/pages/task_detail_page.dart';
import 'package:todo_list/utils/theme_util.dart';

class MainPageLogic {
  final MainPageModel _model;

  MainPageLogic(this._model);

  List<Widget> getCards(context) {
    return List.generate(_model.tasks.length, (index) {
      final taskBean = _model.tasks[index];
      return GestureDetector(
        child: TaskItem(
          index,
          taskBean,
          onEdit: () => _model.logic.editTask(taskBean),
          onDelete: () => _model.logic.deleteTask(taskBean.id),
        ),
        onTap: () {
          Navigator.of(context).push(new PageRouteBuilder(
              pageBuilder: (ctx, anm, anmS) {
                return ProviderConfig.getInstance()
                    .getTaskDetailPage(index, taskBean);
              },
              transitionDuration: Duration(milliseconds: 800)));
        },
      );
    });
  }

  Widget getIconText({Icon icon, String text, VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.grey.withOpacity(0.2)),
        child: Row(
          children: <Widget>[
            icon,
            SizedBox(
              width: 4,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }

  void getTasks() {
    DBProvider.db.getTasks().then((tasks) {
      debugPrint("获取任务数据:${tasks}");
      if (tasks == null) return;
      _model.tasks.clear();
      _model.tasks.addAll(tasks);
      _model.refresh();
    });
  }

  void queryTask(String query) {
    DBProvider.db.queryTask(query).then((tasks) {
      debugPrint("查询的数据是:${tasks}");
    });
  }

  Decoration getBackground(GlobalModel globalModel) {
    bool isBgGradient = globalModel.isBgGradient;
    bool isBgChangeWithCard = globalModel.isBgChangeWithCard;
    final context = _model.context;
    return BoxDecoration(
      gradient: isBgGradient
          ? LinearGradient(
              colors: _getGradientColors(isBgChangeWithCard),
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)
          : null,
      color: _getBgColor(isBgGradient, isBgChangeWithCard),
    );
  }

  List<Color> _getGradientColors(bool isBgChangeWithCard) {
    final context = _model.context;
    if (!isBgChangeWithCard) {
      return [
        Theme.of(context).primaryColorLight,
        Theme.of(context).primaryColor,
        Theme.of(context).primaryColorDark,
      ];
    } else {
      return [
        ThemeUtil.getInstance().getLightColor(getCurrentCardColor()),
        getCurrentCardColor(),
        ThemeUtil.getInstance().getDarkColor(getCurrentCardColor()),
      ];
    }
  }

  Color _getBgColor(bool isBgGradient, bool isBgChangeWithCard) {
    if (isBgGradient) {
      return null;
    }
    final context = _model.context;
    final primaryColor = Theme.of(context).primaryColor;
    return isBgChangeWithCard ? getCurrentCardColor() : primaryColor;
  }

  Color getCurrentCardColor() {
    final context = _model.context;
    final primaryColor = Theme.of(context).primaryColor;
    int index = _model.currentCardIndex;
    int taskLength = _model.tasks.length;
    if (taskLength == 0) return primaryColor;
    if (index > taskLength - 1) return primaryColor;
    return ColorBean.fromBean(_model.tasks[index].taskIconBean.colorBean);
  }

  void deleteTask(int id) async {
    DBProvider.db.deleteTask(id).then((a){
      getTasks();
    });
  }

  void editTask(TaskBean taskBean) {
    Navigator.of(_model.context).push(
      new CupertinoPageRoute(
        builder: (ctx) {
          return ProviderConfig.getInstance()
              .getEditTaskPage(
              taskBean.taskIconBean,
              mainPageModel: _model,
              taskBean: taskBean
          );
        },
      ),
    );
  }
}
