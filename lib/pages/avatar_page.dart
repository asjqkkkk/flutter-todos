
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/avatar_page_model.dart';
import 'package:todo_list/model/main_page_model.dart';

class AvatarPage extends StatelessWidget {
  final MainPageModel mainPageModel;

  const AvatarPage({Key key, this.mainPageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final model = Provider.of<AvatarPageModel>(context);
    model.setMainPageModel(mainPageModel);
    model.setContext(context);


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("头像"),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (value) => model.logic.onAvatarSelect(value, context),
            itemBuilder: (ctx) {
              return [
                PopupMenuItem(
                  value: AvatarType.local,
                  child: Container(
                    child: Text(DemoLocalizations.of(context).avatarLocal),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                PopupMenuItem(
                  value: AvatarType.net,
                  child: Container(
                    child: Text(DemoLocalizations.of(context).avatarNet),
                    alignment: Alignment.centerLeft,
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Hero(
        tag: "avatar",
        child: Container(
          alignment: Alignment.center,
          child: model.currentAvatarWidget ?? CircularProgressIndicator(
            valueColor:
            AlwaysStoppedAnimation(Colors.white),
          ),
        ),
      ),
    );
  }


}
