import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/model/global_model.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final model = Provider.of<GlobalModel>(context);

    return Scaffold(
      body: Container(
        child: FlareActor(
          model.currentLanguage == "中文" ? "flrs/todo_splash_zh.flr" :"flrs/todo_splash_en.flr",
          animation: "run",
          fit: BoxFit.cover,
          callback: (animation) {
            Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(builder: (context) {
                    return getHomePage(model.goToLogin);
                }), (router) => router == null);
          },
        ),
      ),
    );
  }

  Widget getHomePage(bool goToLogin){
    return goToLogin ? ProviderConfig.getInstance().getLoginPage(isFirst: true)
        : ProviderConfig.getInstance().getMainPage();
  }
}
