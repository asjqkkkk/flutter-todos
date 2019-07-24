import 'package:flutter/material.dart';
import 'package:todo_list/database/database.dart';
import 'package:todo_list/logic/all_logic.dart';
import 'package:todo_list/json/task_bean.dart';

class MainPageModel extends ChangeNotifier {
  MainPageLogic logic;
  BuildContext context;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<TaskBean> tasks = [];

  //当前滑动的卡片位置
  int currentCardIndex = 0;

  //当前点击进入详情页的index，方便在详情页里面操作删除、更新等
  int currentTapIndex = 0;

  //当前头像的类型
  int currentAvatarType = CurrentAvatarType.defaultAvatar;

  //当前的头像url,比如本地的就是本地路径，网络就是网络地址
  String currentAvatarUrl = "images/icon.png";

  //是否开启天气
  bool enableWeatherShow = false;

  //当前位置信息(经纬度)
  String currentPosition = "";

  MainPageModel() {
    logic = MainPageLogic(this);
  }

  void setContext(BuildContext context) {
    if (this.context == null) {
      this.context = context;
      logic.getAvatarType().then((value) {
        Future.wait(
          [
            logic.getTasks(),
            logic.getCurrentAvatar(),
          ],
        ).then((value) {
          refresh();
        });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    scaffoldKey?.currentState?.dispose();
    debugPrint("MainPageModel销毁了");
  }

  void refresh() {
    notifyListeners();
  }
}

class CurrentAvatarType {
  static const int defaultAvatar = 0;
  static const int local = 1;
  static const int net = 2;
}
