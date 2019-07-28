import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:package_info/package_info.dart';
import 'package:todo_list/json/update_info_bean.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/pages/webview_page.dart';
import 'package:todo_list/widgets/loading_widget.dart';
import 'package:todo_list/widgets/net_loading_widget.dart';
import 'package:todo_list/widgets/update_dialog.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  List<String> descriptions = [
    "当前版本：1.0.0",
    "后续也许还会增加一个网络版的，到时候可能会有登陆操作，那就涉及一个账号系统了，想想还要写后端，头发君坐立难安~",
    "这个app功能并不多，但是还是蛮漂亮的一个app，套用一句夸张的话——漂亮的不像app(👏👏😳)",
    "\"一日清单\"可以用来帮你记录简单的ToDo-List，但是对于开发者来说，它最大的目的是帮助开发者去了解Flutter、学习Flutter",
    "拉人入坑Flutter,也是我喜闻乐见的一件事",
    "如果你觉得这个项目不错，不妨去Github上为项目点个Star🌟",
    "Github地址:https://github.com/asjqkkkk",
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final globalModel = Provider.of<GlobalModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          DemoLocalizations.of(context).aboutApp,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        backgroundColor: globalModel.logic.getBgInDark(),
        iconTheme: IconThemeData(color: Colors.grey),
        elevation: 0.0,
      ),
      body: Container(
        color: globalModel.logic.getBgInDark(),
        child: Container(
          margin: EdgeInsets.all(20),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
              overScroll.disallowGlow();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Container(
                              width: 70,
                              height: 70,
                              margin: EdgeInsets.all(10),
                              child: Image.asset(
                                "images/icon_2.png",
                                fit: BoxFit.contain,
                              ))),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 50, top: 2),
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Text(
                                DemoLocalizations.of(context).appName,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              child: FutureBuilder(
                                  future: PackageInfo.fromPlatform(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      PackageInfo packageInfo = snapshot.data;
                                      return Text(
                                        packageInfo.version,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Theme.of(context)
                                                        .primaryColor ==
                                                    Color(0xff212121)
                                                ? Colors.white
                                                : Color.fromRGBO(
                                                    141, 141, 141, 1.0)),
                                      );
                                    } else
                                      return Container();
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Platform.isAndroid
                        ? Container(
                            child: IconButton(
                              icon: Icon(
                                Icons.cloud_upload,
                              ),
                              onPressed: () => checkUpdate(globalModel),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 20, bottom: 0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Container(
                        margin: EdgeInsets.only(left: 20, top: 30),
                        child: NotificationListener<
                            OverscrollIndicatorNotification>(
                          onNotification: (overScroll) {
                            overScroll.disallowGlow();
                          },
                          child: ListView(
                              children: List.generate(descriptions.length + 1,
                                  (index) {
                            if (index == 0) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: Text(
                                  DemoLocalizations.of(context)
                                      .versionDescription,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            } else {
                              final data = descriptions[index - 1];

                              return Container(
                                margin: EdgeInsets.only(right: 14),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 7),
                                      width: 7,
                                      height: 7,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            Color.fromRGBO(141, 141, 141, 1.0),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(child: getDescriptionItem(data)),
                                  ],
                                ),
                              );
                            }
                          })),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getDescriptionItem(String data) {
    if (data.contains("http")) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx) {
            return WebViewPage(
              data.replaceAll("Github地址:", ""),
              title: "作者的github",
            );
          }));
        },
        child: Text(
          data,
          style: TextStyle(color: Colors.blueAccent),
        ),
      );
    }
    return Text(data);
  }

  void checkUpdate(GlobalModel globalModel) {
    final loadingController = globalModel.loadingController;

    showDialog(
        context: context,
        builder: (ctx) {
          CancelToken cancelToken = CancelToken();
          return NetLoadingWidget(
            loadingController: loadingController,
            successText: DemoLocalizations.of(context).noUpdate,
            onSuccess: () {
              Navigator.pop(context);
            },
            onRequest: () {
              ApiService.instance.checkUpdate(
                (UpdateInfoBean updateInfo) async {
                  final packageInfo = await PackageInfo.fromPlatform();
                  bool needUpdate = UpdateInfoBean.needUpdate(
                      packageInfo.version, updateInfo.appVersion);
                  if (needUpdate) {
                    Navigator.of(context).pop();
                    showDialog(
                        context: context,
                        builder: (ctx2) {
                          return UpdateDialog(
                            version: updateInfo.appVersion,
                            updateUrl: updateInfo.downloadUrl,
                            updateInfo: updateInfo.updateInfo,
                            updateInfoColor: globalModel.logic.getWhiteInDark(),
                            backgroundColor:
                                globalModel.logic.getPrimaryGreyInDark(context),
                          );
                        });
                  }
                  loadingController.setFlag(LoadingFlag.success);
                },
                (msg) {
                  loadingController.setFlag(LoadingFlag.error);
                },
                {
                  "language": globalModel.currentLocale.languageCode,
                  "appId": "001"
                },
                cancelToken,
              );
            },
            cancelToken: cancelToken,
          );
        });
  }
}
