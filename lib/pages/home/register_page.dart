import 'package:flutter/material.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/register_page_model.dart';
import 'package:todo_list/widgets/verify_code_widget.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RegisterPageModel>(context)..setContext(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(IntlLocalizations.of(context).signUp),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.check), onPressed: model.logic.onSubmit,)
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 24.0),
              Form(
                key: model.emailKey,
                child: TextFormField(
                  focusNode: model.emailFocusNode..addListener((){
                    if(!model.emailFocusNode.hasFocus){
                      model.emailKey.currentState.validate();
                    }
                  }),
                  validator: (text) => model.logic.validatorEmail(text),
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.email),
                    fillColor: Colors.transparent,
                    hintText: IntlLocalizations.of(context).setEmailAccount,
                    labelText: IntlLocalizations.of(context).emailAccount,
                  ),
                  style: TextStyle(textBaseline: TextBaseline.alphabetic),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 48.0),
              Form(
                key: model.userNameKey,
                child: TextFormField(
                  focusNode: model.userNameFocusNode..addListener((){
                    if(!model.userNameFocusNode.hasFocus){
                      model.userNameKey.currentState.validate();
                    }
                  }),
                  validator: (text) => model.logic.validatorUserName(text),
                  maxLength: 20,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    prefixIcon: Icon(Icons.person_outline),
                    hintText: IntlLocalizations.of(context).setUserName,
                    labelText: IntlLocalizations.of(context).userName,
                  ),
                  style: TextStyle(
                  textBaseline: TextBaseline.alphabetic),
                ),
              ),
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
                      model.logic.validatePassword(password),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    prefixIcon: Icon(Icons.lock_outline),
                    hintText: IntlLocalizations.of(context).setPassword,
                    labelText: IntlLocalizations.of(context).thePassword,
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
                  style: TextStyle(textBaseline: TextBaseline.alphabetic),
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.lock),
                    fillColor: Colors.transparent,
                    hintText: IntlLocalizations.of(context).reSetPassword,
                    labelText: IntlLocalizations.of(context).confirmPassword,
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 24.0),
              Form(
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
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      prefixIcon: Icon(Icons.message),
                      hintText:
                      IntlLocalizations.of(context).inputVerifyCode,
                      labelText: IntlLocalizations.of(context).verifyCode,
                      suffixIcon: VerifyCodeWidget(
                        account: model.email,
                        isEmailOk: model.isEmailOk,
                        isUserNameOk: model.isUserNameOk,
                      )
                  ),
                  style: TextStyle(textBaseline: TextBaseline.alphabetic),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
