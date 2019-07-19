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
    "addTask" : MessageLookupByLibrary.simpleMessage("add a task"),
    "appName" : MessageLookupByLibrary.simpleMessage("One Day"),
    "appSetting" : MessageLookupByLibrary.simpleMessage("Setting"),
    "avatar" : MessageLookupByLibrary.simpleMessage("avatar"),
    "avatarHistory" : MessageLookupByLibrary.simpleMessage("Select an avatar from the history"),
    "avatarLocal" : MessageLookupByLibrary.simpleMessage("Select an avatar from the local"),
    "avatarNet" : MessageLookupByLibrary.simpleMessage("Select an avatar from the network"),
    "backgroundGradient" : MessageLookupByLibrary.simpleMessage("Background Gradient"),
    "bgChangeWithCard" : MessageLookupByLibrary.simpleMessage("Background follow task icon color"),
    "blueGray" : MessageLookupByLibrary.simpleMessage("blue-gray"),
    "canNotAddMoreIcon" : MessageLookupByLibrary.simpleMessage("You can only customize up to 10 icons."),
    "canNotAddMoreTheme" : MessageLookupByLibrary.simpleMessage("You can only customize up to 10 themes."),
    "canNotEditDefaultIcon" : MessageLookupByLibrary.simpleMessage("Can\'t edit the default icon"),
    "cancel" : MessageLookupByLibrary.simpleMessage("cancel"),
    "cardChangeWithBg" : MessageLookupByLibrary.simpleMessage("Task icon color follow background"),
    "changeTheme" : MessageLookupByLibrary.simpleMessage("Change Theme"),
    "checkUpdate" : MessageLookupByLibrary.simpleMessage("Check Update"),
    "coffee" : MessageLookupByLibrary.simpleMessage("coffee"),
    "currentIcons" : MessageLookupByLibrary.simpleMessage("Current Icons"),
    "customIcon" : MessageLookupByLibrary.simpleMessage("Custom Icon"),
    "customTheme" : MessageLookupByLibrary.simpleMessage("Custom Theme"),
    "cyan" : MessageLookupByLibrary.simpleMessage("cyan"),
    "dailyPic" : MessageLookupByLibrary.simpleMessage("Daily wallpaper"),
    "dark" : MessageLookupByLibrary.simpleMessage("dark"),
    "deadline" : MessageLookupByLibrary.simpleMessage("deadline"),
    "defaultIconName" : MessageLookupByLibrary.simpleMessage("default"),
    "defaultTitle" : MessageLookupByLibrary.simpleMessage("Default title"),
    "deleteTask" : MessageLookupByLibrary.simpleMessage("Delete"),
    "deniedDes" : MessageLookupByLibrary.simpleMessage("Permission denied"),
    "disabledDes" : MessageLookupByLibrary.simpleMessage("Permission not available"),
    "editTask" : MessageLookupByLibrary.simpleMessage("Edit"),
    "enableInfiniteScroll" : MessageLookupByLibrary.simpleMessage("Task card cycle slide"),
    "endBeforeStart" : MessageLookupByLibrary.simpleMessage("The end date need be bigger than the start date."),
    "game" : MessageLookupByLibrary.simpleMessage("Game"),
    "green" : MessageLookupByLibrary.simpleMessage("green"),
    "history" : MessageLookupByLibrary.simpleMessage("history"),
    "iconSetting" : MessageLookupByLibrary.simpleMessage("Icon Setting"),
    "itemNumber" : m0,
    "languageTitle" : MessageLookupByLibrary.simpleMessage("Change Language"),
    "meteorShower" : MessageLookupByLibrary.simpleMessage("Meteor Shower"),
    "music" : MessageLookupByLibrary.simpleMessage("Music"),
    "navigatorSetting" : MessageLookupByLibrary.simpleMessage("Navigator Setting"),
    "netPicture" : MessageLookupByLibrary.simpleMessage("Network Picture"),
    "ok" : MessageLookupByLibrary.simpleMessage("ok"),
    "openSystemSetting" : MessageLookupByLibrary.simpleMessage("Open System Setting"),
    "pickAColor" : MessageLookupByLibrary.simpleMessage("Pick a color!"),
    "picture" : MessageLookupByLibrary.simpleMessage("Picture"),
    "pink" : MessageLookupByLibrary.simpleMessage("pink"),
    "purple" : MessageLookupByLibrary.simpleMessage("purple"),
    "read" : MessageLookupByLibrary.simpleMessage("Read"),
    "remindMe" : MessageLookupByLibrary.simpleMessage("remind me"),
    "repeat" : MessageLookupByLibrary.simpleMessage("repeat"),
    "restrictedDes" : MessageLookupByLibrary.simpleMessage("Permission is restricted"),
    "setIconName" : MessageLookupByLibrary.simpleMessage("icon name"),
    "sports" : MessageLookupByLibrary.simpleMessage("Sports"),
    "startAfterEnd" : MessageLookupByLibrary.simpleMessage("The start date need be smaller than the end date."),
    "startDate" : MessageLookupByLibrary.simpleMessage("start date"),
    "submit" : MessageLookupByLibrary.simpleMessage("Submit"),
    "taskItems" : m1,
    "travel" : MessageLookupByLibrary.simpleMessage("Travel"),
    "unknownDes" : MessageLookupByLibrary.simpleMessage("Unknown permission"),
    "welcomeWord" : MessageLookupByLibrary.simpleMessage("Hello, "),
    "work" : MessageLookupByLibrary.simpleMessage("Work"),
    "writeAtLeastOneTaskItem" : MessageLookupByLibrary.simpleMessage("Please write at least one task.")
  };
}
