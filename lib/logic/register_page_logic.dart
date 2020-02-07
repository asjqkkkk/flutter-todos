import 'package:flutter/material.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/config/api_strategy.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/database/database.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/utils/my_encrypt_util.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/widgets/net_loading_widget.dart';

class RegisterPageLogic{

  final RegisterPageModel _model;

  RegisterPageLogic(this._model);

  String validatorUserName(String userName) {
    final context = _model.context;
    _model.isUserNameOk = false;
    if (userName.isEmpty) {
      return IntlLocalizations.of(context).usernameCantBeEmpty;
    } else if (userName.contains(" ")) {
      return IntlLocalizations.of(context).userNameContainEmpty;
    } else {
      _model.userName = userName;
      _model.isUserNameOk = true;
      debugPrint("用户名通过");
      _model.refresh();
      return null;
    }
  }

  String validatorVerifyCode(String verifyCode) {
    final context = _model.context;
    _model.isVerifyCodeOk = false;
    if (verifyCode.isEmpty) {
      return IntlLocalizations.of(context).verifyCodeCantBeEmpty;
    } else if (verifyCode.contains(" ")) {
      return IntlLocalizations.of(context).verifyCodeContainEmpty;
    } else {
      _model.verifyCode = verifyCode;
      _model.isVerifyCodeOk = true;
      debugPrint("验证码通过");
      _model.refresh();
      return null;
    }
  }

  String validatorEmail(String email) {
    final context = _model.context;
    _model.isEmailOk = false;
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (email.isEmpty)
      return IntlLocalizations.of(context).emailCantBeEmpty;
    else if (!regex.hasMatch(email))
      return IntlLocalizations.of(context).emailIncorrectFormat;
    else {
      _model.isEmailOk = true;
      _model.email = email;
      debugPrint("邮箱通过");
      _model.refresh();
      return null;
    }
  }

  String validateRePassword(String rePassword) {
    _model.isRePasswordOk = false;
    final context = _model.context;
    if (rePassword.isEmpty) {
      return IntlLocalizations.of(context).confirmPasswordCantBeEmpty;
    } else if (_model.password != rePassword) {
      return IntlLocalizations.of(context).twoPasswordsNotSame;
    } else if(rePassword.contains(" ")){
      return IntlLocalizations.of(context).confirmPasswordContainEmpty;
    }
    else {
      _model.rePassword = rePassword;
      _model.isRePasswordOk = true;
      debugPrint("密码2通过");
      _model.refresh();
      return null;
    }
  }

  String validatePassword(String password) {
    _model.isPasswordOk = false;
    final context = _model.context;
    if (password.isEmpty) {
      return  IntlLocalizations.of(context).passwordCantBeEmpty;
    } else if (password.length < 8) {
      return IntlLocalizations.of(context).passwordTooShort;
    } else if (password.length > 20) {
      return IntlLocalizations.of(context).passwordTooLong;
    } else {
      _model.password = password;
      _model.isPasswordOk = true;
      debugPrint("密码通过");
      _model.refresh();
      return null;
    }
  }

  void _validate(){
    bool b1 = _model.emailKey?.currentState?.validate();
    bool b2 = _model.userNameKey?.currentState?.validate();
    bool b3 = _model.rePasswordKey?.currentState?.validate();
    bool b4 = _model.passwordKey?.currentState?.validate();
    bool b5 = _model.verifyCodeKey?.currentState?.validate();
    debugPrint("$b1 - $b2 - $b3 - $b4 - $b5");
  }

  void onSubmit(){
    final model = _model;
    final context = _model.context;
    _validate();
    if(!model.isUserNameOk || !model.isEmailOk || !model.isVerifyCodeOk || !model.isPasswordOk || !model.isRePasswordOk){
      _showTextDialog(IntlLocalizations.of(context).wrongParams, context);
      return;
    }
    showDialog(context: context, builder: (ctx){
      return NetLoadingWidget();
    });
    _registerEmail(model, context);
  }

  void _registerEmail(RegisterPageModel model, BuildContext context) {
       final encryptPassword = EncryptUtil().encrypt(model.password);
    ApiService.instance.postRegister(
      params: {
        "account": model.email,
        "password": encryptPassword,
        "accountType": "0",
        "username": model.userName,
        "identifyCode": model.verifyCode,
      },
      success: (RegisterBean bean){
        SharedUtil.instance.saveString(Keys.account, model.email).then((value){
          SharedUtil.instance.saveString(Keys.password, encryptPassword);
          SharedUtil.instance.saveString(Keys.currentUserName, model.userName);
          SharedUtil.instance.saveString(Keys.token, bean.token);
          SharedUtil.instance.saveBoolean(Keys.hasLogged, true);
          if(bean.avatarUrl != null){
            SharedUtil.instance.saveString(Keys.netAvatarPath, ApiStrategy.baseUrl + bean.avatarUrl);
            SharedUtil.instance.saveInt(Keys.currentAvatarType, CurrentAvatarType.net);
          }
        }).then((v){
          DBProvider.db.updateAccount(model.email).then((v){
            Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(
                    builder: (context){
                      return ProviderConfig.getInstance().getMainPage();
                    }),
                    (router) => router == null);
          });
        });
      },
      failed: (RegisterBean bean){
        Navigator.of(context).pop();
        _showTextDialog(bean.description, context);
      },
      error: (msg){
        Navigator.of(context).pop();
        _showTextDialog(msg, context);
      },
      token: _model.cancelToken,
    );
  }

  void _showTextDialog(String text, BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            content: Text(text),
          );
        });
  }

}