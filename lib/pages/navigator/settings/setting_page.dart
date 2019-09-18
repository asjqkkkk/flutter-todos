import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/config/all_types.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/widgets/edit_dialog.dart';
import 'package:todo_list/widgets/net_loading_widget.dart';

import '../../all_page.dart';
import 'navigator_setting_page.dart';

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
          SwitchListTile(
            title: Text(DemoLocalizations.of(context).backgroundGradient),
            secondary: const Icon(
              Icons.invert_colors,
            ),
            value: globalModel.isBgGradient,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (value) {
              globalModel.isBgGradient = value;
              SharedUtil.instance.saveBoolean(
                  Keys.backgroundGradient, globalModel.isBgGradient);
              globalModel.refresh();
            },
          ),
          SwitchListTile(
            title: Text(DemoLocalizations.of(context).bgChangeWithCard),
            secondary: const Icon(
              Icons.format_color_fill,
            ),
            value: globalModel.isBgChangeWithCard,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (value) {
              globalModel.isBgChangeWithCard = value;
              if (globalModel.isCardChangeWithBg && value) {
                globalModel.isCardChangeWithBg = false;
                SharedUtil.instance
                    .saveBoolean(Keys.cardChangeWithBackground, false);
              }
              SharedUtil.instance.saveBoolean(Keys.backgroundChangeWithCard,
                  globalModel.isBgChangeWithCard);
              globalModel.refresh();
            },
          ),
          SwitchListTile(
            title: Text(DemoLocalizations.of(context).cardChangeWithBg),
            secondary: Transform(
              transform: Matrix4.rotationY(pi),
              origin: Offset(12, 0.0),
              child: const Icon(
                Icons.format_color_fill,
              ),
            ),
            value: globalModel.isCardChangeWithBg,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (value) {
              globalModel.isCardChangeWithBg = value;
              if (globalModel.isBgChangeWithCard && value) {
                globalModel.isBgChangeWithCard = false;
                SharedUtil.instance
                    .saveBoolean(Keys.backgroundChangeWithCard, false);
              }
              SharedUtil.instance.saveBoolean(Keys.cardChangeWithBackground,
                  globalModel.isCardChangeWithBg);
              globalModel.refresh();
            },
          ),
          SwitchListTile(
            title: Text(DemoLocalizations.of(context).enableWeatherShow),
            secondary: const Icon(
              Icons.wb_sunny,
            ),
            value: globalModel.enableWeatherShow,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (value) => onWeatherOpen(value, context, globalModel),
          ),
          SwitchListTile(
            title: Text(DemoLocalizations.of(context).enableNetPicBgInMainPage),
            secondary: const Icon(
              Icons.image,
            ),
            value: globalModel.enableNetPicBgInMainPage,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (value) => onNetPicBgSelect(value, context, globalModel),
          ),
          SwitchListTile(
            title: Text(DemoLocalizations.of(context).enableInfiniteScroll),
            secondary: const Icon(
              Icons.repeat,
            ),
            value: globalModel.enableInfiniteScroll,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (value) {
              globalModel.enableInfiniteScroll = value;
              SharedUtil.instance.saveBoolean(
                  Keys.enableInfiniteScroll, globalModel.enableInfiniteScroll);
              globalModel.refresh();
            },
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
            title: Text(DemoLocalizations.of(context).navigatorSetting),
            leading: Icon(
              Icons.navigation,
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx) {
                return NavSettingPage();
              }));
            },
          ),
          ListTile(
            title: Text(DemoLocalizations.of(context).aboutApp),
            leading: Icon(
              Icons.info_outline,
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx) {
                return AboutPage();
              }));
            },
          ),
        ],
      ),
    );
  }

  void onWeatherOpen(bool value, BuildContext context, GlobalModel globalModel) {
    if (value) {
      showDialog(
        context: context,
        builder: (ctx1) {
          return EditDialog(
            positiveWithPop: false,
            title: DemoLocalizations.of(context).enableWeatherShow,
            hintText: DemoLocalizations.of(context).inputCurrentCity,
            initialValue: globalModel.currentPosition,
            onValueChanged: (text){
              globalModel.currentPosition = text;
            },
            sureTextStyle: TextStyle(color: globalModel.logic.getbwInDark()),
            onPositive: (){
              if(globalModel.currentPosition.isEmpty) return;
              CancelToken cancelToken = CancelToken();
              showDialog(context: ctx1, builder: (ctx2){

                return NetLoadingWidget(
                  onRequest: (){
                    globalModel.logic.getWeatherNow(globalModel.currentPosition,controller: globalModel.loadingController);
                  },
                  cancelToken: cancelToken,
                  errorText: DemoLocalizations.of(context).weatherGetWrong,
                  loadingText: DemoLocalizations.of(context).weatherGetting,
                  successText: DemoLocalizations.of(context).weatherSuccess,
                  onSuccess: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  loadingController: globalModel.loadingController,
                );
              });
            },
          );
        },);
    } else {
      globalModel.enableWeatherShow = false;
      SharedUtil.instance.saveBoolean(Keys.enableWeatherShow, false);
      globalModel.refresh();
    }
  }

  void onNetPicBgSelect(bool value, BuildContext context, GlobalModel globalModel){
    if(value){
      Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx) {
        return ProviderConfig.getInstance().getNetPicturesPage(
          useType: NetPicturesUseType.mainPageBackground,
        );
      }));
    } else {
      globalModel.enableNetPicBgInMainPage = false;
      SharedUtil.instance.saveBoolean(Keys.enableNetPicBgInMainPage, false);
      globalModel.refresh();
    }
  }

}
