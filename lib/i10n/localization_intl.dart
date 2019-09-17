import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/i10n/messages_all.dart';


class DemoLocalizations {
  static Future<DemoLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    print("name是：$localeName");
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
  String get searchIcon => Intl.message('Try searching for icon name', name: 'searchIcon', desc: '搜索图标名字',);


  String get myAccount => Intl.message('My Account', name: 'myAccount', desc: '我的账号',);
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
  String get feedbackWall => Intl.message('Feedback Wall', name: 'feedbackWall', desc: '反馈墙',);
  String get feedbackCantBeNull => Intl.message('feedback cannot be empty', name: 'feedbackCantBeNull', desc: '意见反馈内容不能为空哦',);
  String get feedbackIsTooLittle => Intl.message('feedback is too little, add a little more', name: 'feedbackIsTooLittle', desc: '意见反馈内容太少了，再加点儿吧',);
  String get feedbackNeedEmoji => Intl.message('please choose an emoji ', name: 'feedbackNeedEmoji', desc: '选个评价表情吧',);
  String get feedbackFrequently => Intl.message('Can only be submitted once in 8 hours. ', name: 'feedbackFrequently', desc: '8小时内只能提交一次哦',);
  String get writeYourFeedback => Intl.message('write your feedback ', name: 'writeYourFeedback', desc: '写下你的意见或是建议吧',);
  String get writeYourContactInfo => Intl.message('whether to leave your contact information', name: 'writeYourContactInfo', desc: '是否留下你的联系方式',);
  String get waitAMoment => Intl.message('please wait for a moment...', name: 'waitAMoment', desc: '请稍后...',);
  String get submitSuccess => Intl.message('submit success!', name: 'submitSuccess', desc: '提交成功！',);
  String get thanksForFeedback => Intl.message('Thanks for your feedback', name: 'thanksForFeedback', desc: '感谢你的反馈',);
  String get submitAgain => Intl.message('submit again', name: 'submitAgain', desc: '重新提交',);
  String get noName => Intl.message('anonymous', name: 'noName', desc: '无名氏',);

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
  String get enableNetPicBgInMainPage => Intl.message('Turn on the net-picture background', name: 'enableNetPicBgInMainPage', desc: '开启主页网络图片背景',);
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
  String get projectLink => Intl.message('Project Link', name: 'projectLink', desc: '项目地址',);
  String get myGithub => Intl.message('Author\'s Github'  , name: 'myGithub', desc: '作者的github',);


  String get iconSetting => Intl.message('Icon Setting', name: 'iconSetting', desc: '图标设置',);
  String get navigatorSetting => Intl.message('Navigator Setting', name: 'navigatorSetting', desc: '导航栏设置',);
  String get meteorShower => Intl.message('Meteor Shower', name: 'meteorShower', desc: '天体流星',);
  String get dailyPic => Intl.message('Daily wallpaper', name: 'dailyPic', desc: '每日壁纸',);
  String get netPicture => Intl.message('Network Picture', name: 'netPicture', desc: '网络图片',);
  String get accountBackgroundSetting => Intl.message('Background setting', name: 'accountBackgroundSetting', desc: '背景设置',);
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

