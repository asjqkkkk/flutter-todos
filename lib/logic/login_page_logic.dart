import 'package:flutter/cupertino.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/config/api_strategy.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/database/database.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/login_bean.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/utils/my_encrypt_util.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/widgets/net_loading_widget.dart';

class LoginPageLogic {
  final LoginPageModel _model;

  LoginPageLogic(this._model);

  void onExit() {
    _model.currentAnimation = "move_out";
    _model.showLoginWidget = false;
    _model.refresh();
  }

  String validatorEmail(String email) {
    final context = _model.context;
    _model.isEmailOk = false;
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (email.isEmpty)
      return DemoLocalizations.of(context).emailCantBeEmpty;
    else if (!regex.hasMatch(email))
      return DemoLocalizations.of(context).emailIncorrectFormat;
    else {
      _model.isEmailOk = true;
      return null;
    }
  }

  String validatePassword(String password) {
    final context = _model.context;
    _model.isPasswordOk = false;
    if (password.isEmpty) {
      return DemoLocalizations.of(context).passwordCantBeEmpty;
    } else if (password.length < 8) {
      return DemoLocalizations.of(context).passwordTooShort;
    } else if (password.length > 20) {
      return DemoLocalizations.of(context).passwordTooLong;
    } else {
      _model.isPasswordOk = true;
      return null;
    }
  }

  void onLogin() {
    final context = _model.context;
    _model.formKey.currentState.validate();
    if (!_model.isEmailOk || !_model.isPasswordOk) {
      _showDialog(DemoLocalizations.of(context).checkYourEmailOrPassword, context);
      return;
    }
    showDialog(context: _model.context, builder: (ctx){
      return NetLoadingWidget();
    });
    _onLoginRequest(context);
  }

  void onForget() {
    Navigator.of(_model.context).push(new CupertinoPageRoute(builder: (ctx) {
      return ProviderConfig.getInstance().getResetPasswordPage(isReset: false);
    }));
  }

  void onRegister() {
    Navigator.of(_model.context).push(new CupertinoPageRoute(builder: (ctx) {
        return ProviderConfig.getInstance().getRegisterPage();
    }));
  }

  void onSkip(){
    SharedUtil.instance.saveBoolean(Keys.hasLogged, true);
    Navigator.of(_model.context).pushAndRemoveUntil(
        new MaterialPageRoute(builder: (context) {
            return ProviderConfig.getInstance().getMainPage();
        }), (router) => router == null);
  }


  void _showDialog(String text, BuildContext context) {
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

  void _onLoginRequest(BuildContext context) {

    final account = _model.emailController.text;
    final password = _model.passwordController.text;
    final encryptPassword = EncryptUtil.instance.encrypt(password);

    ApiService.instance.login(
      params: {
        "account": "$account",
        "password": "$encryptPassword"
      },
      success: (LoginBean loginBean) {
        SharedUtil.instance.saveString(Keys.account, account).then((value){
          SharedUtil.instance.saveString(Keys.password, encryptPassword);
          SharedUtil.instance.saveString(Keys.currentUserName, loginBean.username);
          SharedUtil.instance.saveString(Keys.token, loginBean.token);
          SharedUtil.instance.saveBoolean(Keys.hasLogged, true);
          if(loginBean.avatarUrl != null){
            SharedUtil.instance.saveString(Keys.netAvatarPath, ApiStrategy.baseUrl + loginBean.avatarUrl);
            SharedUtil.instance.saveInt(Keys.currentAvatarType, CurrentAvatarType.net);
          }
        }).then((v){
          DBProvider.db.updateAccount(account).then((v){
            Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(
                    builder: (context){
                      return ProviderConfig.getInstance().getMainPage();
                    }),
                    (router) => router == null);
          });
        });

      },
      failed: (LoginBean loginBean) {
        Navigator.of(context).pop();
        _showDialog(loginBean.description, context);
      },
      error: (msg) {
        Navigator.of(context).pop();
        _showDialog(msg, context);
      },
      token: _model.cancelToken,
    );
  }
}
