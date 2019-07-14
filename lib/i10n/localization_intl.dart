import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/i10n/messages_all.dart';


class DemoLocalizations {
  static Future<DemoLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    print("name是：${localeName}");
    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return new DemoLocalizations();
    });
  }

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  String get appName{
    return Intl.message("One Day",name: "appName",desc: "app的名字");
  }

  String get languageTitle {
    return Intl.message(
      'Change Language',
      name: 'languageTitle',
      desc: '修改语言',
    );
  }

  String get changeTheme {
    return Intl.message(
      'Change Theme',
      name: 'changeTheme',
      desc: '切换主题',
    );
  }

  String get appSetting {
    return Intl.message(
      'Setting',
      name: 'appSetting',
      desc: 'app设置',
    );
  }

  String get backgroundGradient {
    return Intl.message(
      'Background Gradient',
      name: 'backgroundGradient',
      desc: 'app设置',
    );
  }
  String get bgChangeWithCard => Intl.message('Background follow task icon color', name: 'bgChangeWithCard', desc: '背景跟随任务图标颜色',);
  String get enableInfiniteScroll => Intl.message('Task card cycle slide', name: 'enableInfiniteScroll', desc: '任务卡片循环滑动',);


  String get aboutApp {
    return Intl.message(
      'About',
      name: 'aboutApp',
      desc: '关于',
    );
  }

  String get iconSetting => Intl.message('Icon Setting', name: 'iconSetting', desc: '图标设置',);
  String get currentIcons => Intl.message('Current Icons', name: 'currentIcons', desc: '当前图标',);
  String get game => Intl.message('Game', name: 'game', desc: '打游戏',);
  String get music => Intl.message('Music', name: 'music', desc: '听歌',);
  String get read => Intl.message('Read', name: 'read', desc: '读书',);
  String get sports => Intl.message('Sports', name: 'sports', desc: '运动',);
  String get travel => Intl.message('Travel', name: 'travel', desc: '旅行',);
  String get work => Intl.message('Work', name: 'work', desc: '工作',);


  String get setIconName => Intl.message('icon name', name: 'setIconName', desc: '给图标设置一个名字吧',);
  String get defaultIconName => Intl.message('default', name: 'defaultIconName', desc: '默认',);
  String get customIcon => Intl.message('Custom Icon', name: 'customIcon', desc: '自定义图标',);
  String get cancel => Intl.message('cancel', name: 'cancel', desc: '取消',);
  String get ok => Intl.message('ok', name: 'ok', desc: '确定',);
  String get pickAColor => Intl.message('Pick a color!', name: 'pickAColor', desc: '选择一个颜色吧!',);
  String get canNotAddMoreIcon => Intl.message('You can only customize up to 10 icons.', name: 'canNotAddMoreIcon', desc: '最多只能自定义10个图标',);
  String get canNotEditDefaultIcon => Intl.message('Can\'t edit the default icon', name: 'canNotEditDefaultIcon', desc: '默认图标无法编辑哦',);
  String get customTheme => Intl.message('Custom Theme', name: 'customTheme', desc: '自定义主题',);
  String get canNotAddMoreTheme => Intl.message('You can only customize up to 10 themes.', name: 'canNotAddMoreTheme', desc: '最多只能自定义10个主题哦',);
  String get writeAtLeastOneTaskItem => Intl.message('Please write at least one task.', name: 'writeAtLeastOneTaskItem', desc: '请至少写下一项任务哦',);
  String get defaultTitle => Intl.message('Default title', name: 'defaultTitle', desc: '默认标题',);






  String get checkUpdate {
    return Intl.message(
      'Check Update',
      name: 'checkUpdate',
      desc: '检查更新',
    );
  }

  String get welcomeWord{
    return Intl.message(
      'Hello, ',
      name: 'welcomeWord',
      desc: '主页的欢迎词',
    );
  }

  String get pink{
    return Intl.message(
      'pink',
      name: 'pink',
      desc: '主题颜色',
    );
  }

  String get coffee{
    return Intl.message(
      'coffee',
      name: 'coffee',
      desc: '主题颜色',
    );
  }

  String get cyan{
    return Intl.message(
      'cyan',
      name: 'cyan',
      desc: '主题颜色',
    );
  }

  String get green{
    return Intl.message(
      'green',
      name: 'green',
      desc: '主题颜色',
    );
  }

  String get purple{
    return Intl.message(
      'purple',
      name: 'purple',
      desc: '主题颜色',
    );
  }

  String get dark{
    return Intl.message(
      'dark',
      name: 'dark',
      desc: '主题颜色',
    );
  }

  String get blueGray{
    return Intl.message(
      'blue-gray',
      name: 'blueGray',
      desc: '主题颜色',
    );
  }

  String get editTask{
    return Intl.message(
      'Edit',
      name: 'editTask',
      desc: '编辑任务',
    );
  }

  String get deleteTask{
    return Intl.message(
      'Delete',
      name: 'deleteTask',
      desc: '删除任务',
    );
  }

  String get submit => Intl.message('Submit', name: 'submit', desc: '提交任务',);
  String get addTask => Intl.message('add a task', name: 'addTask', desc: '添加任务',);
  String get deadline => Intl.message('deadline', name: 'deadline', desc: '截止日期',);
  String get startDate => Intl.message('start date', name: 'startDate', desc: '开始日期',);
  String get remindMe => Intl.message('remind me', name: 'remindMe', desc: '提醒我',);
  String get repeat => Intl.message('repeat', name: 'repeat', desc: '重复',);
  String get startAfterEnd => Intl.message('The start date need be smaller than the end date.', name: 'startAfterEnd', desc: '开始日期要比结束日期小才行哦',);
  String get endBeforeStart => Intl.message('The end date need be bigger than the start date.', name: 'endBeforeStart', desc: '结束日期要比开始日期大才行哦',);


  String taskItems(int taskNumbers){
    return Intl.plural(
      taskNumbers,
      zero: "You have never written a list of tasks.\nLet's get started soon.",
      one: "This is your todo-list,\nToday, you have 1 task to complete. ",
      many: "This is your todo-list,\nToday, you have $taskNumbers tasks to complete. ",
      other:"This is your todo-list,\nToday, you have $taskNumbers tasks to complete. ",
      args: [taskNumbers],
      name: "taskItems"
    );
  }

  String itemNumber(int number){
    return Intl.plural(
        number,
        zero: "There is No items ",
        one: "1 item ",
        other: "$number items ",
        args: [number],
        name: "itemNumber"
    );
  }

}

//Locale代理类
class DemoLocalizationsDelegate extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  //是否支持某个Local
  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  // Flutter会调用此类加载相应的Locale资源类
  @override
  Future<DemoLocalizations> load(Locale locale) {
    //3
    return  DemoLocalizations.load(locale);
  }

  // 当Localizations Widget重新build时，是否调用load重新加载Locale资源.
  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}