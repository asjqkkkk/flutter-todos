import 'package:flutter/material.dart';
import 'package:todo_list/json/theme_bean.dart';
import 'package:todo_list/logic/all_logic.dart';
import 'package:todo_list/model/main_page_model.dart';
import 'package:todo_list/utils/theme_util.dart';

class GlobalModel extends ChangeNotifier {
  GlobalLogic logic;
  BuildContext context;

  //app的名字，目前这个还有些问题
  String appName = "一日";

  //当前的主题颜色
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

  MainPageModel mainPageModel;

  List<String> currentLanguage = ["zh", "CN"]; //当前的app语言

  GlobalModel() {
    logic = GlobalLogic(this);
  }

  void setContext(BuildContext context) {
    if (this.context == null) {
      this.context = context;
      Future.wait([
        logic.getCurrentTheme(),
        logic.getCurrentLanguage(),
        logic.getIsBgGradient(),
        logic.getIsBgChangeWithCard(),
        logic.getIsCardChangeWithBg(),
        logic.getEnableInfiniteScroll()
      ]).then((value) {
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
