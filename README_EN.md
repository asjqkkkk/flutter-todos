![image](https://blog-pic-1256696029.cos.ap-guangzhou.myqcloud.com/todo_list/en/003.png)


![image](https://blog-pic-1256696029.cos.ap-guangzhou.myqcloud.com/todo_list/en/002.png)

Language:[简体中文](https://github.com/asjqkkkk/todo-list-app/blob/master/README.md)|[English](https://github.com/asjqkkkk/todo-list-app/blob/master/README_EN.md)

[![support](https://img.shields.io/badge/platform-flutter%7Cdart%20vm-ff69b4.svg?style=flat-square)](https://github.com/asjqkkkk/todo-list-app)
[![GitHub license](https://img.shields.io/github/license/asjqkkkk/todo-list-app)](https://github.com/asjqkkkk/todo-list-app/blob/master/LICENSE)
[![Codemagic build status](https://api.codemagic.io/apps/5d3c43723764bf796ed724d4/5d3c43723764bf796ed724d3/status_badge.svg)](https://codemagic.io/apps/5d3c43723764bf796ed724d4/5d3c43723764bf796ed724d3/latest_build)



# Introduction

[Source of inspiration](https://dribbble.com/shots/3812962-iPhone-X-Todo-Concept)


> “One Day list ”
is a small, simple and beautiful app，
It can help you keep track of your daily plans.
If you happen to have the habit of writing a mission plan, then it must be perfect for you.

For users and developers, I will introduce them separately

## Introduction to the user


### Colorful Themes


In the app, you can switch between the theme colors in the theme switching interface.The app comes with six default themes, which are the color combinations I've chosen over many attempts. You can also choose a custom theme color.

![image](https://blog-pic-1256696029.cos.ap-guangzhou.myqcloud.com/todo_list/en/004.png)
![image](https://blog-pic-1256696029.cos.ap-guangzhou.myqcloud.com/todo_list/en/005.png)


### Colorful Task Icons


In the app, each task comes with an icon, and the app provides all the **Material Design** style icons that Flutter comes with. You can customize with any color.

![image](https://blog-pic-1256696029.cos.ap-guangzhou.myqcloud.com/todo_list/en/006.png)
![image](https://blog-pic-1256696029.cos.ap-guangzhou.myqcloud.com/todo_list/en/007.png)


### Diverse Custom Combinations


In the app, there are a number of other operations that you can customize.

For example, the head of the homepage slide bar displays content, of course, there are some other operations that you will experience on your own.

![image](https://blog-pic-1256696029.cos.ap-guangzhou.myqcloud.com/todo_list/en/008.png)
![image](https://blog-pic-1256696029.cos.ap-guangzhou.myqcloud.com/todo_list/en/009.png)


### Done List


When you have completed a task, the task will be moved from the home page to the done list page, where you can see some additional information about the task.

![image](https://blog-pic-1256696029.cos.ap-guangzhou.myqcloud.com/todo_list/en/010.png)


Then, the introduction to the user ends here.

The following is the time for the majority of developers!

## Introduction to the Developer

> If you have a strong interest in Flutter and have been slow to act, then don't hesitate, hurry up! This project is perfect for getting started with Flutter.


Let me introduce you to the internal structure of this project.


### Packages


Some very good packages are used in the project, and I am especially grateful to these developers for keeping my hair healthy.


Below are the information about these packages.


package | explain
---|---
[dio](https://pub.flutter-io.cn/packages/dio) | network request
[shared_preferences](https://pub.flutter-io.cn/packages/shared_preferences) | local storage
[provider](https://pub.flutter-io.cn/packages/provider) | state management
[test](https://pub.flutter-io.cn/packages/test) | unit test
[carousel_slider](https://pub.flutter-io.cn/packages/carousel_slider) | slide control
[circle_list](https://pub.flutter-io.cn/packages/circle_list) | circle list
[intl](https://pub.flutter-io.cn/packages/intl) | change language 
[sqflite](https://pub.flutter-io.cn/packages/sqflite) | sqlite database
[flutter_colorpicker](https://pub.flutter-io.cn/packages/flutter_colorpicker) | color picker
[cached_network_image](https://pub.flutter-io.cn/packages/cached_network_image) | image cache
[image_picker](https://pub.flutter-io.cn/packages/image_picker) | image picker
[permission_handler](https://pub.flutter-io.cn/packages/permission_handler) | request for permissions
[path_provider](https://pub.flutter-io.cn/packages/path_provider) | get path
[image_crop](https://pub.flutter-io.cn/packages/image_crop) | image crop
[flutter_svg](https://pub.flutter-io.cn/packages/flutter_svg) | svg pictures
[package_info](https://pub.flutter-io.cn/packages/package_info) | get package info
[flutter_webview_plugin](https://pub.flutter-io.cn/packages/flutter_webview_plugin) | webview
[pull_to_refresh](https://pub.flutter-io.cn/packages/pull_to_refresh) | pull to refresh data
[photo_view](https://pub.flutter-io.cn/packages/photo_view) | show the picture
[url_launcher](https://pub.flutter-io.cn/packages/url_launcher) | open app store
[open_file](https://pub.flutter-io.cn/packages/open_file) | open apk file



### Project Structure

The state management framework used by the project is <code>Provider</code> , and the architecture of the entire project is as follows

![image](https://blog-pic-1256696029.cos.ap-guangzhou.myqcloud.com/todo_list/012.png)

- The View layer is used to display layouts and is a variety of **StatelessWidget** pages wrapped by **ChangeNotifierProvider**
- The Model layer is used to process data and is a variety of Model classes that inherit **ChangeNotifier**
- The Logic layer does not save any data, only logical operations



Does it look like the **MVP** pattern in Android? In fact, they are all similar, but the names are slightly different. You can also think of the above mode as the MVP mode.


Flutter is particularly well suited for this architectural model, because the view changes with the data, you basically don't have to care about the View, just go and operate on the data.

### Directory Structure

The project directory structure is as follows:

```
├── android
├── build
├── images
├── intl.sh
├── ios
├── lib
├── local_json
├── pubspec.lock
├── pubspec.yaml
├── res
├── svgs
├── test
└── todo_list.iml

```


Let me explain the other directories besides **lib**:

目录 | 说明
---|---
images | For storing various pictures
local_json | I encapsulate the Icon information of Flutter into a Json file and store it in this directory
res | Store the language files generated by the "intl" plugin
svgs | Store images in svg format

Then the lib directory


![image](https://blog-pic-1256696029.cos.ap-guangzhou.myqcloud.com/todo_list/013.png)



directory | explain
---|---
config | Store various configuration classes, such as Dio request encapsulation class, etc.
database | Store database operation related classes
i10n | Class for storing internationalized related operations
items | Item class that stores part of the List list
json | Various network requests, databases, etc. related json files
logic | Locig layer directory
model | Model layer directory
pages | Store each page, which is the directory of the View layer
utils | Packaged tools, such as file operations
widgets | custom widgets


# ToDo

- Login function, account system
- Cloud storage data



# Appendix

## app download

Android download link：

![image](https://blog-pic-1256696029.cos.ap-guangzhou.myqcloud.com/todo_list/014.png)

Ios download link：

  I haven't purchased an iOS developer account for 99$ a year
  
    Note: The current project running environment is the version of flutter 1.7.8 hotfix. The modified version has more destructive fixes than before.
    If your version of flutter is lower than the current version, some third-party libraries that are dependent on the project will not run. Please lower their version at that time.
    
    The following is a third-party library that needs to be modified under version 1.5.4.
    
    -   flutter_svg: ^0.12.4+2
    -   image_crop: ^0.2.1
    -   photo_view: ^0.3.3


If you think this app is good, or if this project helps you, give this project a Star. The project will continue to be updated and maintained afterwards.！

