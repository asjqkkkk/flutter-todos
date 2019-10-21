import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/task_icon_bean.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/utils/icon_list_util.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/widgets/custom_icon_widget.dart';

class IconSettingPageLogic {
  final IconSettingPageModel _model;

  IconSettingPageLogic(this._model);

  void onIconPress(IconBean iconBean,
      {ColorBean colorBean, String name, bool isEdit = false, int index}) {
    showDialog(
        barrierDismissible: false,
        context: _model.context,
        builder: (ctx) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              elevation: 0.0,
              contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              title: Text(DemoLocalizations.of(_model.context).customIcon),
              content: CustomIconWidget(
                iconData: IconBean.fromBean(iconBean),
                onApplyTap: (color) async {
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
                  if (isEdit) {
                    //如果不是新增而是编辑
                   SharedUtil.instance.readAndExchangeList(
                        Keys.taskIconBeans, data, index);
                  } else {
                    //如果是新增
                    final canAddMore = await SharedUtil.instance
                        .readAndSaveList(Keys.taskIconBeans, data);
                    if (!canAddMore) {
                      showCanNotAddIcon();
                      return;
                    }
                  }
                  getTaskIconList();
                },
                pickerColor: colorBean == null
                    ? _model.currentPickerColor
                    : ColorBean.fromBean(colorBean),
                onTextChange: (text) {
                  final name = text.isEmpty
                      ? DemoLocalizations.of(_model.context).defaultIconName
                      : text;
                  _model.currentIconName = name;
                },
                iconName: name ?? iconBean.iconName,
              ));
        },);
  }

  Future getTaskIconList() async {
    final list =
        await IconListUtil.getInstance().getIconWithCache(_model.context);
    _model.taskIcons.clear();
    _model.taskIcons.addAll(list);
    if (list.length == 6) {
      _model.isDeleting = false;
    }
    _model.refresh();
  }

  Future getIconList() async {
    final iconList = await IconBean.loadAsset();
    _model.showIcons.clear();
    _model.showIcons.addAll(iconList);
  }

  void showCanNotAddIcon() {
    showDialog(
        context: _model.context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content:
                Text(DemoLocalizations.of(_model.context).canNotAddMoreIcon),
          );
        });
  }
//
//  void tapDefaultIcon(int index) {
//    if (index <= 5) {
//      showDialog(
//          context: _model.context,
//          builder: (ctx) {
//            return AlertDialog(
//              shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
//              content: Text(
//                  DemoLocalizations.of(_model.context).canNotEditDefaultIcon),
//            );
//          });
//    }
//    ;
//  }

  void removeIcon(int index) {
    SharedUtil.instance.readAndRemoveList(Keys.taskIconBeans, index);
    getTaskIconList().then((value) {
      _model.refresh();
    });
  }

  Widget getIconsWidget() {
    final showIcons = _model.showIcons;
    final searchIcons = _model.searchIcons;
    final context = _model.context;

    final showIconList = searchIcons.isEmpty ? showIcons : searchIcons;

    if (showIcons.isEmpty) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
        ),
      );
    }

    if (_model.isSearching &&
        searchIcons.isEmpty &&
        _model.textEditingController.text.isNotEmpty) {
      return Center(
        child: LoadingWidget(
          flag: LoadingFlag.empty,
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 5,
      childAspectRatio: 0.8,
      padding: EdgeInsets.all(2),
      children: List.generate(
        showIconList.length,
        (index) {
          final icon = showIconList[index];
          final name = showIconList[index].iconName;
          return Container(
            margin: EdgeInsets.all(4),
            child: Column(
              children: <Widget>[
                IconButton(
                  onPressed: () => onIconPress(icon),
                  icon: Icon(
                    IconBean.fromBean(icon),
                    size: 30,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 10),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  AppBar getSearchBar(GlobalModel globalModel) {
    final textColor = globalModel.logic.getWhiteInDark();

    return AppBar(
      title: TextField(
        textInputAction: TextInputAction.search,
        autofocus: true,
        focusNode: _model.focusNode,
        style: TextStyle(color: textColor,textBaseline: TextBaseline.alphabetic),
        controller: _model.textEditingController
          ..addListener(() {
            final text = _model.textEditingController.text;
            onSearchTextChange(text);
          }),
        onEditingComplete: () => _model.focusNode.unfocus(),
        decoration: new InputDecoration(
          hintText: DemoLocalizations.of(_model.context).searchIcon,
          hintStyle: TextStyle(color: textColor),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.clear,
              color: textColor,
            ),
            onPressed: () => Future.delayed(
              Duration(milliseconds: 100),
              () => _model.textEditingController?.clear(),
            ),
          ),
          border: InputBorder.none,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1),
          ),
        ),
      ),
    );
  }

  void onSearchTextChange(String text) {
    if (text == null) return;
    _model.searchIcons.clear();
    if (text.isEmpty) {
      _model.refresh();
      return;
    }
    
    for (var i = 0; i < _model.showIcons.length; ++i) {
      final icon = _model.showIcons[i];
      final iconName = icon.iconName;
      if (iconName.contains(text)) {
        _model.searchIcons.add(icon);
      }
    }
    _model.refresh();
  }
}
