import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/pages/about_page.dart';
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
            title: Text(DemoLocalizations.of(context).iconSetting),
            leading: Icon(
              Icons.insert_emoticon,
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
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
              Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
                return AboutPage();
              }));
            },
          ),
        ],
      ),
    );
  }
}
