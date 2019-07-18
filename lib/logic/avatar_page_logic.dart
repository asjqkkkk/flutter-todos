import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/all_model.dart';

import 'package:todo_list/utils/file_util.dart';
import 'package:todo_list/utils/permission_request_util.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:image_picker/image_picker.dart';


class AvatarPageLogic{

  final AvatarPageModel _model;

  AvatarPageLogic(this._model);

  //头像设置
  void onAvatarSelect(AvatarType type, BuildContext context) {
    switch (type) {
      case AvatarType.local:
        PermissionReqUtil.getInstance().requestPermission(
          PermissionGroup.photos,
          granted: getImage,
          deniedDes: DemoLocalizations.of(context).deniedDes,
          context: context,
          openSetting: DemoLocalizations.of(context).openSystemSetting,
        );
        break;
      case AvatarType.net:
        break;
    }
  }

  Future getImage() async {
    final context = _model.context;


    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (Platform.isAndroid) {
        PermissionReqUtil.getInstance().requestPermission(
          PermissionGroup.photos,
          granted: () {
            _saveAndGetAvatarFile(image);
          },
          deniedDes: DemoLocalizations.of(context).deniedDes,
          context: context,
          openSetting: DemoLocalizations.of(context).openSystemSetting,
        );
        return;
      }
      _saveAndGetAvatarFile(image);
    }
  }

  void _saveAndGetAvatarFile(File file) async {
//    File croppedFile = await ImageCropper.cropImage(
//      sourcePath: file.path,
//      ratioX: 1.0,
//      ratioY: 1.0,
//      maxWidth: 512,
//      maxHeight: 512,
//    );
//    if(croppedFile == null) return;

    String newPath = await FileUtil.getInstance().getSavePath('/avatar/');
    String name = 'avator.jpg';
    File newFile = file.copySync(newPath + name);
    if (newFile.existsSync()) {
      final account =
          await SharedUtil.instance.getString(Keys.account) ?? "default";
      await SharedUtil.instance.saveString(Keys.localAvatarPath + account, newFile.path);
      await SharedUtil.instance.saveInt(Keys.currentAvatarType + account, CurrentAvatarType.local);
      _model.mainPageModel.currentAvatarType = CurrentAvatarType.local;
      getAvatarWidget().then((a){
        _model.refresh();
      });
      _model.mainPageModel.logic.getAvatarWidget().then((a){
        _model.mainPageModel.refresh();
      });
    }
  }

  Future getAvatarWidget() async {

    final mainPageModel = _model.mainPageModel;

    final account =
        await SharedUtil.instance.getString(Keys.account) ?? "default";
    switch (mainPageModel.currentAvatarType) {
      case CurrentAvatarType.defaultAvatar:
        _model.currentAvatarWidget = Image.asset("images/avatar.jpg");
        break;
      case CurrentAvatarType.local:
        final local = await SharedUtil().getString(Keys.localAvatarPath + account);
        File file = File(local);
        debugPrint("存在吗:${file.existsSync()}");
        if (file.existsSync()) {
          _model.currentAvatarWidget = Image.file(
            file,
            fit: BoxFit.scaleDown,
          );
        } else {
          _model.currentAvatarWidget = Image.asset("images/avatar.jpg");
        }
        break;
      case CurrentAvatarType.net:
        final net = await SharedUtil().getString(Keys.netAvatarPath + account);
        _model.currentAvatarWidget = Image.network(net);
        break;
    }
  }

}

