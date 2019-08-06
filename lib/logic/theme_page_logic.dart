import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/material_picker.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/theme_bean.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/utils/theme_util.dart';

class ThemePageLogic {
  final ThemePageModel _model;

  ThemePageLogic(this._model);

  void getThemeList() async {
    final list =
        await ThemeUtil.getInstance().getThemeListWithCache(_model.context);
    _model.themes.clear();
    _model.themes.addAll(list);
    if(list.length == 7){
      _model.isDeleting = false;
    }
    _model.refresh();
  }

  void createCustomTheme() {
    _showColorPicker();
  }

  void _showColorPicker() {
    final context = _model.context;
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            elevation: 0.0,
            title: Text(DemoLocalizations.of(context).pickAColor),
            content: SingleChildScrollView(
              child: MaterialPicker(
                pickerColor: Theme.of(context).primaryColor,
                onColorChanged: (color) {
                  _model.customColor = color;
                },
                enableLabel: true,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  DemoLocalizations.of(context).cancel,
                  style: TextStyle(color: Colors.redAccent),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(DemoLocalizations.of(context).ok),
                onPressed: () async {
                  final beans = await SharedUtil.instance.readList(Keys.themeBeans) ?? [];
                  if (beans.length >= 10) {
                    _showCanNotAddTheme();
                    return;
                  }
                  ThemeBean themeBean = ThemeBean(
                    themeName: DemoLocalizations.of(context).customTheme +
                        " ${beans.length + 1}",
                    themeType: DemoLocalizations.of(context).customTheme +
                        " ${beans.length + 1}",
                    colorBean: ColorBean.fromColor(_model.customColor),
                  );
                  final data = jsonEncode(themeBean.toMap());
                  beans.add(data);
                  SharedUtil.instance.saveStringList(Keys.themeBeans, beans);
                  getThemeList();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _showCanNotAddTheme() {
    showDialog(
        context: _model.context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content:
                Text(DemoLocalizations.of(_model.context).canNotAddMoreTheme),
          );
        });
  }

  removeIcon(int index) {
    SharedUtil.instance.readAndRemoveList(Keys.themeBeans,index - 7);
    getThemeList();
  }
}
