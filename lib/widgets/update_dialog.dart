import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list/config/api_strategy.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/utils/file_util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_file/open_file.dart';

class UpdateDialog extends StatefulWidget {
  final String version;
  final String updateInfo;
  final String updateUrl;
  final bool isForce;
  final Color backgroundColor;
  final Color updateInfoColor;

  UpdateDialog({
    this.version = "1.0.0",
    this.updateInfo = "",
    this.updateUrl = "",
    this.isForce = false, this.backgroundColor, this.updateInfoColor,
  });

  @override
  State<StatefulWidget> createState() => new UpdateDialogState();
}

class UpdateDialogState extends State<UpdateDialog> {
  int _downloadProgress = 0;
  CancelToken token;

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.backgroundColor ?? Theme
        .of(context)
        .primaryColor;
    final size = MediaQuery
        .of(context)
        .size;
    final isVertical = size.height > size.width;
    final marginLeft = isVertical ? size.width / 8 : size.width / 4;
    final marginTop = isVertical ? size.height / 4 : size.height / 8;


    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        margin: EdgeInsets.fromLTRB(
            marginLeft, marginTop, marginLeft, marginTop),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          color: bgColor,
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                  margin: EdgeInsets.fromLTRB(5, 30, 5, 5),
                  child: Material(
                    child: Text(
                      DemoLocalizations
                          .of(context)
                          .newVersionIsComing,
                      style: TextStyle(color:widget.updateInfoColor ?? Colors.white, fontSize: 20),
                    ),
                    color: Colors.transparent,
                  )),
            ),
            Expanded(
                flex: 5,
                child: Container(
                    margin: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Material(
                      color: Colors.transparent,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          widget.updateInfo ?? "",
                          style: TextStyle(color: widget.updateInfoColor ?? Colors.white),
                        ),
                      ),
                    ))),
            _downloadProgress != 0
                ? Expanded(
              child: Container(
                child: LinearProgressIndicator(
                  valueColor:
                  new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColorLight),
                  backgroundColor: Colors.grey[300],
                  value: _downloadProgress / 100, //精确模式，进度20%
                ),
              ),
              flex: 1,
            )
                : SizedBox(),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: Colors.white,
                ),
                child: Row(
                  children: <Widget>[
                    !widget.isForce
                        ? Expanded(
                      flex: 1,
                      child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            DemoLocalizations
                                .of(context)
                                .cancel,
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          )),
                    )
                        : SizedBox(),
                    !widget.isForce
                        ? Container(
                      width: 1,
                      color: Colors.grey[100],
                    )
                        : SizedBox(),
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                          onPressed: () async {
                            if (Platform.isAndroid) {
                              _androidUpdate();
                            } else if (Platform.isIOS) {
                              _iosUpdate();
                            }
                          },
                          child: Text(
                            DemoLocalizations
                                .of(context)
                                .update,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _androidUpdate() async {
    final apkPath = await FileUtil.getInstance().getSavePath("/Download/");
    ApiStrategy
        .getInstance()
        .client
        .download(widget.updateUrl, apkPath + "todo-list.apk",
        cancelToken: token, onReceiveProgress: (int count, int total) {
          setState(() {
            _downloadProgress = ((count / total) * 100).toInt();
            if (_downloadProgress == 100) {
              debugPrint("读取的目录:${apkPath}");
              try {
                OpenFile.open(apkPath + "todo-list.apk");
              } catch (e) {}
              Navigator.of(context).pop();
            }
          });
        });
  }

  void _iosUpdate() {
    launch(widget.updateUrl);
  }


  @override
  void initState() {
    super.initState();
    token = new CancelToken();
  }

  @override
  void dispose() {
    super.dispose();
    token?.cancel();
    debugPrint("升级销毁");
  }
}
