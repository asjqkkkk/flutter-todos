// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en_US locale. All the
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
  get localeName => 'en_US';

  static m0(number) => "${Intl.plural(number, zero: 'There is No items ', one: '1 item ', other: '${number} items ')}";

  static m1(taskNumbers) => "${Intl.plural(taskNumbers, zero: 'You have never written a list of tasks.\nLet\'s get started soon.', one: 'This is your todo-list,\nToday, you have 1 task to complete. ', many: 'This is your todo-list,\nToday, you have ${taskNumbers} tasks to complete. ', other: 'This is your todo-list,\nToday, you have ${taskNumbers} tasks to complete. ')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "aboutApp" : MessageLookupByLibrary.simpleMessage("About"),
    "appName" : MessageLookupByLibrary.simpleMessage("One Day"),
    "appSetting" : MessageLookupByLibrary.simpleMessage("Setting"),
    "backgroundGradient" : MessageLookupByLibrary.simpleMessage("Background Gradient"),
    "changeTheme" : MessageLookupByLibrary.simpleMessage("Change Theme"),
    "checkUpdate" : MessageLookupByLibrary.simpleMessage("Check Update"),
    "coffee" : MessageLookupByLibrary.simpleMessage("coffee"),
    "cyan" : MessageLookupByLibrary.simpleMessage("cyan"),
    "dark" : MessageLookupByLibrary.simpleMessage("dark"),
    "deleteTask" : MessageLookupByLibrary.simpleMessage("Delete"),
    "editTask" : MessageLookupByLibrary.simpleMessage("Edit"),
    "green" : MessageLookupByLibrary.simpleMessage("green"),
    "itemNumber" : m0,
    "languageTitle" : MessageLookupByLibrary.simpleMessage("Change Language"),
    "pink" : MessageLookupByLibrary.simpleMessage("pink"),
    "purple" : MessageLookupByLibrary.simpleMessage("purple"),
    "taskItems" : m1,
    "welcomeWord" : MessageLookupByLibrary.simpleMessage("Hello, ")
  };
}
