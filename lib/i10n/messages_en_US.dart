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

  static m0(days) => "${Intl.plural(days, zero: 'Too Fast', one: '1 day', many: '${days} days', other: '${days} days')}";

  static m1(hours) => "${Intl.plural(hours, zero: 'Too Fast', one: '1 hour', many: '${hours} hours', other: '${hours} hours')}";

  static m2(number) => "${Intl.plural(number, zero: 'There is No items ', one: '1 item ', other: '${number} items ')}";

  static m3(taskNumbers) => "${Intl.plural(taskNumbers, zero: 'You have never written a list of tasks.\nLet\'s get started soon.', one: 'This is your todo-list,\nToday, you have 1 task to complete. ', many: 'This is your todo-list,\nToday, you have ${taskNumbers} tasks to complete. ', other: 'This is your todo-list,\nToday, you have ${taskNumbers} tasks to complete. ')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "aboutApp" : MessageLookupByLibrary.simpleMessage("About"),
    "addTask" : MessageLookupByLibrary.simpleMessage("add a task"),
    "appName" : MessageLookupByLibrary.simpleMessage("One Day List"),
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
    "changedTimes" : MessageLookupByLibrary.simpleMessage("Changed Times"),
    "checkUpdate" : MessageLookupByLibrary.simpleMessage("Check Update"),
    "coffee" : MessageLookupByLibrary.simpleMessage("coffee"),
    "completeDate" : MessageLookupByLibrary.simpleMessage("Finish Date"),
    "createDate" : MessageLookupByLibrary.simpleMessage("Create Date"),
    "currentIcons" : MessageLookupByLibrary.simpleMessage("Current Icons"),
    "customIcon" : MessageLookupByLibrary.simpleMessage("Custom Icon"),
    "customTheme" : MessageLookupByLibrary.simpleMessage("Custom Theme"),
    "customUserName" : MessageLookupByLibrary.simpleMessage("Setting your username"),
    "cyan" : MessageLookupByLibrary.simpleMessage("cyan"),
    "dailyPic" : MessageLookupByLibrary.simpleMessage("Daily wallpaper"),
    "dark" : MessageLookupByLibrary.simpleMessage("dark"),
    "days" : m0,
    "deadline" : MessageLookupByLibrary.simpleMessage("deadline"),
    "defaultIconName" : MessageLookupByLibrary.simpleMessage("default"),
    "defaultTitle" : MessageLookupByLibrary.simpleMessage("Default title"),
    "deleteTask" : MessageLookupByLibrary.simpleMessage("Delete"),
    "deniedDes" : MessageLookupByLibrary.simpleMessage("Permission denied"),
    "disabledDes" : MessageLookupByLibrary.simpleMessage("Permission not available"),
    "doneList" : MessageLookupByLibrary.simpleMessage("Done List"),
    "editTask" : MessageLookupByLibrary.simpleMessage("Edit"),
    "enableInfiniteScroll" : MessageLookupByLibrary.simpleMessage("Task card cycle slide"),
    "enableWeatherShow" : MessageLookupByLibrary.simpleMessage("Turn on the weather"),
    "endBeforeStart" : MessageLookupByLibrary.simpleMessage("The end date need be bigger than the start date."),
    "feedback" : MessageLookupByLibrary.simpleMessage("Feedback"),
    "feedbackCantBeNull" : MessageLookupByLibrary.simpleMessage("feedback cannot be empty"),
    "feedbackIsTooLittle" : MessageLookupByLibrary.simpleMessage("feedback is too little, add a little more"),
    "feedbackNeedEmoji" : MessageLookupByLibrary.simpleMessage("please choose an emoji "),
    "game" : MessageLookupByLibrary.simpleMessage("Game"),
    "green" : MessageLookupByLibrary.simpleMessage("green"),
    "history" : MessageLookupByLibrary.simpleMessage("history"),
    "hours" : m1,
    "iconSetting" : MessageLookupByLibrary.simpleMessage("Icon Setting"),
    "inputCurrentCity" : MessageLookupByLibrary.simpleMessage("input your city"),
    "inputUserName" : MessageLookupByLibrary.simpleMessage("input your username"),
    "itemNumber" : m2,
    "languageTitle" : MessageLookupByLibrary.simpleMessage("Change Language"),
    "loading" : MessageLookupByLibrary.simpleMessage("loading..."),
    "loadingEmpty" : MessageLookupByLibrary.simpleMessage("nothing at all"),
    "loadingError" : MessageLookupByLibrary.simpleMessage("loading error"),
    "loadingIdle" : MessageLookupByLibrary.simpleMessage("......"),
    "meteorShower" : MessageLookupByLibrary.simpleMessage("Meteor Shower"),
    "music" : MessageLookupByLibrary.simpleMessage("Music"),
    "navigatorSetting" : MessageLookupByLibrary.simpleMessage("Navigator Setting"),
    "netPicture" : MessageLookupByLibrary.simpleMessage("Network Picture"),
    "newVersionIsComing" : MessageLookupByLibrary.simpleMessage("New version is comming!"),
    "noUpdate" : MessageLookupByLibrary.simpleMessage("It is the latest version"),
    "ok" : MessageLookupByLibrary.simpleMessage("ok"),
    "openSystemSetting" : MessageLookupByLibrary.simpleMessage("Open System Setting"),
    "pickAColor" : MessageLookupByLibrary.simpleMessage("Pick a color!"),
    "picture" : MessageLookupByLibrary.simpleMessage("Picture"),
    "pink" : MessageLookupByLibrary.simpleMessage("pink"),
    "pullDownToRefresh" : MessageLookupByLibrary.simpleMessage("pull down to refresh"),
    "pullUpToLoadMore" : MessageLookupByLibrary.simpleMessage("pull up load more"),
    "purple" : MessageLookupByLibrary.simpleMessage("purple"),
    "reLoading" : MessageLookupByLibrary.simpleMessage("click to reload"),
    "read" : MessageLookupByLibrary.simpleMessage("Read"),
    "remindMe" : MessageLookupByLibrary.simpleMessage("remind me"),
    "repeat" : MessageLookupByLibrary.simpleMessage("repeat"),
    "restrictedDes" : MessageLookupByLibrary.simpleMessage("Permission is restricted"),
    "save" : MessageLookupByLibrary.simpleMessage("save"),
    "setIconName" : MessageLookupByLibrary.simpleMessage("icon name"),
    "spendTime" : MessageLookupByLibrary.simpleMessage("Spend Time"),
    "sports" : MessageLookupByLibrary.simpleMessage("Sports"),
    "startAfterEnd" : MessageLookupByLibrary.simpleMessage("The start date need be smaller than the end date."),
    "startDate" : MessageLookupByLibrary.simpleMessage("start date"),
    "submit" : MessageLookupByLibrary.simpleMessage("Submit"),
    "submitAgain" : MessageLookupByLibrary.simpleMessage("submit again"),
    "submitSuccess" : MessageLookupByLibrary.simpleMessage("submit success!"),
    "taskItems" : m3,
    "taskNum" : MessageLookupByLibrary.simpleMessage("Task Number"),
    "thanksForFeedback" : MessageLookupByLibrary.simpleMessage("Thanks for your feedback"),
    "toFinishTask" : MessageLookupByLibrary.simpleMessage("Try to complete a task!"),
    "travel" : MessageLookupByLibrary.simpleMessage("Travel"),
    "tryToSearch" : MessageLookupByLibrary.simpleMessage("Try searching for the title or content"),
    "unknownDes" : MessageLookupByLibrary.simpleMessage("Unknown permission"),
    "update" : MessageLookupByLibrary.simpleMessage("update"),
    "userNameCantBeNull" : MessageLookupByLibrary.simpleMessage("username can not be empty"),
    "versionDescription" : MessageLookupByLibrary.simpleMessage("Version Description"),
    "waitAMoment" : MessageLookupByLibrary.simpleMessage("please wait for a moment..."),
    "weatherGetWrong" : MessageLookupByLibrary.simpleMessage("failed to get the weather，please try again"),
    "weatherGetting" : MessageLookupByLibrary.simpleMessage("the weather is inquiring..."),
    "weatherSuccess" : MessageLookupByLibrary.simpleMessage("the weather is successful"),
    "welcomeWord" : MessageLookupByLibrary.simpleMessage("Hello! "),
    "work" : MessageLookupByLibrary.simpleMessage("Work"),
    "writeAtLeastOneTaskItem" : MessageLookupByLibrary.simpleMessage("Please write at least one task."),
    "writeYourContactInfo" : MessageLookupByLibrary.simpleMessage("whether to leave your contact information"),
    "writeYourFeedback" : MessageLookupByLibrary.simpleMessage("write your feedback ")
  };
}
