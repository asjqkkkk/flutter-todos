import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/json/task_icon_bean.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/pages/all_page.dart';

class ProviderConfig {
  static ProviderConfig _instance;

  static ProviderConfig getInstance() {
    if (_instance == null) {
      _instance = ProviderConfig._internal();
    }
    return _instance;
  }

  ProviderConfig._internal();

  ChangeNotifierProvider<GlobalModel> getGlobal(Widget child) {
    return ChangeNotifierProvider<GlobalModel>(
      builder: (context) => GlobalModel(),
      child: child,
    );
  }

  ChangeNotifierProvider<MainPageModel> getMainPage() {
    return ChangeNotifierProvider<MainPageModel>(
      builder: (context) => MainPageModel(),
      child: MainPage(),
    );
  }

  ChangeNotifierProvider<TaskDetailPageModel> getTaskDetailPage(
    int index,
    TaskBean taskBean, {DoneTaskPageModel doneTaskPageModel,
  }) {
    return ChangeNotifierProvider<TaskDetailPageModel>(
      builder: (context) => TaskDetailPageModel(
            taskBean,
        doneTaskPageModel : doneTaskPageModel,
          ),
      child: TaskDetailPage(
        index,
      ),
    );
  }

  ChangeNotifierProvider<EditTaskPageModel> getEditTaskPage(
      TaskIconBean taskIcon,
      {MainPageModel mainPageModel,
      TaskDetailPageModel taskDetailPageModel,
      TaskBean taskBean}) {
    return ChangeNotifierProvider<EditTaskPageModel>(
      builder: (context) => EditTaskPageModel(oldTaskBean: taskBean),
      child: EditTaskPage(
        taskIcon,
        mainPageModel: mainPageModel,
        taskDetailPageModel: taskDetailPageModel,
      ),
    );
  }

  ChangeNotifierProvider<IconSettingPageModel> getIconSettingPage() {
    return ChangeNotifierProvider<IconSettingPageModel>(
      builder: (context) => IconSettingPageModel(),
      child: IconSettingPage(),
    );
  }

  ChangeNotifierProvider<ThemePageModel> getThemePage() {
    return ChangeNotifierProvider<ThemePageModel>(
      builder: (context) => ThemePageModel(),
      child: ThemePage(),
    );
  }

  ChangeNotifierProvider<AvatarPageModel> getAvatarPage(
      {MainPageModel mainPageModel}) {
    return ChangeNotifierProvider<AvatarPageModel>(
      builder: (context) => AvatarPageModel(),
      child: AvatarPage(
        mainPageModel: mainPageModel,
      ),
    );
  }

  ChangeNotifierProvider<DoneTaskPageModel> getDoneTaskPage() {
    return ChangeNotifierProvider<DoneTaskPageModel>(
      builder: (context) => DoneTaskPageModel(),
      child: DoneTaskPage(),
    );
  }
}
