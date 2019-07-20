import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:package_info/package_info.dart';
import 'package:todo_list/pages/webview_page.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  List<String> descriptions = [
    "当前版本：1.0.0",
    "后续也许还会增加一个网络版的，到时候可能会有登陆操作，那就涉及一个账号系统了，想想还要写后端，头发君坐立难安~",
    "这个app功能并不多，但是还是蛮漂亮的一个app，套用一句夸张的话——漂亮的不像app(不要拍醒我!让我再做会儿梦!!!)",
    "\"一日清单\"可以用来帮你记录简单的ToDo-List，但是对于开发者来说，它最大的目的是帮助开发者去了解Flutter、学习Flutter",
    "拉人入坑Flutter,也是我喜闻乐见的一件事",
    "如果你觉得这个项目不错，不妨去Github上为项目点个赞",
    "Github地址:https://github.com/asjqkkkk",
    "又或者,奖励作者一点护发费",
    "护发费:",
    "当然,能感受到双份的快乐也是坠吼的!",
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(DemoLocalizations.of(context).aboutApp),
      ),
      body: Container(
        child: Container(
          margin: EdgeInsets.all(20),
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
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: Container(
                            width: 70,
                            height: 70,
                            margin: EdgeInsets.all(10),
                            child: Image.asset("images/icon.png"))),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 50,top: 2),
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
                                          color: Theme.of(context).primaryColor ==
                                              Color(0xff212121)
                                              ? Colors.white
                                              : Color.fromRGBO(141, 141, 141, 1.0)),
                                    );
                                  } else
                                    return Container();
                                }),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Container(
                      margin: EdgeInsets.only(left: 20, top: 30),
                      child: NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (overScroll) {
                          overScroll.disallowGlow();
                        },
                        child: ListView(
                            children:
                                List.generate(descriptions.length + 1, (index) {
                          if (index == 0) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Text(
                                DemoLocalizations.of(context).versionDescription,
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
                                      color: Color.fromRGBO(141, 141, 141, 1.0),
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
    );
  }

  Widget getDescriptionItem(String data) {
    if (data.contains("http")) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx) {
              return WebViewPage(
                data.replaceAll("Github地址:", ""), title: "作者的github",
              );
          }));
        },
        child: Text(
          data,
          style: TextStyle(color: Colors.blueAccent),
        ),
      );
    }
    if (data.contains("护发费:")) {
      return Image.asset("images/avatar.jpg");
    } else {
      return Text(data);
    }
  }
}
