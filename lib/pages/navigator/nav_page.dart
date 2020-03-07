import 'dart:math';
import 'package:todo_list/config/custom_image_cache_manager.dart';
import 'package:todo_list/widgets/custom_cache_image.dart';

import '../main/background/image_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/config/all_types.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/pages/navigator/language_page.dart';
import 'package:todo_list/pages/navigator/settings/setting_page.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/widgets/nav_head.dart';
import 'package:todo_list/widgets/weather_widget.dart';

class NavPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);

    return ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[
        getNavHeader(globalModel, context),
        globalModel.enableWeatherShow
            ? WeatherWidget(
                globalModel: globalModel,
              )
            : SizedBox(),
        ListTile(
          title: Text(IntlLocalizations.of(context).myAccount),
          leading: Icon(Icons.account_circle),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () async {
            final account = await SharedUtil.instance.getString(Keys.account);
            if (account == "default" || account == null) {
              Navigator.push(context, CupertinoPageRoute(builder: (ctx) {
                return ProviderConfig.getInstance().getLoginPage();
              }));
            } else {
              Navigator.push(context, CupertinoPageRoute(builder: (ctx) {
                return ProviderConfig.getInstance().getAccountPage();
              }));
            }
          },
        ),
        ListTile(
          title: Text(IntlLocalizations.of(context).doneList),
          leading: Icon(Icons.done_all),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(context, CupertinoPageRoute(builder: (ctx) {
              return ProviderConfig.getInstance().getDoneTaskPage();
            }));
          },
        ),
        ListTile(
          title: Text(IntlLocalizations.of(context).languageTitle),
          leading: Icon(Icons.language),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(context, CupertinoPageRoute(builder: (ctx) {
              return LanguagePage();
            }));
          },
        ),
        ListTile(
          title: Text(IntlLocalizations.of(context).changeTheme),
          leading: Icon(Icons.color_lens),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(context, CupertinoPageRoute(builder: (ctx) {
              return ProviderConfig.getInstance().getThemePage();
            }));
          },
        ),
        ListTile(
          title: Text(IntlLocalizations.of(context).feedbackWall),
          leading: Icon(Icons.subtitles),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(context, CupertinoPageRoute(builder: (ctx) {
              return ProviderConfig.getInstance().getFeedbackWallPage();
            }));
          },
        ),
        ListTile(
          title: Text(IntlLocalizations.of(context).appSetting),
          leading: Icon(Icons.settings),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(context, CupertinoPageRoute(builder: (ctx) {
              return SettingPage();
            }));
          },
        ),
      ],
    );
  }

  Widget getNavHeader(GlobalModel model, context) {
    final size = MediaQuery.of(context).size;
    final netImageHeight = max(size.width, size.height) / 4;
    if (model.currentNavHeader == NavHeadType.meteorShower) {
      return NavHead();
    } else {
      final url = model.currentNetPicUrl;
      bool isDailyPic = model.currentNavHeader == NavHeadType.dailyPic;
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(CupertinoPageRoute(builder: (ctx) {
            return ImagePage(
              imageUrls: [isDailyPic ? NavHeadType.DAILY_PIC_URL : url],
            );
          }));
        },
        child: Hero(
            tag: "tag_0",
            child: Container(
              height: netImageHeight,
              child: CustomCacheImage(url: isDailyPic ? NavHeadType.DAILY_PIC_URL : url,cacheManager: isDailyPic ? CustomCacheManager():null,)
            )),
      );
    }
  }
}
