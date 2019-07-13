import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/task_icon_bean.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/utils/icon_list_util.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/utils/theme_util.dart';
import 'package:todo_list/widgets/custom_icon_widget.dart';

class IconSettingPageLogic {
  final IconSettingPageModel _model;

  IconSettingPageLogic(this._model);

  void onIconPress(IconBean iconBean) {
    showDialog(
      barrierDismissible: false,
        context: _model.context,
        builder: (ctx) {
          return AlertDialog(
            elevation: 0.0,
            contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            title: Text(DemoLocalizations.of(_model.context).customIcon),
            content: CustomIconWidget(
              iconData: IconBean.fromBean(iconBean),
              onApplyTap: (color) async{
                _model.currentPickerColor = color;
                ColorBean colorBean =
                ColorBean.fromColor(_model.currentPickerColor);
                TaskIconBean taskIconBean = TaskIconBean(
                    taskName: _model.currentIconName.isEmpty
                        ? DemoLocalizations.of(_model.context).defaultIconName
                        : _model.currentIconName,
                    colorBean: colorBean,
                    iconBean: iconBean);
                final data = jsonEncode(taskIconBean.toMap());
                final canAddMore = await SharedUtil.instance.readAndSaveList(Keys.taskIconBeans, data);
                if(!canAddMore){
                  showCanNotAddIcon();
                }
                getTaskList();
              },
              pickerColor: _model.currentPickerColor,
              onTextChange: (text){
                final name = text.isEmpty ? DemoLocalizations.of(_model.context).defaultIconName : text;
                _model.currentIconName = name;
              },
            )
          );
        });
  }


  void getTaskList() async {
    final list =
        await IconListUtil.getInstance().getIconWithCache(_model.context);
    _model.taskIcons.clear();
    _model.taskIcons.addAll(list);
    _model.refresh();
  }

  void showCanNotAddIcon(){
    showDialog(context: _model.context,builder: (ctx){
      return AlertDialog(
        content: Text(DemoLocalizations.of(_model.context).canNotAddMoreIcon),
      );
    });
  }

  void removeIcon(){

  }
}
