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
import 'package:todo_list/pages/avatar_page.dart';
import 'package:todo_list/utils/file_util.dart';
import 'package:todo_list/utils/permission_request_util.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/utils/theme_util.dart';
import 'package:todo_list/widgets/loading_widget.dart';
import 'package:image_picker/image_picker.dart';

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
    DBProvider.db.deleteTask(id).then((a) {
      getTasks();
    });
  }

  void editTask(TaskBean taskBean) {
    Navigator.of(_model.context).push(
      new CupertinoPageRoute(
        builder: (ctx) {
          return ProviderConfig.getInstance().getEditTaskPage(
              taskBean.taskIconBean,
              mainPageModel: _model,
              taskBean: taskBean);
        },
      ),
    );
  }

  //当任务列表为空时显示的内容
  Widget getEmptyWidget() {
    final context = _model.context;
    final size = MediaQuery.of(context).size;
    final theMin = min(size.width - 100, size.height - 100);
    return Container(
      alignment: Alignment.center,
      child: LoadingWidget(
        child: Container(
          height: theMin,
          width: theMin,
          margin: EdgeInsets.fromLTRB(10, 50, 10, 0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColorLight,
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColorLight,
                ],
              )),
          child: Icon(
            Icons.favorite,
            size: 50,
            color: Theme.of(context).primaryColorLight,
          ),
        ),
      ),
    );
  }


  Future getCurrentAvatar() async{
    switch (_model.currentAvatarType) {
      case CurrentAvatarType.defaultAvatar:
        final path =  await FileUtil.getInstance().copyAssetToFile("images/", "avatar.jpg", "/avatar/", "avatar.jpg");
        _model.currentAvatarUrl = path;
        _model.currentAvatarType = CurrentAvatarType.local;
        break;
      case CurrentAvatarType.local:
        final path = await SharedUtil().getString(Keys.localAvatarPath) ?? "";
        File file = File(path);
        if(file.existsSync()){
          _model.currentAvatarUrl = file.path;
        } else {
          _model.currentAvatarUrl = "images/avatar.jpg";
        }
        break;
      case CurrentAvatarType.net:
        final net = await SharedUtil().getString(Keys.netAvatarPath);
        _model.currentAvatarUrl = net;
        break;
    }

  }

  Widget getAvatarWidget(){
    switch (_model.currentAvatarType) {
      case CurrentAvatarType.defaultAvatar:
        return Image.asset("images/avatar.jpg",fit: BoxFit.cover,);
        break;
      case CurrentAvatarType.local:
        File file = File(_model.currentAvatarUrl);
        if(file.existsSync()){
          return Image.file(file,fit: BoxFit.fill,);
        } else {
          return Image.asset("images/avatar.jpg",fit: BoxFit.cover,);
        }
        break;
      case CurrentAvatarType.net:
        return Image.network(_model.currentAvatarUrl,fit: BoxFit.cover,);
        break;
    }
  }
  
  Future getAvatarType() async{
    final currentAvatarType = await SharedUtil.instance.getInt(Keys.currentAvatarType );
    debugPrint("type:${currentAvatarType}");
    if(currentAvatarType == null) return;
    if(currentAvatarType == _model.currentAvatarType) return;
    _model.currentAvatarType = currentAvatarType;
  }

  void onAvatarTap() {
    Navigator.of(_model.context).push(new CupertinoPageRoute(builder: (ctx){
      return ProviderConfig.getInstance().getAvatarPage(mainPageModel: _model);
    }));
  }

}

