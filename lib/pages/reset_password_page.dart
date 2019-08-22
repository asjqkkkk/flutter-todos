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
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(model.isReset
            ? DemoLocalizations.of(context).resetPassword
            : DemoLocalizations.of(context).forgetPassword),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: model.logic.onSubmit,
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Form(
          autovalidate: true,
          child: Theme(
            data: ThemeData(
                platform: TargetPlatform.android, primaryColor: primaryColor),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  model.isReset ? Container() : SizedBox(height: 24.0),
                  model.isReset
                      ? Container()
                      : TextFormField(
                          validator: (text) => model.logic.validatorEmail(text),
                          decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(Icons.email),
                            fillColor: Colors.transparent,
                            hintText: DemoLocalizations.of(context).inputEmail,
                            labelText:
                                DemoLocalizations.of(context).emailAccount,
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                  model.isReset ? Container() : const SizedBox(height: 24.0),
                  model.isReset
                      ? Container()
                      : TextFormField(
                          validator: (verifyCode) =>
                              model.logic.validatorVerifyCode(verifyCode),
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.transparent,
                              prefixIcon: Icon(Icons.message),
                              hintText:
                                  DemoLocalizations.of(context).inputVerifyCode,
                              labelText:
                                  DemoLocalizations.of(context).verifyCode,
                              suffixIcon: VerifyCodeWidget(
                                account: model.emailAccount,
                                isEmailOk: model.isEmailOk,
                              )),
                        ),
                  model.isReset ? const SizedBox(height: 24.0) : Container(),
                  model.isReset
                      ? TextFormField(
                          maxLength: 20,
                          validator: (password) =>
                              model.logic.validateOldPassword(password),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            prefixIcon: Icon(Icons.lock_open),
                            hintText:
                                DemoLocalizations.of(context).inputOldPassword,
                            labelText:
                                DemoLocalizations.of(context).oldPassword,
                          ),
                          obscureText: true,
                        )
                      : Container(),
                  SizedBox(height: 24.0),
                  TextFormField(
                    maxLength: 20,
                    validator: (password) =>
                        model.logic.validateNewPassword(password),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      prefixIcon: Icon(Icons.lock_outline),
                      hintText: DemoLocalizations.of(context).setNewPassword,
                      labelText: DemoLocalizations.of(context).newPassword,
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    maxLength: 20,
                    validator: (rePassword) =>
                        model.logic.validateRePassword(rePassword),
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.lock),
                      fillColor: Colors.transparent,
                      hintText: DemoLocalizations.of(context).reSetPassword,
                      labelText: DemoLocalizations.of(context).confirmPassword,
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
