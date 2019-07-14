import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/pages/about_page.dart';
import 'package:todo_list/pages/edit_icon_page.dart';
import 'package:todo_list/pages/icon_setting_page.dart';
import 'package:todo_list/utils/shared_util.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(DemoLocalizations.of(context).appSetting),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(DemoLocalizations.of(context).backgroundGradient),
            leading: Icon(
              Icons.invert_colors,
            ),
            trailing: Switch(
                value: globalModel.isBgGradient,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (value) {
                  globalModel.isBgGradient = value;
                  SharedUtil.instance.saveBoolean(
                      Keys.backgroundGradient, globalModel.isBgGradient);
                  globalModel.refresh();
                }),
          ),
          ListTile(
            title: Text(DemoLocalizations.of(context).bgChangeWithCard),
            leading: Icon(
              Icons.format_color_fill,
            ),
            trailing: Switch(
                value: globalModel.isBgChangeWithCard,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (value){
                  globalModel.isBgChangeWithCard = value;
                  if(globalModel.isCardChangeWithBg && value){
                    globalModel.isCardChangeWithBg = false;
                    SharedUtil.instance.saveBoolean(Keys.cardChangeWithBackground, false);
                  }
                  SharedUtil.instance.saveBoolean(Keys.backgroundChangeWithCard, globalModel.isBgChangeWithCard);
                  globalModel.refresh();
                }),
          ),
          ListTile(
            title: Text(DemoLocalizations.of(context).cardChangeWithBg),
            leading: Transform(
              transform: Matrix4.rotationY(pi),
              origin: Offset(12, 0.0),
              child: Icon(
                Icons.format_color_fill,
              ),
            ),
            trailing: Switch(
                value: globalModel.isCardChangeWithBg,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (value) {
                  globalModel.isCardChangeWithBg = value;
                  if(globalModel.isBgChangeWithCard && value){
                    globalModel.isBgChangeWithCard = false;
                    SharedUtil.instance.saveBoolean(Keys.backgroundChangeWithCard, false);
                  }
                  SharedUtil.instance.saveBoolean(Keys.cardChangeWithBackground, globalModel.isCardChangeWithBg);
                  globalModel.refresh();
                }),
          ),
          ListTile(
            title: Text(DemoLocalizations.of(context).enableInfiniteScroll),
            leading: Icon(
              Icons.repeat,
            ),
            trailing: Switch(
                value: globalModel.enableInfiniteScroll,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (value) {
                  globalModel.enableInfiniteScroll = value;
                  SharedUtil.instance.saveBoolean(
                      Keys.enableInfiniteScroll, globalModel.enableInfiniteScroll);
                  globalModel.refresh();
                }),
          ),
          ListTile(
            title: Text(DemoLocalizations.of(context).iconSetting),
            leading: Icon(
              Icons.insert_emoticon,
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx) {
                return ProviderConfig.getInstance().getIconSettingPage();
              }));
            },
          ),
          ListTile(
            title: Text(DemoLocalizations.of(context).aboutApp),
            leading: Icon(
              Icons.info,
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx) {
                return EditIconPage();
              }));
            },
          ),
        ],
      ),
    );
  }
}
