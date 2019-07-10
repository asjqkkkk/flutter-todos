// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

// ignore: unnecessary_new
final messages = new MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'zh_CN';

  static m0(number) => "${Intl.plural(number, zero: '还没有任务详情哦 ', one: '1 项 ', other: '${number} 项 ')}";

  static m1(taskNumbers) => "${Intl.plural(taskNumbers, zero: '你还没有写过任务清单呢.\n快快开始吧.', one: '下面你的任务清单,\n今天, 你有 1 项任务尚未完成. ', many: '下面是你的任务清单,\n今天, 你有 ${taskNumbers} 份任务尚未完成. ', other: '下面是你的任务清单,\n今天, 你有 ${taskNumbers} 份任务尚未完成. ')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "aboutApp" : MessageLookupByLibrary.simpleMessage("关于"),
    "appName" : MessageLookupByLibrary.simpleMessage("一日"),
    "appSetting" : MessageLookupByLibrary.simpleMessage("设置"),
    "backgroundGradient" : MessageLookupByLibrary.simpleMessage("背景渐变"),
    "blueGray" : MessageLookupByLibrary.simpleMessage("炊烟袅袅"),
    "changeTheme" : MessageLookupByLibrary.simpleMessage("切换主题"),
    "checkUpdate" : MessageLookupByLibrary.simpleMessage("检查更新"),
    "coffee" : MessageLookupByLibrary.simpleMessage("想入啡啡"),
    "cyan" : MessageLookupByLibrary.simpleMessage("蓝天白云"),
    "dark" : MessageLookupByLibrary.simpleMessage("不见五指"),
    "deleteTask" : MessageLookupByLibrary.simpleMessage("删除"),
    "editTask" : MessageLookupByLibrary.simpleMessage("编辑"),
    "green" : MessageLookupByLibrary.simpleMessage("青青草原"),
    "itemNumber" : m0,
    "languageTitle" : MessageLookupByLibrary.simpleMessage("切换语言"),
    "pink" : MessageLookupByLibrary.simpleMessage("略施粉黛"),
    "purple" : MessageLookupByLibrary.simpleMessage("紫气东来"),
    "taskItems" : m1,
    "welcomeWord" : MessageLookupByLibrary.simpleMessage("你好呀, ")
  };
}
