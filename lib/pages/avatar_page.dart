import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/main_page_model.dart';
import 'package:todo_list/utils/file_util.dart';
import 'package:todo_list/utils/permission_request_util.dart';
import 'package:todo_list/utils/shared_util.dart';

class AvatarPage extends StatelessWidget {
  final MainPageModel mainPageModel;

  const AvatarPage({Key key, this.mainPageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("头像"),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (value) => onAvatarSelect(value, context),
            itemBuilder: (ctx) {
              return [
                PopupMenuItem(
                  value: AvatarType.local,
                  child: Container(
                    child: Text(DemoLocalizations.of(context).avatarLocal),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                PopupMenuItem(
                  value: AvatarType.net,
                  child: Container(
                    child: Text(DemoLocalizations.of(context).avatarNet),
                    alignment: Alignment.centerLeft,
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Hero(
        tag: "avatar",
        child: Container(
          alignment: Alignment.center,
          child: FutureBuilder(
            future: getAvatarWidget(),
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data;
              } else {
                return CircularProgressIndicator(
                  valueColor:
                  AlwaysStoppedAnimation(Colors.white),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  //头像设置
  void onAvatarSelect(AvatarType type, BuildContext context) {
    switch (type) {
      case AvatarType.local:
        PermissionReqUtil.getInstance().requestPermission(
          PermissionGroup.photos,
          granted: () {
            getImage(context);
          },
          deniedDes: DemoLocalizations.of(context).deniedDes,
          context: context,
          openSetting: DemoLocalizations.of(context).openSystemSetting,
        );
        break;
      case AvatarType.net:
        break;
    }
  }

  Future getImage(BuildContext context) async {
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
      SharedUtil.instance
          .saveString(Keys.localAvatarPath + account, newFile.path);
      SharedUtil.instance
          .saveInt(Keys.currentAvatarType + account, CurrentAvatarType.local);
      mainPageModel.currentAvatarType = CurrentAvatarType.local;
      mainPageModel.refresh();
    }
  }

  Future<Widget> getAvatarWidget() async {
    final account =
        await SharedUtil.instance.getString(Keys.account) ?? "default";
    switch (mainPageModel.currentAvatarType) {
      case CurrentAvatarType.defaultAvatar:
        return Image.asset("images/avatar.jpg");
        break;
      case CurrentAvatarType.local:
        final local =
            await SharedUtil().getString(Keys.localAvatarPath + account);
        File file = File(local);
        if (file.existsSync()) {
          return Image.file(
            File(local),
            fit: BoxFit.scaleDown,
          );
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
}

enum AvatarType {
  local,
  net,
}
