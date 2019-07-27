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
    return Intl.message("One Day List",name: "appName",desc: "app的名字");
  }
  String get tryToSearch => Intl.message('Try searching for the title or content', name: 'tryToSearch', desc: '试试搜一下标题、内容吧',);


  String get doneList => Intl.message('Done List', name: 'doneList', desc: '完成列表',);
  String get toFinishTask => Intl.message('Try to complete a task!', name: 'toFinishTask', desc: '努力去完成一项任务吧!',);
  String get taskNum => Intl.message('Task Number', name: 'taskNum', desc: '任务数',);
  String get createDate => Intl.message('Create Date', name: 'createDate', desc: '创建日期',);
  String get completeDate => Intl.message('Complete Date', name: 'completeDate', desc: '完成日期',);
  String get spendTime => Intl.message('Spend Time', name: 'spendTime', desc: '用时',);
  String get changedTimes => Intl.message('Changed Times', name: 'changedTimes', desc: '修改次数',);
  String hours(int hours){
    return Intl.plural(
        hours,
        zero: "Too Fast",
        one: "1 hour",
        many: "$hours hours",
        other:"$hours hours",
        args: [hours],
        name: "hours"
    );
  }
  String days(int days){
    return Intl.plural(
        days,
        zero: "Too Fast",
        one: "1 day",
        many: "$days days",
        other:"$days days",
        args: [days],
        name: "days"
    );
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

  String get feedback => Intl.message('Feedback', name: 'feedback', desc: '意见反馈',);
  String get feedbackCantBeNull => Intl.message('feedback cannot be empty', name: 'feedbackCantBeNull', desc: '意见反馈内容不能为空哦',);
  String get feedbackIsTooLittle => Intl.message('feedback is too little, add a little more', name: 'feedbackIsTooLittle', desc: '意见反馈内容太少了，再加点儿吧',);
  String get feedbackNeedEmoji => Intl.message('please choose an emoji ', name: 'feedbackNeedEmoji', desc: '选个评价表情吧',);
  String get writeYourFeedback => Intl.message('write your feedback ', name: 'writeYourFeedback', desc: '写下你的意见或是建议吧',);
  String get writeYourContactInfo => Intl.message('whether to leave your contact information', name: 'writeYourContactInfo', desc: '是否留下你的联系方式',);
  String get waitAMoment => Intl.message('please wait for a moment...', name: 'waitAMoment', desc: '请稍后...',);
  String get submitSuccess => Intl.message('submit success!', name: 'submitSuccess', desc: '提交成功！',);
  String get thanksForFeedback => Intl.message('Thanks for your feedback', name: 'thanksForFeedback', desc: '感谢你的反馈',);
  String get submitAgain => Intl.message('submit again', name: 'submitAgain', desc: '重新提交',);

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
  String get cardChangeWithBg => Intl.message('Task icon color follow background', name: 'cardChangeWithBg', desc: '任务图标颜色跟随背景',);
  String get enableInfiniteScroll => Intl.message('Task card cycle slide', name: 'enableInfiniteScroll', desc: '任务卡片循环滑动',);
  String get enableWeatherShow => Intl.message('Turn on the weather', name: 'enableWeatherShow', desc: '开启天气',);
  String get inputCurrentCity => Intl.message('input your city', name: 'inputCurrentCity', desc: '手动输入你的城市',);
  String get weatherGetWrong => Intl.message('failed to get the weather，please try again', name: 'weatherGetWrong', desc: '天气获取失败,请重新尝试',);
  String get weatherGetting => Intl.message('the weather is inquiring...', name: 'weatherGetting', desc: '天气获取中...',);
  String get weatherSuccess => Intl.message('the weather is successful', name: 'weatherSuccess', desc: '天气获取成功',);




  String get aboutApp {
    return Intl.message(
      'About',
      name: 'aboutApp',
      desc: '关于',
    );
  }

  String get versionDescription => Intl.message('Version Description', name: 'versionDescription', desc: '版本描述',);


  String get iconSetting => Intl.message('Icon Setting', name: 'iconSetting', desc: '图标设置',);
  String get navigatorSetting => Intl.message('Navigator Setting', name: 'navigatorSetting', desc: '导航栏设置',);
  String get meteorShower => Intl.message('Meteor Shower', name: 'meteorShower', desc: '天体流星',);
  String get dailyPic => Intl.message('Daily wallpaper', name: 'dailyPic', desc: '每日壁纸',);
  String get netPicture => Intl.message('Network Picture', name: 'netPicture', desc: '网络图片',);
  String get picture => Intl.message('Picture', name: 'picture', desc: '图片',);

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

  String get avatarLocal => Intl.message('Select an avatar from the local', name: 'avatarLocal', desc: '从本地选取头像',);
  String get avatarNet => Intl.message('Select an avatar from the network', name: 'avatarNet', desc: '从网络选取头像',);
  String get avatarHistory => Intl.message('Select an avatar from the history', name: 'avatarHistory', desc: '历史头像记录',);
  String get avatar => Intl.message('avatar', name: 'avatar', desc: '头像',);
  String get save => Intl.message('save', name: 'save', desc: '保存',);
  String get history => Intl.message('history', name: 'history', desc: '历史',);


  String get deniedDes => Intl.message('Permission denied', name: 'deniedDes', desc: '权限被拒绝',);
  String get disabledDes => Intl.message('Permission not available', name: 'disabledDes', desc: '权限不可用',);
  String get restrictedDes => Intl.message('Permission is restricted', name: 'restrictedDes', desc: '权限被限制',);
  String get unknownDes => Intl.message('Unknown permission', name: 'unknownDes', desc: '未知权限',);
  String get openSystemSetting => Intl.message('Open System Setting', name: 'openSystemSetting', desc: '打开系统设置',);


  String get checkUpdate {
    return Intl.message(
      'Check Update',
      name: 'checkUpdate',
      desc: '检查更新',
    );
  }
  String get update => Intl.message('update', name: 'update', desc: '升级',);
  String get newVersionIsComing => Intl.message('New version is comming!', name: 'newVersionIsComing', desc: '新版本来啦!',);
  String get noUpdate => Intl.message('It is the latest version', name: 'noUpdate', desc: '已是最新版本',);


  String get welcomeWord{
    return Intl.message(
      'Hello! ',
      name: 'welcomeWord',
      desc: '主页的欢迎词',
    );
  }

  String get customUserName => Intl.message('Setting your username', name: 'customUserName', desc: '昵称设置',);
  String get inputUserName => Intl.message('input your username', name: 'inputUserName', desc: '输入你的昵称吧',);
  String get userNameCantBeNull => Intl.message('username can not be empty', name: 'userNameCantBeNull', desc: '昵称不能为空哦!',);



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


  String get loadingEmpty => Intl.message('nothing at all', name: 'loadingEmpty', desc: '什么都没有哦',);
  String get loadingIdle => Intl.message('...', name: 'loadingIdle', desc: '......',);
  String get loadingError => Intl.message('loading error', name: 'loadingError', desc: '加载出错了',);
  String get loading => Intl.message('loading...', name: 'loading', desc: '加载中...',);
  String get pullUpToLoadMore => Intl.message('pull up load more', name: 'pullUpToLoadMore', desc: '上拉加载更多',);
  String get pullDownToRefresh => Intl.message('pull down to refresh', name: 'pullDownToRefresh', desc: '下拉刷新',);
  String get reLoading => Intl.message('click to reload', name: 'reLoading', desc: '点击重新加载',);



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