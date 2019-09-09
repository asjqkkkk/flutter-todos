import 'package:flutter/material.dart';
import 'package:todo_list/json/task_icon_bean.dart';
import 'package:todo_list/logic/all_logic.dart';

class IconSettingPageModel extends ChangeNotifier {
  IconSettingPageLogic logic;
  BuildContext context;

  ///当前已经选择出来的icon图标
  List<TaskIconBean> taskIcons = [];

  ///展示在分割线下部分的所有icon图标
  List<IconBean> showIcons = [];

  ///搜索出来的所有icon图标
  List<IconBean> searchIcons = [];
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();


  Color currentPickerColor = Colors.black;
  String currentIconName = "";
  bool isDeleting = false;
  bool isSearching = false;

  IconSettingPageModel() {
    logic = IconSettingPageLogic(this);
  }

  void setContext(BuildContext context) {
    if (this.context == null) {
      this.context = context;
      Future.wait([
        logic.getTaskIconList(),
        logic.getIconList(),
      ]).then((value) {
        refresh();
      });
    }
  }

  @override
  void dispose() {
    textEditingController?.dispose();
    focusNode?.dispose();
    super.dispose();
    debugPrint("IconSettingPageModel销毁了");
  }

  void refresh() {
    notifyListeners();
  }
}
