import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/color_bean.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/model/login_page_model.dart';
import 'dart:ui';
import 'dart:io';
import 'package:todo_list/utils/theme_util.dart';
import 'package:todo_list/widgets/login_widget.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<LoginPageModel>(context)..setContext(context);
    final globalModel = Provider.of<GlobalModel>(context);
    final bgColor = globalModel.logic.getBgInDark();

    bool isDartNow =
        globalModel.currentThemeBean.themeType == MyTheme.darkTheme;
    final iconColor = isDartNow
        ? ColorBean.fromBean(globalModel.currentThemeBean.colorBean)
        : Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(
          DemoLocalizations.of(context).login,
          style: TextStyle(color: iconColor),
        ),
        elevation: 0.0,
        leading: model.isFirst
            ? Container()
            : IconButton(
                icon: Icon(Platform.isAndroid
                    ? Icons.arrow_back
                    : Icons.arrow_back_ios, color: iconColor,),
                onPressed: model.logic.onExit,
              ),
      ),
      body: Stack(
        children: <Widget>[
          FlareActor(
            "flrs/login_bg.flr",
            animation: model.currentAnimation,
            fit: BoxFit.cover,
            callback: (animation) {
              if (animation == "move") {
                model.currentAnimation = "rotate";
                model.refresh();
              } else if (animation == "move_out") {
                Navigator.of(context).pop();
              }
            },
          ),
          model.showLoginWidget
              ? LoginWidget(
                  loginPageModel: model,
                )
              : Container(),
        ],
      ),
    );
  }
}
