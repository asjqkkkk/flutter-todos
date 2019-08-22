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

    return WillPopScope(
      onWillPop: () async{
        model.logic.onExit();
        return null;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            DemoLocalizations.of(context).login,
          ),
          elevation: 0.0,
            leading: model.isFirst ? Container() : IconButton(
              icon:
                  Icon(Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios),
              onPressed: model.logic.onExit,),
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
            model.showLoginWidget ? LoginWidget(loginPageModel: model,) : Container(),
          ],
        ),
      ),
    );
  }
}
