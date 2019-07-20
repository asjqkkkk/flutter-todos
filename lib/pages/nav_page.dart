import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/config/custom_image_cache_manager.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/pages/language_page.dart';
import 'package:todo_list/pages/setting_page.dart';
import 'package:todo_list/pages/theme_page.dart';
import 'package:todo_list/widgets/nav_head.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'image_page.dart';
import 'navigator_setting_page.dart';

class NavPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);

    final size = MediaQuery.of(context).size;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[
        getNavHeader(globalModel, context),
        ListTile(
          title: Text(DemoLocalizations.of(context).languageTitle),
          leading: Icon(Icons.language),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(context, new CupertinoPageRoute(builder: (ctx) {
              return LanguagePage();
            }));
          },
        ),
        ListTile(
          title: Text(DemoLocalizations.of(context).changeTheme),
          leading: Icon(Icons.color_lens),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(context, new CupertinoPageRoute(builder: (ctx) {
              return ProviderConfig.getInstance().getThemePage();
            }));
          },
        ),
        ListTile(
          title: Text(DemoLocalizations.of(context).appSetting),
          leading: Icon(Icons.settings),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(context, new CupertinoPageRoute(builder: (ctx) {
              return SettingPage();
            }));
          },
        ),
      ],
    );
  }

  Widget getNavHeader(GlobalModel model, context) {
    if (model.currentNavHeader == NavHeadType.meteorShower) {
      return NavHead();
    } else {
      final url = model.currentNetPicUrl;
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx) {
            return ImagePage(
              imageUrls: [url],
            );
          }));
        },
        child: Hero(
          tag: "tag_0",
          child: model.currentNavHeader == NavHeadType.dailyPic
              ? Image.network(NavHeadType.dailyPicUrl)
              : CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: url,
                  placeholder: (context, url) => new Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor),
                        ),
                      ),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
        ),
      );
    }
    ;
  }
}
