import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/pages/language_page.dart';
import 'package:todo_list/pages/setting_page.dart';
import 'package:todo_list/utils/permission_request_util.dart';
import 'package:todo_list/widgets/nav_head.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:geolocator/geolocator.dart';

import 'image_page.dart';
import 'navigator_setting_page.dart';

class NavPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);

    return ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[
        getNavHeader(globalModel, context),
        ListTile(
          title: Text(DemoLocalizations.of(context).doneList),
          leading: Icon(Icons.done_all),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(context, new CupertinoPageRoute(builder: (ctx) {
              return ProviderConfig.getInstance().getDoneTaskPage();
            }));
          },
        ),
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
          title: Text(DemoLocalizations.of(context).feedback),
          leading: Icon(Icons.comment),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(context, new CupertinoPageRoute(builder: (ctx) {
              return ProviderConfig.getInstance().getFeedbackPage();
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
        ListTile(
          title: Text("地理位置"),
          leading: Icon(Icons.location_on),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () async {
            PermissionReqUtil.getInstance().requestPermission(
                PermissionGroup.locationWhenInUse,
                context: context,
                granted: () async{
                  Position position = await Geolocator()
                      .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
                  print("position:${position.toString()}");
                },);
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
          Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx) {
            return ImagePage(
              imageUrls: [isDailyPic ? NavHeadType.dailyPicUrl : url],
            );
          }));
        },
        child: Hero(
            tag: "tag_0",
            child: Container(
              height: netImageHeight,
              child: isDailyPic
                  ? Image.network(
                      NavHeadType.dailyPicUrl,
                      fit: BoxFit.cover,
                    )
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
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
            )),
      );
    }
    ;
  }
}
