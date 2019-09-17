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

  ///全局provider
  ChangeNotifierProvider<GlobalModel> getGlobal(Widget child) {
    return ChangeNotifierProvider<GlobalModel>(
      builder: (context) => GlobalModel(),
      child: child,
    );
  }

  ///主页provider
  ChangeNotifierProvider<MainPageModel> getMainPage() {
    return ChangeNotifierProvider<MainPageModel>(
      builder: (context) => MainPageModel(),
      child: MainPage(),
    );
  }

  ///任务详情页provider
  ChangeNotifierProvider<TaskDetailPageModel> getTaskDetailPage(
    int index,
    TaskBean taskBean, {
    DoneTaskPageModel doneTaskPageModel,
    SearchPageModel searchPageModel,
  }) {
    return ChangeNotifierProvider<TaskDetailPageModel>(
      builder: (context) => TaskDetailPageModel(
        taskBean,
        doneTaskPageModel: doneTaskPageModel,
        searchPageModel: searchPageModel,
        heroTag: index,
      ),
      child: TaskDetailPage(),
    );
  }

  ///任务编辑页provider
  ChangeNotifierProvider<EditTaskPageModel> getEditTaskPage(
      TaskIconBean taskIcon,
      {TaskDetailPageModel taskDetailPageModel,
      TaskBean taskBean}) {
    return ChangeNotifierProvider<EditTaskPageModel>(
      builder: (context) => EditTaskPageModel(oldTaskBean: taskBean),
      child: EditTaskPage(
        taskIcon,
        taskDetailPageModel: taskDetailPageModel,
      ),
    );
  }

  ///图标设置页provider
  ChangeNotifierProvider<IconSettingPageModel> getIconSettingPage() {
    return ChangeNotifierProvider<IconSettingPageModel>(
      builder: (context) => IconSettingPageModel(),
      child: IconSettingPage(),
    );
  }

  ///主题设置页provider
  ChangeNotifierProvider<ThemePageModel> getThemePage() {
    return ChangeNotifierProvider<ThemePageModel>(
      builder: (context) => ThemePageModel(),
      child: ThemePage(),
    );
  }

  ///头像裁剪页provider
  ChangeNotifierProvider<AvatarPageModel> getAvatarPage(
      {MainPageModel mainPageModel}) {
    return ChangeNotifierProvider<AvatarPageModel>(
      builder: (context) => AvatarPageModel(),
      child: AvatarPage(
        mainPageModel: mainPageModel,
      ),
    );
  }

  ///完成列表页provider
  ChangeNotifierProvider<DoneTaskPageModel> getDoneTaskPage() {
    return ChangeNotifierProvider<DoneTaskPageModel>(
      builder: (context) => DoneTaskPageModel(),
      child: DoneTaskPage(),
    );
  }

  ///搜索任务页provider
  ChangeNotifierProvider<SearchPageModel> getSearchPage() {
    return ChangeNotifierProvider<SearchPageModel>(
      builder: (context) => SearchPageModel(),
      child: SearchPage(),
    );
  }

  ///意见反馈页provider
  ChangeNotifierProvider<FeedbackPageModel> getFeedbackPage(
      FeedbackWallPageModel feedbackWallPageModel) {
    return ChangeNotifierProvider<FeedbackPageModel>(
      builder: (context) => FeedbackPageModel(),
      child: FeedbackPage(feedbackWallPageModel),
    );
  }

  ///意见反馈墙页provider
  ChangeNotifierProvider<FeedbackWallPageModel> getFeedbackWallPage() {
    return ChangeNotifierProvider<FeedbackWallPageModel>(
      builder: (context) => FeedbackWallPageModel(),
      child: FeedbackWallPage(),
    );
  }

  ///登录页provider
  ChangeNotifierProvider<LoginPageModel> getLoginPage({bool isFirst = false}) {
    return ChangeNotifierProvider<LoginPageModel>(
      builder: (context) => LoginPageModel(isFirst: isFirst),
      child: LoginPage(),
    );
  }

  ///注册页provider
  ChangeNotifierProvider<RegisterPageModel> getRegisterPage() {
    return ChangeNotifierProvider<RegisterPageModel>(
      builder: (context) => RegisterPageModel(),
      child: RegisterPage(),
    );
  }

  ///重设密码页provider,可以设重设密码，也可以设是记密码
  ChangeNotifierProvider<ResetPasswordPageModel> getResetPasswordPage(
      {bool isReset = true}) {
    return ChangeNotifierProvider<ResetPasswordPageModel>(
      builder: (context) => ResetPasswordPageModel(isReset),
      child: ResetPasswordPage(),
    );
  }

  ///网络图片页provider，用于设置账号页面的背景，或者侧滑栏的头部,或者主页背景
  ChangeNotifierProvider<NetPicturesPageModel> getNetPicturesPage(
      {@required String useType, AccountPageModel accountPageModel}) {
    return ChangeNotifierProvider<NetPicturesPageModel>(
      builder: (context) => NetPicturesPageModel(
          useType: useType, accountPageModel: accountPageModel),
      child: NetPicturesPage(),
    );
  }

  ///账号页面的provider
  ChangeNotifierProvider<AccountPageModel> getAccountPage() {
    return ChangeNotifierProvider<AccountPageModel>(
      builder: (context) => AccountPageModel(),
      child: AccountPage(),
    );
  }
}
