![image](https://user-images.githubusercontent.com/30992818/62599278-65d31300-b91e-11e9-96e2-f8a26eadeea2.png)


![image](https://user-images.githubusercontent.com/30992818/62850471-84b61880-bd15-11e9-80d7-e2ed87aee4fe.png)

Language:[简体中文](https://github.com/asjqkkkk/todo-list-app/blob/master/README_ZH.md)|[English](https://github.com/asjqkkkk/todo-list-app/blob/master/README.md)

[![support](https://img.shields.io/badge/platform-flutter%7Cdart%20vm-ff69b4.svg?style=flat-square)](https://github.com/asjqkkkk/todo-list-app)
[![GitHub license](https://img.shields.io/github/license/asjqkkkk/todo-list-app)](https://github.com/asjqkkkk/todo-list-app/blob/master/LICENSE)
[![Codemagic build status](https://api.codemagic.io/apps/5d3c43723764bf796ed724d4/5d3c43723764bf796ed724d3/status_badge.svg)](https://codemagic.io/apps/5d3c43723764bf796ed724d4/5d3c43723764bf796ed724d3/latest_build)



# 介绍

[灵感来源](https://dribbble.com/shots/3812962-iPhone-X-Todo-Concept)

> “一日清单”是一个小巧、简洁而又漂亮的app，它可以帮你随手记录日常的各项计划,如果你恰好有写任务计划的习惯，那么它一定非常适合你。

下面，针对使用者和开发者，我将来分别介绍一次

## 面向使用者的介绍


### 丰富的主题选择


app中，可以在主题切换界面选择各种主题颜色进行切换，app自带六个默认主题，这些都是我经过多次尝试所调选出来的颜色搭配。同时你也可以选择自定义主题颜色。

![image](https://user-images.githubusercontent.com/30992818/62598772-0294b100-b91d-11e9-9630-9315147e6452.png)
![image](https://user-images.githubusercontent.com/30992818/62598773-0294b100-b91d-11e9-981d-71957c6d2c50.png)


### 丰富的任务图标

在app中，每项任务都会带有一个图标，而app提供了所有 Flutter 自带的 **Material design** 风格的图标，这些图标，你可以进行任意颜色的自定义

![image](https://user-images.githubusercontent.com/30992818/62598774-032d4780-b91d-11e9-8dca-32c826c4ab9d.png)
![image](https://user-images.githubusercontent.com/30992818/62598775-032d4780-b91d-11e9-976f-4b6aaf55e60e.png)


### 多样的自定义组合

在app中，有多项其他的操作是你可以进行自定义的

比如说主页测滑栏的头部展示内容，当然，还有一些其他的操作，就由你去自行体验了

![image](https://user-images.githubusercontent.com/30992818/62598778-03c5de00-b91d-11e9-84aa-697d94f313a9.png)
![image](https://user-images.githubusercontent.com/30992818/62598780-045e7480-b91d-11e9-91c9-1887f41e13d5.png)


### 完成列表

当你完成了一项任务后，这个任务就会从主页转移到完成列表页面，在这里你可以看到任务的一些额外信息

![image](https://user-images.githubusercontent.com/30992818/62598781-04f70b00-b91d-11e9-8f6f-868a886f3d21.png)

那么，对于使用者的介绍就到这里结束

下面就是为广大开发者们介绍的时间了！


## 面向开发者的介绍

> 如果你对于Flutter有着浓厚的兴趣而又迟迟没有行动，那么就不要犹豫了，快点上车吧！这个项目对于新手司机再适合不过了。

各位开发者们请扶好你们的秀发，下面就我来带领各位参观参观这个项目的内部构造


### 第三方库

项目中使用了一些非常优秀的第三方库，也特别感谢这些开发者们，让我的发量保持健康

下面就是这些控件的信息


控件 | 说明
---|---
[dio](https://pub.flutter-io.cn/packages/dio) | 网络请求
[shared_preferences](https://pub.flutter-io.cn/packages/shared_preferences) | 本地存储
[provider](https://pub.flutter-io.cn/packages/provider) | 状态管理
[test](https://pub.flutter-io.cn/packages/test) | 单元测试
[carousel_slider](https://pub.flutter-io.cn/packages/carousel_slider) | 滑动控件
[circle_list](https://pub.flutter-io.cn/packages/circle_list) | 环形列表
[intl](https://pub.flutter-io.cn/packages/intl) | intl语言包
[sqflite](https://pub.flutter-io.cn/packages/sqflite) | 本地数据库
[flutter_colorpicker](https://pub.flutter-io.cn/packages/flutter_colorpicker) | 取色框
[cached_network_image](https://pub.flutter-io.cn/packages/cached_network_image) | 图片缓存
[image_picker](https://pub.flutter-io.cn/packages/image_picker) | 图片选取
[permission_handler](https://pub.flutter-io.cn/packages/permission_handler) | 权限申请
[path_provider](https://pub.flutter-io.cn/packages/path_provider) | 路径获取
[image_crop](https://pub.flutter-io.cn/packages/image_crop) | 图片裁剪
[flutter_svg](https://pub.flutter-io.cn/packages/flutter_svg) | svg解析
[package_info](https://pub.flutter-io.cn/packages/package_info) | 获取package信息
[flutter_webview_plugin](https://pub.flutter-io.cn/packages/flutter_webview_plugin) | 网页
[pull_to_refresh](https://pub.flutter-io.cn/packages/pull_to_refresh) | 上拉加载
[photo_view](https://pub.flutter-io.cn/packages/photo_view) | 图片展示
[url_launcher](https://pub.flutter-io.cn/packages/url_launcher) | 可以用来打开应用商店
[open_file](https://pub.flutter-io.cn/packages/open_file) | 打开文件，android更新下载安装包用



### 项目架构

项目使用的状态管理框架是 <code>Provider</code> ,而整个项目的架构如下

![image](https://user-images.githubusercontent.com/30992818/62598782-04f70b00-b91d-11e9-9b57-c9da7bb4b5bc.png)

- View 层用于展示布局，基本上就是各种被 **ChangeNotifierProvider** 包裹的 **StatelessWidget** 页面
- Model层用于处理数据，是继承了 **ChangeNotifier** 的各种Model类
- Logic 层不会保存任何数据，只进行逻辑操作


看起来是不是和 Android 中的 **MVP** 模式很像呢？其实都差不多的，只是名字略有不同罢了，你也可以就把上面的模式当作是 MVP 模式。

Flutter 可以说是特别适合这种架构模式的，因为视图跟随数据而变化，你基本上不用去关心View，只要去对数据进行操作就好了。

### 目录结构

项目目录结构如下：

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

先说明一下除了 **lib** 外的其他目录：

目录 | 说明
---|---
images | 用于存放各种图片
local_json | 我将Flutter的Icon信息封装成了Json文件存放在这个目录中
res | 存放“国际化”插件生成的语言文件
svgs | 存放svg格式的图片

然后是 **lib** 目录

![image](https://user-images.githubusercontent.com/30992818/62598783-058fa180-b91d-11e9-8e8c-713aa82c341d.png)



目录 | 说明
---|---
config | 存放各种配置类，比如Dio请求封装类等
database | 存放数据库操作相关类
i10n | 存放国际化相关操作的类
items | 存放部分List列表的Item类
json | 各种网络请求、数据库等相关的json文件
logic | 上面提到的，Locig层的目录
model | Model层的目录
pages | 存放各个页面，是View层的目录
utils | 封装好的各️工具类，比如文件操作等
widgets | 封装好的各种Widget

# ToDo

- [x] 图标搜索功能
- [ ] 自定义任务详情页字体大小
- [ ] 意见反馈展示墙
- [ ] 行业相关新闻浏览界面
- [ ] 是否展示开场动画

# 附录

## app下载

Android 下载地址：

![image](https://user-images.githubusercontent.com/30992818/62599044-c150d100-b91d-11e9-8e63-e9c67dd32995.png)

Ios 下载地址：
  目前尚未购买一年99$的ios开发者账号，所以暂时没有。
  
  
    注意：目前项目运行环境是flutter 1.7.8 hotfix的版本，改版本相对以往而言多了一些破坏性修复，
    如果你的flutter版本比当前版本低，项目中依赖的某些第三方库将无法运行，到时候请降低他们的版本
    
    下面是在1.5.4版本下需要修改的第三方库
    
    -   flutter_svg: ^0.12.4+2
    -   image_crop: ^0.2.1
    -   photo_view: ^0.3.3




如果你觉得这个app不错，或者这个项目有帮助到你，不妨给这个项目一个Star吧。项目后面也会持续保持更新和维护！
