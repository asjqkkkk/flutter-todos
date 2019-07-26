import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/database/database.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/items/task_item.dart';
import 'package:todo_list/json/color_bean.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/pages/search_page.dart';
import 'package:todo_list/utils/file_util.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/utils/theme_util.dart';
import 'package:todo_list/widgets/edit_dialog.dart';
import 'package:todo_list/widgets/scale_animation_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPageLogic {
  final MainPageModel _model;

  MainPageLogic(this._model);

  List<Widget> getCards(context) {
    return List.generate(_model.tasks.length, (index) {
      final taskBean = _model.tasks[index];
      return GestureDetector(
        child: TaskItem(
          taskBean.id,
          taskBean,
          onEdit: () => _model.logic.editTask(taskBean),
          onDelete: () => _model.logic.deleteTask(taskBean.id),
        ),
        onTap: () {
          _model.currentTapIndex = index;
          Navigator.of(context).push(new PageRouteBuilder(
              pageBuilder: (ctx, anm, anmS) {
                return ProviderConfig.getInstance()
                    .getTaskDetailPage(taskBean.id, taskBean);
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

  Future getTasks() async {
    final tasks = await DBProvider.db.getTasks();
    if (tasks == null) return;
    _model.tasks.clear();
    _model.tasks.addAll(tasks);
  }

  Future getCurrentUserName() async {
    final currentUserName =
        await SharedUtil.instance.getString(Keys.currentUserName);
    if (currentUserName == null) return;
    if (currentUserName == _model.currentUserName) return;
    _model.currentUserName = currentUserName;
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

  void deleteTask(int id) {
    DBProvider.db.deleteTask(id).then((a) {
      getTasks().then((value) {
        _model.refresh();
      });
    });
  }

  void editTask(TaskBean taskBean) {
    Navigator.of(_model.context).push(
      new CupertinoPageRoute(
        builder: (ctx) {
          return ProviderConfig.getInstance()
              .getEditTaskPage(taskBean.taskIconBean, taskBean: taskBean);
        },
      ),
    );
  }

  //当任务列表为空时显示的内容
  Widget getEmptyWidget(GlobalModel globalModel) {
    final context = _model.context;
    final size = MediaQuery.of(context).size;
    final theMin = min(size.width, size.height) / 2;
    return Container(
      margin: EdgeInsets.only(top: 40),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        "svgs/empty_list.svg",
        color: globalModel.logic.getWhiteInDark(),
        width: theMin,
        height: theMin,
        semanticsLabel: 'empty list',
      ),
    );
  }

  Future getCurrentAvatar() async {
    switch (_model.currentAvatarType) {
      case CurrentAvatarType.defaultAvatar:
        final path = await FileUtil.getInstance()
            .copyAssetToFile("images/", "icon.png", "/avatar/", "icon.png");
        _model.currentAvatarUrl = path;
        _model.currentAvatarType = CurrentAvatarType.local;
        break;
      case CurrentAvatarType.local:
        final path = await SharedUtil().getString(Keys.localAvatarPath) ?? "";
        File file = File(path);
        if (file.existsSync()) {
          _model.currentAvatarUrl = file.path;
        } else {
          _model.currentAvatarUrl = "images/icon.png";
        }
        break;
      case CurrentAvatarType.net:
        final net = await SharedUtil().getString(Keys.netAvatarPath);
        _model.currentAvatarUrl = net;
        break;
    }
  }

  Widget getAvatarWidget() {
    switch (_model.currentAvatarType) {
      case CurrentAvatarType.defaultAvatar:
        return Image.asset(
          "images/icon.png",
          fit: BoxFit.cover,
        );
        break;
      case CurrentAvatarType.local:
        File file = File(_model.currentAvatarUrl);
        if (file.existsSync()) {
          return Image.file(
            file,
            fit: BoxFit.fill,
          );
        } else {
          return Image.asset(
            "images/icon.png",
            fit: BoxFit.cover,
          );
        }
        break;
      case CurrentAvatarType.net:
        return Image.network(
          _model.currentAvatarUrl,
          fit: BoxFit.cover,
        );
        break;
    }
  }

  Future getAvatarType() async {
    final currentAvatarType =
        await SharedUtil.instance.getInt(Keys.currentAvatarType);
    debugPrint("type:${currentAvatarType}");
    if (currentAvatarType == null) return;
    if (currentAvatarType == _model.currentAvatarType) return;
    _model.currentAvatarType = currentAvatarType;
  }

  void onAvatarTap() {
    Navigator.of(_model.context).push(new CupertinoPageRoute(builder: (ctx) {
      return ProviderConfig.getInstance().getAvatarPage(mainPageModel: _model);
    }));
  }

  void onUserNameTap() {
    final context = _model.context;
    showDialog(
        context: context,
        builder: (ctx) {
          return EditDialog(
            title: DemoLocalizations.of(context).customUserName,
            hintText: DemoLocalizations.of(context).inputUserName,
            onValueChanged: (text) {
              _model.currentUserName = text;
            },
            initialValue: _model.currentUserName,
            onPositive: () {
              if (_model.currentUserName.isEmpty) {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        content: Text(
                            DemoLocalizations.of(context).userNameCantBeNull),
                      );
                    });
                return;
              }
              SharedUtil.instance
                  .saveString(Keys.currentUserName, _model.currentUserName);
              _model.refresh();
            },
          );
        });
  }

  void onSearchTap() {
    Navigator.of(_model.context).push(new CupertinoPageRoute(builder: (ctx) {
      return ProviderConfig.getInstance().getSearchPage();
    }));
  }
}