  String get login => Intl.message('Login', name: 'login', desc: '登录',);
  String get email => Intl.message('EMAIL', name: 'email', desc: '邮箱',);
  String get password => Intl.message('PASSWORD', name: 'password', desc: '密码',);
  String get inputEmail => Intl.message('Enter email', name: 'inputEmail', desc: '输入邮箱',);
  String get inputPassword => Intl.message('Enter password', name: 'inputPassword', desc: '输入密码',);
  String get forget => Intl.message('Forget', name: 'forget', desc: '忘记',);
  String get logIn => Intl.message('Log In', name: 'logIn', desc: '登 录',);
  String get haveNoAccount => Intl.message('Don\'t have an Account?Sign Up', name: 'haveNoAccount', desc: '没有账号?注册一个',);
  String get register => Intl.message('Register', name: 'register', desc: '注册',);
  String get emailCantBeEmpty => Intl.message('email cannot be empty', name: 'emailCantBeEmpty', desc: '邮箱不能为空',);
  String get emailIncorrectFormat => Intl.message('email format is incorrect', name: 'emailIncorrectFormat', desc: '邮箱格式不正确',);
  String get passwordCantBeEmpty => Intl.message('password cannot be empty', name: 'passwordCantBeEmpty', desc: '密码不能为空',);
  String get passwordTooShort => Intl.message('password length cannot be less than 8 digits', name: 'passwordTooShort', desc: '密码长度不能小于8位',);
  String get passwordTooLong => Intl.message('password length cannot be greater than 20 digits', name: 'passwordTooLong', desc: '密码长度不能大于20位',);
  String get signUp => Intl.message('Sign Up', name: 'signUp', desc: '注册',);
  String get setUserName => Intl.message('please set your username', name: 'setUserName', desc: '请设置你的用户名',);
  String get userNameContainEmpty => Intl.message('username cannot contain spaces', name: 'userNameContainEmpty', desc: '用户名不能包含空格',);
  String get verifyCodeCantBeEmpty => Intl.message('verify code cannot be empty', name: 'verifyCodeCantBeEmpty', desc: '验证码不能为空',);
  String get verifyCodeContainEmpty => Intl.message('verify code cannot contain spaces', name: 'verifyCodeContainEmpty', desc: '验证码不能包含空格',);
  String get confirmPasswordCantBeEmpty => Intl.message('confirm password cannot be empty', name: 'confirmPasswordCantBeEmpty', desc: '确认密码不能为空',);
  String get confirmPasswordContainEmpty => Intl.message('confirm password cannot contain spaces', name: 'confirmPasswordContainEmpty', desc: '确认密码不能包含空格',);
  String get twoPasswordsNotSame => Intl.message('two passwords are not same', name: 'twoPasswordsNotSame', desc: '两次密码输入不一致',);
  String get userName => Intl.message('username', name: 'userName', desc: '用户名',);
  String get emailAccount => Intl.message('email account', name: 'emailAccount', desc: '邮箱账号',);
  String get setEmailAccount => Intl.message('please set your email account', name: 'setEmailAccount', desc: '请设置你的邮箱账号',);
  String get inputEmailAccount => Intl.message('please input your email account', name: 'inputEmailAccount', desc: '请输入你的邮箱账号',);
  String get verifyCode => Intl.message('verify code', name: 'verifyCode', desc: '验证码',);
  String get inputVerifyCode => Intl.message('please input the verify code you obtained', name: 'inputVerifyCode', desc: '输入验证码',);
  String get getVerifyCode => Intl.message('Get Verify Code', name: 'getVerifyCode', desc: '获取验证码',);
  String get setPassword => Intl.message('please set your password', name: 'setPassword', desc: '请设置你的密码',);
  String get thePassword => Intl.message('password', name: 'thePassword', desc: '密码',);
  String get reSetPassword => Intl.message('please set your password again', name: 'reSetPassword', desc: '再次确认你的密码',);
  String get confirmPassword => Intl.message('confirm password', name: 'confirmPassword', desc: '确认密码',);
  String get checkYourEmail => Intl.message('please check your email account', name: 'checkYourEmail', desc: '请检查你的邮箱账号',);
  String get checkYourEmailOrPassword => Intl.message('please check your email account or password', name: 'checkYourEmailOrPassword', desc: '请检查你的邮箱或者密码',);
  String get checkYourUserName => Intl.message('please check your username', name: 'checkYourUserName', desc: '请检查你的用户名',);
  String get usernameCantBeEmpty => Intl.message('username cannot be empty', name: 'usernameCantBeEmpty', desc: '用户名不能为空',);
  String get wrongParams => Intl.message('please check your input content', name: 'wrongParams', desc: '请检查你的输入内容',);
  String get setNewPassword => Intl.message('please set your new password', name: 'setNewPassword', desc: '请设置你的新密码',);
  String get forgetPassword => Intl.message('Forget Password', name: 'forgetPassword', desc: '忘记密码',);
  String get resetPassword => Intl.message('Reset Password', name: 'resetPassword', desc: '修改密码',);
  String get newPassword => Intl.message('new password', name: 'newPassword', desc: '新密码',);
  String get oldPassword => Intl.message('old password', name: 'oldPassword', desc: '原密码',);
  String get inputOldPassword => Intl.message('please input your old password', name: 'inputOldPassword', desc: '请输入你的原密码',);
  String get oldPasswordCantBeEmpty => Intl.message('old password cannot be empty', name: 'oldPasswordCantBeEmpty', desc: '原密码不能为空',);
  String get newPasswordCantBeEmpty => Intl.message('new password cannot be empty', name: 'newPasswordCantBeEmpty', desc: '新密码不能为空',);
  String get resetPasswordSuccess => Intl.message('Password reset complete', name: 'resetPasswordSuccess', desc: '密码修改成功',);
  String get resetPasswordFailed => Intl.message('Password reset failed', name: 'resetPasswordFailed', desc: '密码修改失败',);
  String get logout => Intl.message('Logout', name: 'logout', desc: '退出登录',);
  String get skip => Intl.message('skip', name: 'skip', desc: '跳过',);







