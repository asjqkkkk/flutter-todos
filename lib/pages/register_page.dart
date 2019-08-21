import 'package:flutter/material.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/register_page_model.dart';
import 'package:todo_list/widgets/verify_code_widget.dart';

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
        child: Theme(
          data: ThemeData(
              platform: TargetPlatform.android, primaryColor: primaryColor),
          child: Form(
            autovalidate: true,
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
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.person_outline),
                      hintText: DemoLocalizations.of(context).setUserName,
                      labelText: DemoLocalizations.of(context).userName,
                    ),
                  ),
                  SizedBox(height: 24.0),
                  TextFormField(
                    validator: (text) => model.logic.validatorEmail(text),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.email),
                      hintText: DemoLocalizations.of(context).setEmailAccount,
                      labelText: DemoLocalizations.of(context).emailAccount,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    // TextInputFormatters are applied in sequen
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: TextFormField(
                          validator: (verifyCode) =>
                              model.logic.validatorVerifyCode(verifyCode),
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            filled: true,
                            icon: Icon(Icons.message),
                            hintText:
                                DemoLocalizations.of(context).inputVerifyCode,
                            labelText: DemoLocalizations.of(context).verifyCode,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: VerifyCodeWidget(
                          account: model.email,
                          isEmailOk: model.isEmailOk,
                          isUserNameOk: model.isUserNameOk,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 24.0),
                  TextFormField(
                    maxLength: 20,
                    validator: (password) =>
                        model.logic.validatePassword(password),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.lock_outline),
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
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.lock),
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
