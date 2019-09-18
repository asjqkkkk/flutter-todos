import 'package:flutter/material.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/register_page_model.dart';
import 'package:todo_list/widgets/verify_code_widget.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RegisterPageModel>(context)..setContext(context);
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(DemoLocalizations.of(context).signUp),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.check), onPressed: model.logic.onSubmit,)
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20),
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
                  const SizedBox(height: 24.0),
                  TextFormField(
                    validator: (text) => model.logic.validatorUserName(text),
                    maxLength: 20,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      prefixIcon: Icon(Icons.person_outline),
                      hintText: DemoLocalizations.of(context).setUserName,
                      labelText: DemoLocalizations.of(context).userName,
                    ),
                  ),
                  SizedBox(height: 24.0),
                  TextFormField(
                    validator: (text) => model.logic.validatorEmail(text),
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.email),
                      fillColor: Colors.transparent,
                      hintText: DemoLocalizations.of(context).setEmailAccount,
                      labelText: DemoLocalizations.of(context).emailAccount,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 48.0),
                  TextFormField(
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
                      labelText: DemoLocalizations.of(context).verifyCode,
                      suffixIcon: VerifyCodeWidget(
                        account: model.email,
                        isEmailOk: model.isEmailOk,
                        isUserNameOk: model.isUserNameOk,
                      )
                    ),

                  ),
                  SizedBox(height: 24.0),
                  TextFormField(
                    maxLength: 20,
                    validator: (password) =>
                        model.logic.validatePassword(password),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      prefixIcon: Icon(Icons.lock_outline),
                      hintText: DemoLocalizations.of(context).setPassword,
                      labelText: DemoLocalizations.of(context).thePassword,
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
