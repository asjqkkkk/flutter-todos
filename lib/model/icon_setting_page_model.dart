import 'package:flutter/material.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/task_icon_bean.dart';
import 'package:todo_list/logic/all_logic.dart';
import 'package:todo_list/utils/icon_list_util.dart';
import 'package:todo_list/utils/theme_util.dart';

class IconSettingPageModel extends ChangeNotifier {
  IconSettingPageLogic logic;
  BuildContext context;

  List<TaskIconBean> taskIcons = [];

  IconSettingPageModel() {
    logic = IconSettingPageLogic(this);
  }

  void setContext(BuildContext context) {
    if (this.context == null) {
      this.context = context;
      taskIcons.clear();
      taskIcons.addAll(IconListUtil.getInstance().getTaskIcons(context));
    }
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("IconSettingPageModel销毁了");
  }

  void refresh() {
    notifyListeners();
  }
}
