import 'package:flutter/material.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/utils/my_encrypt_util.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/widgets/net_loading_widget.dart';

class ResetPasswordPageLogic {
  final ResetPasswordPageModel _model;

  ResetPasswordPageLogic(this._model);

  String validatorVerifyCode(String verifyCode) {
    final context = _model.context;
    _model.isVerifyCodeOk = false;
    if (verifyCode.isEmpty) {
      return DemoLocalizations.of(context).verifyCodeCantBeEmpty;
    } else if (verifyCode.contains(" ")) {
      return DemoLocalizations.of(context).verifyCodeContainEmpty;
    } else {
      _model.verifyCode = verifyCode;
      _model.isVerifyCodeOk = true;
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
      return DemoLocalizations.of(context).emailCantBeEmpty;
    else if (!regex.hasMatch(email))
      return DemoLocalizations.of(context).emailIncorrectFormat;
    else {
      _model.isEmailOk = true;
      _model.emailAccount = email;
      return null;
    }
  }

  String validateRePassword(String rePassword) {
    _model.isRePasswordOk = false;
    final context = _model.context;
    if (rePassword.isEmpty) {
      return DemoLocalizations.of(context).confirmPasswordCantBeEmpty;
    } else if (_model.newPassword != rePassword) {
      return DemoLocalizations.of(context).twoPasswordsNotSame;
    } else if (rePassword.contains(" ")) {
      return DemoLocalizations.of(context).confirmPasswordContainEmpty;
    } else {
      _model.rePassword = rePassword;
      _model.isRePasswordOk = true;
      return null;
    }
  }

  String validateNewPassword(String password) {
    _model.isNewPasswordOk = false;
    final context = _model.context;
    if (password.isEmpty) {
      return DemoLocalizations.of(context).newPasswordCantBeEmpty;
    } else if (password.length < 8) {
      return DemoLocalizations.of(context).passwordTooShort;
    } else if (password.length > 20) {
      return DemoLocalizations.of(context).passwordTooLong;
    } else {
      _model.newPassword = password;
      _model.isNewPasswordOk = true;
      return null;
    }
  }

  String validateOldPassword(String password) {
    _model.isOldPasswordOk = false;
    final context = _model.context;
    if (password.isEmpty) {
      return DemoLocalizations.of(context).oldPasswordCantBeEmpty;
    } else if (password.length < 8) {
      return DemoLocalizations.of(context).passwordTooShort;
    } else if (password.length > 20) {
      return DemoLocalizations.of(context).passwordTooLong;
    } else {
      _model.oldPassword = password;
      _model.isOldPasswordOk = true;
      return null;
    }
  }

  void onSubmit() {
    final model = _model;
    final context = _model.context;
    _model.formKey.currentState.validate();
    ///如果是重新设置密码
    if (model.isReset) {
      if (!model.isOldPasswordOk ||
          !model.isNewPasswordOk ||
          !model.isRePasswordOk) {
        _showTextDialog(DemoLocalizations.of(context).wrongParams, context);
        return;
      }
      showDialog(context: context, builder: (ctx){
        return NetLoadingWidget(
          onRequest: (){
            _onResetPasswordRequest();
          },
          successText: DemoLocalizations.of(context).resetPasswordSuccess,
          errorText: DemoLocalizations.of(context).resetPasswordFailed,
          loadingController: _model.loadingController,
          onSuccess: (){
            Navigator.of(_model.context).popUntil((route) => route.isFirst);
          },

        );
      });
    }
    ///如果是忘记密码
    else {
      if (!model.isEmailOk ||
          !model.isVerifyCodeOk ||
          !model.isNewPasswordOk ||
          !model.isRePasswordOk) {
        _showTextDialog(DemoLocalizations.of(context).wrongParams, context);
        return;
      }
      showDialog(context: context, builder: (ctx){
        return NetLoadingWidget(
          onRequest: (){
            _onForgetPasswordRequest();
          },
          successText: DemoLocalizations.of(context).resetPasswordSuccess,
          errorText: DemoLocalizations.of(context).resetPasswordFailed,
          loadingController: _model.loadingController,
          onSuccess: (){
            Navigator.of(_model.context).pop();
            Navigator.of(_model.context).pop();
          },
        );
      });
    }
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

  _onResetPasswordRequest() async {
    final account = await SharedUtil.instance.getString(Keys.account);
    final token = await SharedUtil.instance.getString(Keys.token);
    final oldPassword = _model.oldPassword;
    final newPassword = _model.newPassword;
    final confirmPassword = _model.rePassword;
    final encryptOldPW = EncryptUtil.instance.encrypt(oldPassword);
    final encryptNewPW = EncryptUtil.instance.encrypt(newPassword);
    final encryptConfirmPW = EncryptUtil.instance.encrypt(confirmPassword);
    ApiService.instance.postResetPassword(
      params: {
        "account": account,
        "token": token,
        "oldPassword": encryptOldPW,
        "newPassword": encryptNewPW,
        "confirmPassword": encryptConfirmPW,
      },
      success: (CommonBean bean) {
        SharedUtil.instance.saveString(Keys.password, encryptNewPW);
        _model.loadingController.setFlag(LoadingFlag.success);
      },
      failed: (CommonBean bean) {
        _model.loadingController.setFlag(LoadingFlag.error);
      },
      error: (msg) {
        _model.loadingController.setFlag(LoadingFlag.error);
      },
      token: _model.cancelToken,
    );
  }

  _onForgetPasswordRequest() {
    final account = _model.emailAccount;
    final identifyCode = _model.verifyCode;
    final newPassword = _model.newPassword;
    final confirmPassword = _model.rePassword;
    final encryptNewPW = EncryptUtil.instance.encrypt(newPassword);
    final encryptConfirmPW = EncryptUtil.instance.encrypt(confirmPassword);

    ApiService.instance.postForgetPassword(
      params: {
        "account": account,
        "accountType": "0",
        "newPassword": encryptNewPW,
        "confirmPassword": encryptConfirmPW,
        "identifyCode": identifyCode,
      },
      success: (CommonBean bean) {
        _model.loadingController.setFlag(LoadingFlag.success);
      },
      failed: (CommonBean bean) {
        _model.loadingController.setFlag(LoadingFlag.error);
      },
      error: (msg) {
        _model.loadingController.setFlag(LoadingFlag.error);
      },
      token: _model.cancelToken,
    );
  }
}
