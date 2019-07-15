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

  void onIconPress(IconBean iconBean, {ColorBean colorBean, String name, bool isEdit = false, int index}) {
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
                if(isEdit){
                  //如果不是新增而是编辑
                  SharedUtil.instance.readAndExchangeList(Keys.taskIconBeans, data, index - 6);
                } else{
                  //如果是新增
                  final canAddMore = await SharedUtil.instance.readAndSaveList(Keys.taskIconBeans, data);
                  if(!canAddMore){
                    showCanNotAddIcon();
                  }
                }

                getTaskList();
              },
              pickerColor: colorBean == null ? _model.currentPickerColor : ColorBean.fromBean(colorBean),
              onTextChange: (text){
                final name = text.isEmpty ? DemoLocalizations.of(_model.context).defaultIconName : text;
                _model.currentIconName = name;
              },
              iconName: name ?? iconBean.iconName,
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

  void tapDefaultIcon(int index){
    if (index <= 5) {
      showDialog(context: _model.context, builder: (ctx){
        return AlertDialog(
          content: Text(DemoLocalizations.of(_model.context).canNotEditDefaultIcon),
        );
      });
    };
  }

  void removeIcon(int index){
    SharedUtil.instance.readAndRemoveList(Keys.taskIconBeans,index - 6);
    getTaskList();
  }
}