  String get editTask{return Intl.message('Edit', name: 'editTask', desc: '编辑任务',);}
  String get deleteTask{return Intl.message('Delete', name: 'deleteTask', desc: '删除任务',);}
  String get submit => Intl.message('Submit', name: 'submit', desc: '提交任务',);
  String get addTask => Intl.message('add a task', name: 'addTask', desc: '添加任务',);
  String get deadline => Intl.message('deadline', name: 'deadline', desc: '截止日期',);
  String get startDate => Intl.message('start date', name: 'startDate', desc: '开始日期',);
  String get remindMe => Intl.message('remind me', name: 'remindMe', desc: '提醒我',);
  String get repeat => Intl.message('repeat', name: 'repeat', desc: '重复',);
  String get startAfterEnd => Intl.message('The start date need be smaller than the end date.', name: 'startAfterEnd', desc: '开始日期要比结束日期小才行哦',);
  String get endBeforeStart => Intl.message('The end date need be bigger than the start date.', name: 'endBeforeStart', desc: '结束日期要比开始日期大才行哦',);
  String get notSynced => Intl.message('Not synced ', name: 'notSynced', desc: '未同步 ',);
  String get clickToSyn => Intl.message('Click to sync', name: 'clickToSyn', desc: '点击同步',);
  String get synchronizing => Intl.message('Synchronizing...', name: 'synchronizing', desc: '同步中...',);
  String get cloudSynchronizing => Intl.message('Synchronizing from server...', name: 'cloudSynchronizing', desc: '获取云端数据...',);
  String get synchronizeFailed => Intl.message('Synchronize failed', name: 'synchronizeFailed', desc: '同步失败',);


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
  String get waiting => Intl.message('waiting...', name: 'waiting', desc: '请稍后...',);
  String get timeOut => Intl.message('timeout error', name: 'timeOut', desc: '超时错误',);
  String get pullUpToLoadMore => Intl.message('pull up load more', name: 'pullUpToLoadMore', desc: '上拉加载更多',);
  String get pullDownToRefresh => Intl.message('pull down to refresh', name: 'pullDownToRefresh', desc: '下拉刷新',);
  String get reLoading => Intl.message('click to reload', name: 'reLoading', desc: '点击重新加载',);
  String get requestError => Intl.message('request error', name: 'requestError', desc: '请求错误',);
  String get requestFailed => Intl.message('request failed', name: 'requestFailed', desc: '请求失败',);



