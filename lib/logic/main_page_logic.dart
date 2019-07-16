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
import 'package:todo_list/utils/file_util.dart';
import 'package:todo_list/utils/permission_request_util.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/utils/theme_util.dart';
import 'package:todo_list/widgets/loading_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

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

  //头像设置
  void onAvatarSelect(AvatarType type) {
    switch (type) {
      case AvatarType.local:
        PermissionReqUtil.getInstance().requestPermission(
          PermissionGroup.photos,
          granted: () {
            getImage();
          },
          deniedDes: DemoLocalizations.of(_model.context).deniedDes,
          context: _model.context,
          openSetting: DemoLocalizations.of(_model.context).openSystemSetting,
        );
        break;
      case AvatarType.net:
        break;
    }
  }

  //这里权限申请还是需要做好才行
  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (Platform.isAndroid) {
        PermissionReqUtil.getInstance().requestPermission(
          PermissionGroup.photos,
          granted: () {
            _saveAndGetAvatarFile(image);
          },
          deniedDes: DemoLocalizations.of(_model.context).deniedDes,
          context: _model.context,
          openSetting: DemoLocalizations.of(_model.context).openSystemSetting,
        );
        return;
      }
      _saveAndGetAvatarFile(image);
    }
  }

  void _saveAndGetAvatarFile(File file) async {

    File croppedFile = await ImageCropper.cropImage(
      sourcePath: file.path,
      ratioX: 1.0,
      ratioY: 1.0,
      maxWidth: 512,
      maxHeight: 512,
    );
    if(croppedFile == null) return;

    String newPath = await FileUtil.getInstance().getSavePath('/avatar/');
    String name = 'avator.jpg';
    File newFile = croppedFile.copySync(newPath + name);
    if (newFile.existsSync()) {
      final account = await SharedUtil.instance.getString(Keys.account) ?? "default";
      SharedUtil.instance.saveString(Keys.localAvatarPath + account, newFile.path);
      SharedUtil.instance.saveInt(Keys.currentAvatarType + account, CurrentAvatarType.local);
      _model.currentAvatarType = CurrentAvatarType.local;
      _model.refresh();
    }
  }

  Future<Widget> getAvatarWidget() async{
    final account = await SharedUtil.instance.getString(Keys.account) ?? "default";
    switch (_model.currentAvatarType) {
      case CurrentAvatarType.defaultType:
        return Image.asset("images/avatar.jpg");
        break;
      case CurrentAvatarType.local:
        final local = await SharedUtil().getString(Keys.localAvatarPath + account);
        File file = File(local);
        if(file.existsSync()){
          return Image.file(File(local),fit: BoxFit.scaleDown,);
        } else {
          return Image.asset("images/avatar.jpg");
        }
        break;
      case CurrentAvatarType.net:
        final net = await SharedUtil().getString(Keys.netAvatarPath + account);
        return Image.network(net);
        break;
    }
  }
  
  Future getAvatar() async{
    final account = await SharedUtil.instance.getString(Keys.account) ?? "default";
    final currentAvatarType = await SharedUtil.instance.getInt(Keys.currentAvatarType + account);
    debugPrint("type:${currentAvatarType}");
    if(currentAvatarType == null) return;
    if(currentAvatarType == _model.currentAvatarType) return;
    _model.currentAvatarType = currentAvatarType;
  }
}

enum AvatarType {
  local,
  net,
}
