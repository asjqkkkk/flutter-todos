import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/config/all_types.dart';
import 'package:todo_list/config/custom_image_cache_manager.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/widgets/custom_cache_image.dart';
import 'package:todo_list/widgets/nav_head.dart';


class NavSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final globalModel = Provider.of<GlobalModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(IntlLocalizations.of(context).navigatorSetting),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            RadioListTile(
              value: NavHeadType.meteorShower,
              groupValue: globalModel.currentNavHeader,
              subtitle: NavHead(),
              onChanged: (value) => onChanged(globalModel, value),
              title: Text(IntlLocalizations.of(context).meteorShower),
            ),
            RadioListTile(
              value: NavHeadType.dailyPic,
              groupValue: globalModel.currentNavHeader,
              subtitle: CustomCacheImage(url: NavHeadType.DAILY_PIC_URL,cacheManager: CustomCacheManager(),),
              onChanged: (value) => onChanged(globalModel, value),
              title: Text(IntlLocalizations.of(context).dailyPic),
            ),
            RadioListTile(
              value: NavHeadType.netPicture,
              groupValue: globalModel.currentNavHeader,
              onChanged: (value) => onChanged(globalModel, value,context: context),
              title: Text(IntlLocalizations.of(context).netPicture),
              subtitle: globalModel.currentNetPicUrl == "" ? null : GestureDetector(
                onTap: (){
                  Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx) {
                    return ProviderConfig.getInstance().getNetPicturesPage(useType: NetPicturesUseType.navigatorHeader);
                  }));
                },
              child: CustomCacheImage(url: globalModel.currentNetPicUrl,),)
            ),
          ],
        ),
      ),
    );
  }

  Future onChanged(GlobalModel globalModel, value, {BuildContext context}) async {

    if(context != null && globalModel.currentNetPicUrl == ""){
      Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx) {
        return ProviderConfig.getInstance().getNetPicturesPage(useType: value);
      }));
      return;
    }

    if(value == NavHeadType.dailyPic){
      final time = await SharedUtil.instance.getString(Keys.everyDayPicRefreshTime);
      if(time == null) SharedUtil.instance.saveString(Keys.everyDayPicRefreshTime, DateTime.now().toIso8601String());
    }

    if(globalModel.currentNavHeader != value){
      globalModel.currentNavHeader = value;
      globalModel.refresh();
      await SharedUtil.instance.saveString(Keys.currentNavHeader, value);
    }
  }
}

