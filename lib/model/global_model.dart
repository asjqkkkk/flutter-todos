import 'package:flutter/material.dart';
import 'package:todo_list/json/theme_bean.dart';
import 'package:todo_list/json/weather_bean.dart';
import 'package:todo_list/logic/all_logic.dart';
import 'package:todo_list/model/main_page_model.dart';
import 'package:todo_list/utils/theme_util.dart';

class GlobalModel extends ChangeNotifier {
  GlobalLogic logic;
  BuildContext context;
  MainPageModel mainPageModel;

  //app的名字
  String appName = "一日";

  //当前的主题颜色数据
  ThemeBean currentThemeBean = ThemeBean(
    themeName: "pink",
    colorBean: ColorBean.fromColor(MyThemeColor.defaultColor),
    themeType: MyTheme.defaultTheme,
  );

  //是否开启主页背景渐变
  bool isBgGradient = false;

  //是否开启主页背景颜色跟随卡片图标颜色
  bool isBgChangeWithCard = false;

  //是否开启卡片图标颜色跟随主页背景
  bool isCardChangeWithBg = false;

  //是否开启主页卡片无限循环滚动
  bool enableInfiniteScroll = true;

  //是否开启天气
  bool enableWeatherShow = false;
  //当前位置信息(经纬度)
  String currentPosition = "";
  //当前天气的json
  WeatherBean weatherBean;


  //当前语言
  List<String> currentLanguageCode = ["zh", "CN"];
  String currentLanguage = "中文";
  Locale currentLocale;

  //当前导航栏头部背景
  String currentNavHeader = "MeteorShower";
  //导航栏头部选择网络图片时的图片地址
  String currentNetPicUrl = "";

  GlobalModel() {
    logic = GlobalLogic(this);
  }

  void setContext(BuildContext context) {
    if (this.context == null) {
      this.context = context;
      Future.wait([
        logic.getCurrentTheme(),
        logic.getAppName(),
        logic.getCurrentLanguageCode(),
        logic.getCurrentLanguage(),
        logic.getIsBgGradient(),
        logic.getCurrentNavHeader(),
        logic.getCurrentNetPicUrl(),
        logic.getIsBgChangeWithCard(),
        logic.getIsCardChangeWithBg(),
        logic.getEnableInfiniteScroll(),
        logic.getCurrentPosition(),
        logic.getEnableWeatherShow()
      ]).then((value) {
        currentLocale = Locale(currentLanguageCode[0], currentLanguageCode[1]);
        refresh();
      });
    }
  }

  void setMainPageModel(MainPageModel mainPageModel) {
    if (this.mainPageModel == null) {
      this.mainPageModel = mainPageModel;
      if(enableWeatherShow) logic.getWeatherNow(currentPosition);
    }
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("GlobalModel销毁了");
  }

  void refresh() {
    notifyListeners();
  }
}
