import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/theme_bean.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/utils/theme_util.dart';
import 'package:todo_list/widgets/custom_time_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ThemePageLogic {
  final ThemePageModel _model;

  ThemePageLogic(this._model);

  void getThemeList() async {
    final list =
        await ThemeUtil.getInstance().getThemeListWithCache(_model.context);
    _model.themes.clear();
    _model.themes.addAll(list);
    if (list.length == 7) {
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
            title: Text(IntlLocalizations.of(context).pickAColor),
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
                  IntlLocalizations.of(context).cancel,
                  style: TextStyle(color: Colors.redAccent),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(IntlLocalizations.of(context).ok),
                onPressed: () async {
                  final beans =
                      await SharedUtil.instance.readList(Keys.themeBeans) ?? [];
                  if (beans.length >= 10) {
                    _showCanNotAddTheme();
                    return;
                  }
                  ThemeBean themeBean = ThemeBean(
                    themeName: IntlLocalizations.of(context).customTheme +
                        " ${beans.length + 1}",
                    themeType: IntlLocalizations.of(context).customTheme +
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
                Text(IntlLocalizations.of(_model.context).canNotAddMoreTheme),
          );
        });
  }

  removeIcon(int index) {
    SharedUtil.instance.readAndRemoveList(Keys.themeBeans, index - 7);
    getThemeList();
  }

  Widget getThemeBloc(ThemeBean themeBean, Size size, GlobalModel globalModel) {
    bool isCurrent = globalModel.currentThemeBean == themeBean;
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      onTap: () {
        if (isCurrent) return;
        globalModel.currentThemeBean = themeBean;
        globalModel.refresh();
        SharedUtil.instance
            .saveString(Keys.currentThemeBean, jsonEncode(themeBean.toMap()));
      },
      child: Container(
        height: (size.width - 140) / 4,
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        alignment: Alignment.center,
        child: Text(
          themeBean.themeName,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
        decoration: BoxDecoration(
          color: themeBean.themeType == MyTheme.darkTheme
              ? Colors.black
              : ColorBean.fromBean(themeBean.colorBean),
          shape: BoxShape.rectangle,
          border: isCurrent ? Border.all(color: Colors.grey, width: 3) : null,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }

  Widget getRandomColorBloc(Size size, GlobalModel globalModel) {
    final themeBean = ThemeBean(
      themeName: IntlLocalizations.of(_model.context).random,
      colorBean: ColorBean.fromColor(
          Colors.primaries[Random().nextInt(Colors.primaries.length)]),
      themeType: MyTheme.random,
    );
    bool isCurrent = globalModel.currentThemeBean == themeBean;
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      onTap: () {
        globalModel.currentThemeBean = themeBean;
        globalModel.refresh();
        SharedUtil.instance
            .saveString(Keys.currentThemeBean, jsonEncode(themeBean.toMap()));
      },
      child: Container(
        height: (size.width - 140) / 4,
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        alignment: Alignment.center,
        child: Text(
          themeBean.themeName,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: isCurrent ? Border.all(color: Colors.grey, width: 2) : null,
          gradient: LinearGradient(colors: [
            Colors.primaries[Random().nextInt(Colors.primaries.length)],
            Colors.primaries[Random().nextInt(Colors.primaries.length)],
            Colors.primaries[Random().nextInt(Colors.primaries.length)],
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
      ),
    );
  }

  void onAutoThemeChanged(GlobalModel globalModel, bool value) async {
    if(value){
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: _model.context,
          builder: (ctx) {
            return CustomTimePicker(callBack: (start, end){
              globalModel.enableAutoDarkMode = value;
              globalModel.autoDarkModeTimeRange = '$start/$end';
              SharedUtil.instance.saveBoolean(Keys.autoDarkMode, globalModel.enableAutoDarkMode);
              SharedUtil.instance.saveString(Keys.autoDarkModeTimeRange, globalModel.autoDarkModeTimeRange);
              globalModel.logic.chooseTheme();
              globalModel.refresh();
            },);
          });
    } else {
      globalModel.enableAutoDarkMode = value;
      SharedUtil.instance.saveBoolean(Keys.autoDarkMode, globalModel.enableAutoDarkMode);
      globalModel.logic.getCurrentTheme().then((value) => globalModel.refresh());
    }
  }

  String getTimeRangeText(String time, bool needToShow){
    if(time.isEmpty || !needToShow) return '';
    final times = time.split('/');
    if(time.length < 2) return '';
    return '${times[0]}-${times[1]}';
  }
}
