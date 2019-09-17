import 'package:flutter/material.dart';
import 'package:todo_list/config/all_types.dart';
import 'package:todo_list/json/theme_bean.dart';
import 'package:todo_list/json/weather_bean.dart';
import 'package:todo_list/logic/all_logic.dart';
import 'package:todo_list/model/main_page_model.dart';
import 'package:todo_list/utils/theme_util.dart';
import 'package:todo_list/widgets/net_loading_widget.dart';

class GlobalModel extends ChangeNotifier {
  GlobalLogic logic;
  BuildContext context;
  MainPageModel mainPageModel;

  ///app的名字
  String appName = "一日";

  ///当前的主题颜色数据
  ThemeBean currentThemeBean = ThemeBean(
    themeName: "pink",
    colorBean: ColorBean.fromColor(MyThemeColor.defaultColor),
    themeType: MyTheme.defaultTheme,
  );

  ///是否开启主页背景渐变
  bool isBgGradient = false;

  ///是否开启主页背景颜色跟随卡片图标颜色
  bool isBgChangeWithCard = false;

  ///是否开启卡片图标颜色跟随主页背景
  bool isCardChangeWithBg = false;

  ///是否开启主页卡片无限循环滚动
  bool enableInfiniteScroll = false;

  ///是否开启天气
  bool enableWeatherShow = false;

  ///是否开启主页背景为网络图片
  bool enableNetPicBgInMainPage = false;

  ///当前主页网络背景图片地址
  String currentMainPageBgUrl = "";

  ///当前位置信息(经纬度)
  String currentPosition = "";

  ///当前天气的json
  WeatherBean weatherBean;

  ///设置页面，用于控制天气获取的loading加载框
  LoadingController loadingController = LoadingController();

  ///当前语言
  List<String> currentLanguageCode = ["zh", "CN"];
  String currentLanguage = "中文";
  Locale currentLocale;

  ///当前导航栏头部背景
  String currentNavHeader = NavHeadType.meteorShower;

  ///导航栏头部选择网络图片时的图片地址
  String currentNetPicUrl = "";

  ///是否进入登录页
  bool goToLogin;

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
        logic.getEnableWeatherShow(),
        logic.getLoginState(),
        logic.getCurrentMainPageBgUrl(),
        logic.getEnableNetPicBgInMainPage(),
        logic.getCurrentPosition(),
      ]).then((value) {
        currentLocale = Locale(currentLanguageCode[0], currentLanguageCode[1]);
        refresh();
      });
    }
  }

  void setMainPageModel(MainPageModel mainPageModel) {
    if (this.mainPageModel == null) {
      this.mainPageModel = mainPageModel;
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
