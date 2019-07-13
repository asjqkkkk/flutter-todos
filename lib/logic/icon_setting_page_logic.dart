import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:todo_list/json/task_icon_bean.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/utils/icon_list_util.dart';
import 'package:todo_list/utils/shared_util.dart';

class IconSettingPageLogic {
  final IconSettingPageModel _model;

  IconSettingPageLogic(this._model);

  void onIconPress(IconBean iconBean) {
    showDialog(
        context: _model.context,
        builder: (ctx) {
          return AlertDialog(
            elevation: 0.0,
            title: const Text('Pick a color!'),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: _model.currentPickerColor,
                onColorChanged: (color) {
                  _model.currentPickerColor = color;
                },
                enableLabel: true,
                pickerAreaHeightPercent: 0.8,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('Got it'),
                onPressed: () async {
                  ColorBean colorBean =
                      ColorBean.fromColor(_model.currentPickerColor);
                  TaskIconBean taskIconBean = TaskIconBean(
                      taskName: _model.currentIconName.isEmpty
                          ? "default"
                          : _model.currentIconName,
                      colorBean: colorBean,
                  iconBean: iconBean);
                  final data = jsonEncode(taskIconBean.toMap());
                  debugPrint("data:${data}");
                  SharedUtil.instance.readAndSaveList(Keys.taskIconBeans, data);
                  getTaskList();
                  Navigator.of(_model.context).pop();
                },
              ),
            ],
          );
        });
  }

  void getTaskList() async {
    final list = await IconListUtil.getInstance().getIconWithCache(_model.context);
    _model.taskIcons.clear();
    _model.taskIcons.addAll(list);
    _model.refresh();
  }
}