  ///以下是版本更新相关

  String get version100 => Intl.message('Version:1.0.0 \n\n'
      'The Version 1.0.0 released!\n', name: 'version100', desc: '版本:1.0.0 \n\n'
      '版本 1.0.0 发布啦!',);

  String get version101 => Intl.message('Version:1.0.1 \n\n'
      '1.Fixed: done list show error \n'
      '2.Add: Edit page can add start-date and deadline\n', name: 'version101', desc: '版本:1.0.1 \n\n'
      '1.修复完成列表界面的显示bug\n'
      '2.新增编辑任务可以添加起止时间，用作提醒\n',);

  String get version102 => Intl.message('Version:1.0.2 \n\n'
      '1.Fixed: some bugs \n'
      '2.Add: IconSetting Page can search icons now \n', name: 'version102', desc: '版本:1.0.2 \n\n'
      '1.修复一些小bug \n'
      '2.图标设置界面可以搜索图标了 \n',);

  String get version103 => Intl.message('Version:1.0.3 \n\n'
      '1.Fixed: The text color of the upgrade frame is wrong.(dark mode) \n'
      '2.Fixed: Done List complete time is negative. \n'
      '3.Add: Suggestion display wall. \n', name: 'version103', desc: '版本:1.0.3 \n\n'
      '1.修复：升级弹框的文字颜色错误(夜间模式下) \n'
      '2.修复：完成列表显示的的完成用时为负数 \n'
      '3.新增：留言展示墙！ \n',
  );

  String get version104 => Intl.message('Version:1.0.4 \n\n'
      '1.Fixed: Search page overflow bugs, other small bugs \n'
      '2.Add: Account System.🎉 Celebrating github Star’s number over 500！ \n\n'
      'Todo: Sync task list information to the cloud \n', name: 'version104', desc: '版本:1.0.4 \n\n'
      '1.修复：搜索页面的控件溢出bug、其他各种小bug \n'
      '2.新增：账号系统!🎉庆祝github Star数过500！ \n\n'
      'Todo:任务列表信息同步至云端功能,麻麻再也不用担心我换手机啦\n',
  );

  String get version105 => Intl.message('Version:1.0.5 \n\n'
      '1.Fixed: Fix the bug that the homepage returns to log in and then returns to the homepage to create a task that cannot be refreshed \n'
      '2.Optimization: upgrade popup display timeout error \n'
      '3.Add: 🎉 Sync tasks to the cloud! Ma Ma no longer have to worry about changing my phone! 🎉 \n', name: 'version105', desc: '版本:1.0.5 \n\n'
      '1.修复：从主页进入登录页登录后再进入主页后，创建task不能刷新的bug \n'
      '2.优化：升级弹窗显示timeout报错 \n'
      '3.新增：🎉任务同步至云端功能！麻麻再也不用担心我换手机啦！🎉 ',
  );

  String get version106 => Intl.message('Version:1.0.6 \n\n'
      '1.Fixed: a lot of bugs due to the online account system. \n'
      '2.Optimization: now you can edit all icons when the icons\'s number is bigger than six  \n'
      '3.Add: You can set the network image as the background on the account page. \n', name: 'version106', desc: '版本:1.0.6 \n\n'
      '1.修复：大量因为上线账号系统,而新增的bug \n'
      '2.优化：当自定义图标数量不低于6个的时候，你可以任意编辑图标啦 \n'
      '3.新增：你可以在账号页面设置网络图片作为背景啦',
  );

  String get version107 => Intl.message('Version:1.0.7 \n\n'
      '1.Fixed: some bugs had been discovered! \n'
      '2.Add: Now you can change your background to network image in main page!It will be very beautiful! \n', name: 'version107', desc: '版本:1.0.7 \n\n'
      '1.修复：已经发现的一些bug\n'
      '2.新增：现在可以将主页的背景更换为网络图片啦，非常漂亮哦！ \n',
  );

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