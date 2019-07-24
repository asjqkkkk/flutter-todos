import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:image_crop/image_crop.dart';
import 'package:todo_list/pages/avatar_history_page.dart';
import 'package:todo_list/utils/file_util.dart';
import 'package:todo_list/utils/permission_request_util.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:image_picker/image_picker.dart';

class AvatarPageLogic {
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
      case AvatarType.history:
        Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx) {
          return AvatarHistoryPage(
            currentAvatarUrl: _model.mainPageModel.currentAvatarUrl,
            avatarPageModel: _model,
          );
        }));
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
    _model.currentAvatarType = CurrentAvatarType.local;
    _model.currentAvatarUrl = file.path;
    _model.refresh();
  }

  void onSaveTap() async {
    final croppedFile = await ImageCrop.cropImage(
      file: File(_model.currentAvatarUrl),
      area: _model.cropKey.currentState.area,
    );
    await _saveImage(croppedFile);
  }

  Future _saveImage(File file) async {
    String newPath = await FileUtil.getInstance().getSavePath('/avatar/');
    String name = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    File newFile = file.copySync(newPath + name);
    if (newFile.existsSync()) {
      await SharedUtil.instance.saveString(Keys.localAvatarPath,newFile.path);
      await SharedUtil.instance.saveInt(Keys.currentAvatarType, CurrentAvatarType.local);
      _model.mainPageModel.currentAvatarType = CurrentAvatarType.local;
      _model.mainPageModel.currentAvatarUrl = newFile.path;
      _model.mainPageModel.refresh();
      Navigator.of(_model.context).pop();
    }
  }

  ImageProvider getAvatarProvider() {
    final avatarType = _model.currentAvatarType;
    final url = _model.currentAvatarUrl;
    switch (avatarType) {
      case CurrentAvatarType.defaultAvatar:
        return AssetImage("images/icon.png");
        break;
      case CurrentAvatarType.local:
        File file = File(url);
        if (file.existsSync()) {
          return FileImage(file);
        } else {
          return AssetImage("images/icon.png");
        }
        break;
      case CurrentAvatarType.net:
        return NetworkImage(url);
        break;
    }
  }
}
