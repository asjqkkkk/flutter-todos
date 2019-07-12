import 'package:flutter/material.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/utils/theme_util.dart';

class EditTaskPageLogic {
  final EditTaskPageModel _model;

  EditTaskPageLogic(this._model);

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

  //当为夜间模式时候，白色背景替换为特定灰色
  void getBgInDark() async {
    String currentThemeType =
        await SharedUtil.instance.getString(Keys.currentThemeType) ??
            MyTheme.defaultTheme;
    Color color =
        currentThemeType == MyTheme.darkTheme ? Colors.grey[800] : Colors.white;
    _model.bgColor = color;
    _model.refresh();
  }

  //提交一项任务
  void submitOneItem() {
    _model.taskDetails.add(_model.textEditingController.text);
    _model.textEditingController.clear();
    _model.refresh();
  }

  //监听文字，提交按钮是否可以点击
  void editListener() {
    final text = _model.textEditingController.text;
    if (text.isEmpty && _model.canAddTask == true) {
      _model.canAddTask = false;
      _model.refresh();
    } else if(text.isNotEmpty && _model.canAddTask == false) {
      _model.canAddTask = true;
      _model.refresh();
    }
  }

  //删除一项任务
  void removeItem(int index) {
    _model.taskDetails.removeAt(index);
    _model.refresh();
  }

  //选择任务结束时间
  void pickEndTime() {

    DateTime initialDate = DateTime.now();
    DateTime firstDate = initialDate.add(Duration(days: 1));
    DateTime lastDate = initialDate.add(Duration(days: 365));
    showDatePicker(
      context: _model.context,
      initialDate: firstDate,
      firstDate: initialDate,
      lastDate: lastDate,
        builder: (BuildContext context, Widget child) {
          return FittedBox(
            child: Theme(
              child: child,
              data: ThemeData(
                primaryColor: _model.taskIcon.color,
                accentColor: _model.taskIcon.color,
                buttonTheme: ButtonThemeData(
                    textTheme: ButtonTextTheme.accent
                ),
              ),
            ),
          );
        },
    ).then((day){
      _model.deadLine = day;
      _model.refresh();
    });
  }

  //将结束时间做个转换
  String getEndTimeText(){
    if(_model.deadLine != null){
      final time = _model.deadLine;
      return "${time.year}-${time.month}-${time.day}";
    }
    return DemoLocalizations.of(_model.context).deadline;
  }
}
