import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/config/custom_image_cache_manager.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/pages/photo_page.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/widgets/nav_head.dart';

class NavSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(DemoLocalizations.of(context).navigatorSetting),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            RadioListTile(
              value: NavHeadType.meteorShower,
              groupValue: globalModel.currentNavHeader,
              subtitle: NavHead(),
              onChanged: (value) => onChanged(globalModel, value),
              title: Text(DemoLocalizations.of(context).meteorShower),
            ),
            RadioListTile(
              value: NavHeadType.dailyPic,
              groupValue: globalModel.currentNavHeader,
              subtitle: FadeInImage(
                image: NetworkImage(NavHeadType.DAILY_PIC_URL),
                fit: BoxFit.cover,
                placeholder: CachedNetworkImageProvider(
                    NavHeadType.DAILY_PIC_URL,
                    cacheManager: CustomCacheManager()),
              ),
              onChanged: (value) => onChanged(globalModel, value),
              title: Text(DemoLocalizations.of(context).dailyPic),
            ),
            RadioListTile(
                value: NavHeadType.netPicture,
                groupValue: globalModel.currentNavHeader,
                onChanged: (value) =>
                    onChanged(globalModel, value, context: context),
                title: Text(DemoLocalizations.of(context).netPicture),
                subtitle: globalModel.currentNetPicUrl == ""
                    ? null
                    : GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(new CupertinoPageRoute(builder: (ctx) {
                            return PhotoPage(
                              selectValue: NavHeadType.netPicture,
                            );
                          }));
                        },
                        child: CachedNetworkImage(
                          imageUrl: globalModel.currentNetPicUrl,
                          placeholder: (context, url) => new Container(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor),
                                ),
                              ),
                          errorWidget: (context, url, error) => new Icon(
                                Icons.error,
                                color: Colors.redAccent,
                              ),
                        ),
                      )),
          ],
        ),
      ),
    );
  }

  Future onChanged(GlobalModel globalModel, value,
      {BuildContext context}) async {
    if (context != null && globalModel.currentNetPicUrl == "") {
      Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx) {
        return PhotoPage(
          selectValue: value,
        );
      }));
      return;
    }

    if (globalModel.currentNavHeader != value) {
      globalModel.currentNavHeader = value;
      globalModel.refresh();
      await SharedUtil.instance.saveString(Keys.currentNavHeader, value);
    }
  }
}

class NavHeadType {
  static const String meteorShower = "MeteorShower";
  static const String dailyPic = "DailyPic";
  static const String netPicture = "NetPicture";

  static const String DAILY_PIC_URL = "https://api.dujin.org/bing/1366.php";
}
