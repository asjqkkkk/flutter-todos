import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/reset_password_page_model.dart';
import 'package:todo_list/widgets/verify_code_widget.dart';

class ResetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ResetPasswordPageModel>(context)
      ..setContext(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(model.isReset
            ? IntlLocalizations.of(context).resetPassword
            : IntlLocalizations.of(context).forgetPassword),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: model.logic.onSubmit,
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              model.isReset ? Container() : SizedBox(height: 24.0),
              model.isReset
                  ? Container()
                  : Form(
                      key: model.emailKey,
                      child: TextFormField(
                        focusNode: model.emailFocusNode
                          ..addListener(() {
                            if (!model.emailFocusNode.hasFocus) {
                              model.emailKey.currentState.validate();
                            }
                          }),
                        validator: (text) => model.logic.validatorEmail(text),
                        decoration: InputDecoration(
                          filled: true,
                          prefixIcon: Icon(Icons.email),
                          fillColor: Colors.transparent,
                          hintText: IntlLocalizations.of(context).inputEmail,
                          labelText: IntlLocalizations.of(context).emailAccount,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(textBaseline: TextBaseline.alphabetic),
                      ),
                    ),
              model.isReset ? Container() : const SizedBox(height: 24.0),
              model.isReset
                  ? Container()
                  : Form(
                key: model.verifyCodeKey,
                      child: TextFormField(
                        focusNode: model.verifyCodeFocusNode..addListener((){
                          if(!model.verifyCodeFocusNode.hasFocus){
                            model.verifyCodeKey.currentState.validate();
                          }
                        }),
                        validator: (verifyCode) =>
                            model.logic.validatorVerifyCode(verifyCode),
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        style: TextStyle(textBaseline: TextBaseline.alphabetic),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            prefixIcon: Icon(Icons.message),
                            hintText:
                                IntlLocalizations.of(context).inputVerifyCode,
                            labelText: IntlLocalizations.of(context).verifyCode,
                            suffixIcon: VerifyCodeWidget(
                              account: model.emailAccount,
                              isEmailOk: model.isEmailOk,
                              isForgetPassword: true,
                            )),
                      ),
                    ),
              model.isReset ? const SizedBox(height: 24.0) : Container(),
              model.isReset
                  ? Form(
                key: model.oldPasswordKey,
                    child: TextFormField(
                      focusNode: model.oldPasswordFocusNode..addListener((){
                        if(!model.oldPasswordFocusNode.hasFocus){
                          model.oldPasswordKey.currentState.validate();
                        }
                      }),
                        style: TextStyle(textBaseline: TextBaseline.alphabetic),
                        maxLength: 20,
                        validator: (password) =>
                            model.logic.validateOldPassword(password),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          prefixIcon: Icon(Icons.lock_open),
                          hintText:
                              IntlLocalizations.of(context).inputOldPassword,
                          labelText: IntlLocalizations.of(context).oldPassword,
                        ),
                        obscureText: true,
                      ),
                  )
                  : Container(),
              SizedBox(height: 24.0),
              Form(
                key: model.passwordKey,
                child: TextFormField(
                  focusNode: model.passwordFocusNode..addListener((){
                    if(!model.passwordFocusNode.hasFocus){
                      model.passwordKey.currentState.validate();
                    }
                  }),
                  maxLength: 20,
                  validator: (password) =>
                      model.logic.validateNewPassword(password),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    prefixIcon: Icon(Icons.lock_outline),
                    hintText: IntlLocalizations.of(context).setNewPassword,
                    labelText: IntlLocalizations.of(context).newPassword,
                  ),
                  obscureText: true,
                  style: TextStyle(textBaseline: TextBaseline.alphabetic),
                ),
              ),
              const SizedBox(height: 24.0),
              Form(
                key: model.rePasswordKey,
                child: TextFormField(
                  focusNode: model.rePasswordFocusNode..addListener((){
                    if(!model.rePasswordFocusNode.hasFocus){
                      model.rePasswordKey.currentState.validate();
                    }
                  }),
                  maxLength: 20,
                  validator: (rePassword) =>
                      model.logic.validateRePassword(rePassword),
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.lock),
                    fillColor: Colors.transparent,
                    hintText: IntlLocalizations.of(context).reSetPassword,
                    labelText: IntlLocalizations.of(context).confirmPassword,
                  ),
                  obscureText: true,
                  style: TextStyle(textBaseline: TextBaseline.alphabetic),
                ),
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}
