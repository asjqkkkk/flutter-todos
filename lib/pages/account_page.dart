import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String avatarUrl;
  String userName;
  String emailAccount;

  bool isExisting = false;

  @override
  void initState() {
    super.initState();
    Future.wait([getAvatarUrl(), getUserName(), getEmailAccount()]).then((v) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final primaryColorLight = Theme.of(context).primaryColorLight;
    final primaryColorDark = Theme.of(context).primaryColorDark;
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () {
        setState(() {
          isExisting = true;
        });
        return Future.value(true);
      },
      child: Stack(
        children: <Widget>[
          Container(
            width: size.width,
            height: size.height,
            child: SvgPicture.asset(
              "svgs/bg.svg",
              fit: BoxFit.cover,
            ),
          ),
          isExisting
              ? Container()
              : BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Container(
                    width: size.width,
                    height: size.height,
                    color: primaryColor.withOpacity(0.1),
                  ),
                ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(DemoLocalizations.of(context).myAccount),
              backgroundColor: Colors.transparent,
            ),
            body: Container(
              margin: EdgeInsets.only(top: 40),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: getAvatar(primaryColor),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      userName ?? "null",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
                    ),
                    Text(
                      emailAccount ?? "null",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FlatButton(
                      color: primaryColor,
                      highlightColor: primaryColorLight,
                      colorBrightness: Brightness.dark,
                      splashColor: Colors.grey,
                      child: Text(DemoLocalizations.of(context).logout),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () {
                        SharedUtil.instance.saveString(Keys.account, "default").then((v){
                          SharedUtil.instance.saveBoolean(Keys.hasLogged, false);
                        });

                        Navigator.of(context).pushAndRemoveUntil(
                            new MaterialPageRoute(builder: (context) {
                          return ProviderConfig.getInstance()
                              .getLoginPage(isFirst: true);
                        }), (router) => router == null);
                      },
                    ),
                    FlatButton(
                      color: primaryColor,
                      highlightColor: primaryColorLight,
                      colorBrightness: Brightness.dark,
                      splashColor: Colors.grey,
                      child: Text(DemoLocalizations.of(context).resetPassword),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () {
                        Navigator.of(context)
                            .push(new CupertinoPageRoute(builder: (ctx) {
                          return ProviderConfig.getInstance()
                              .getResetPasswordPage();
                        }));
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future getAvatarUrl() async {
    avatarUrl = await SharedUtil.instance.getString(Keys.localAvatarPath);
  }

  Future getUserName() async {
    userName = await SharedUtil.instance.getString(Keys.currentUserName);
  }

  Future getEmailAccount() async {
    emailAccount = await SharedUtil.instance.getString(Keys.account);
  }

  Widget getAvatar(Color color) {
    return avatarUrl != null
        ? Container(
            width: 100,
            height: 100,
            child: ClipRRect(
              child: Image.file(File(avatarUrl)),
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
          )
        : Container(
            width: 100,
            height: 100,
            child: ClipRRect(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(color),
              ),
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
          );
  }
}
