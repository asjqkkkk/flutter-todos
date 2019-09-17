import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/config/all_types.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/utils/shared_util.dart';

class AccountPageLogic{

  final AccountPageModel _model;

  AccountPageLogic(this._model);


  Future getAvatarUrl() async {
    _model.avatarUrl = await SharedUtil.instance.getString(Keys.localAvatarPath);
  }

  Future getUserName() async {
    _model.userName = await SharedUtil.instance.getString(Keys.currentUserName);
  }

  Future getEmailAccount() async {
    _model.emailAccount = await SharedUtil.instance.getString(Keys.account);
  }

  Future getBackgroundType() async{
    _model.backgroundType = await SharedUtil.instance.getString(Keys.currentAccountBackgroundType) ?? AccountBGType.defaultType;
  }

  Future getBackgroundUrl() async {
    _model.backgroundUrl = await SharedUtil.instance.getString(Keys.currentAccountBackground);
  }

  Widget getAvatar(Color color) {
    return _model.avatarUrl != null
        ? Container(
      width: 100,
      height: 100,
      child: ClipRRect(
        child: Image.file(File(_model.avatarUrl)),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
    )
        : Container(
      width: 100,
      height: 100,
      child: ClipRRect(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(color),
        ),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
    );
  }

  void onLogoutPressed(){
    SharedUtil.instance
        .saveString(Keys.account, "default")
        .then((v) {
      SharedUtil.instance
          .saveBoolean(Keys.hasLogged, false);
    });

    Navigator.of(_model.context).pushAndRemoveUntil(
        new MaterialPageRoute(builder: (context) {
          return ProviderConfig.getInstance()
              .getLoginPage(isFirst: true);
        }), (router) => router == null);
  }

  void onResetPasswordPressed(){
    Navigator.of(_model.context)
        .push(new CupertinoPageRoute(builder: (ctx) {
      return ProviderConfig.getInstance()
          .getResetPasswordPage();
    }));
  }

  void onBackgroundTap(){
    Navigator.of(_model.context).push(new CupertinoPageRoute(builder: (ctx) {
      return ProviderConfig.getInstance().getNetPicturesPage(
        useType: NetPicturesUseType.accountBackground,
        accountPageModel: _model,
      );
    }));
  }

}