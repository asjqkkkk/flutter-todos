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
    final textColor = globalModel.logic.getWhiteInDark();

    bool isDartNow =
        globalModel.currentThemeBean.themeType == MyTheme.darkTheme;
    final iconColor = isDartNow
        ? ColorBean.fromBean(globalModel.currentThemeBean.colorBean)
        : Theme.of(context).primaryColor;
    final bgColor = globalModel.logic.getBgInDark();
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async{
        model.logic.onExit();
        return null;
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: bgColor,
          iconTheme: IconThemeData(color: iconColor),
          title: Text(
            DemoLocalizations.of(context).login,
            style: TextStyle(color: iconColor),
          ),
          elevation: 0.0,
          leading: IconButton(
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
                  model.canShowBackdrop = true;
                  model.currentAnimation = "rotate";
                  model.refresh();
                } else if (animation == "move_out") {
                  Navigator.of(context).pop();
                }
              },
            ),
//          model.canShowBackdrop
//              ? BackdropFilter(
//                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
//                  child: Container(
//                    width: size.width,
//                    height: size.height,
//                    color: bgColor.withOpacity(0.1),
//                  ))
//              : Container(),
            model.canShowBackdrop ? LoginWidget(loginPageModel: model,) : Container(),
          ],
        ),
      ),
    );
  }
}
