import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/weather_bean.dart';
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
        globalModel.enableWeatherShow
            ? getWeatherNow(globalModel, context)
            : SizedBox(),
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

  Widget getWeatherNow(GlobalModel globalModel, BuildContext context) {
    final color = globalModel.logic.isDarkNow() ? Colors.white : Colors.grey;
    final weatherBean = globalModel.weatherBean;
    if (weatherBean == null) {
      return FlatButton(
        child: Text(DemoLocalizations.of(context).weatherGetWrong),
        onPressed: () => globalModel.logic.getWeatherNow(globalModel.currentPosition ?? ""),
      );
    }
    final BasicBean basicBean =
        weatherBean.HeWeather6[weatherBean.HeWeather6.length - 1].basic;
    final NowBean nowBean =
        weatherBean.HeWeather6[weatherBean.HeWeather6.length - 1].now;
    return Container(
      margin: EdgeInsets.only(left: 5, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Image.asset(
              "images/weather/${nowBean.cond_code}.png",
              color: color,
              width: 60,
              height: 60,
            ),
          ),
          Container(
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    "${basicBean.location}",
                    style: TextStyle(
                      fontSize: 16,
                      color: color,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Text(
                  "${nowBean.tmp} ℃   ${nowBean.cond_txt}",
                  style: TextStyle(
                    fontSize: 16,
                    color: color,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
