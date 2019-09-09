import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
    this.isForce = false,
    this.backgroundColor,
    this.updateInfoColor,
  });

  @override
  State<StatefulWidget> createState() => new UpdateDialogState();
}

class UpdateDialogState extends State<UpdateDialog> {
  int _downloadProgress = 0;
  CancelToken token;
  UploadingFlag uploadingFlag = UploadingFlag.idle;

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.backgroundColor ?? Theme.of(context).primaryColor;
    final size = MediaQuery.of(context).size;
    final isVertical = size.height > size.width;
    final marginLeft = isVertical ? size.width / 8 : size.width / 4;
    final marginTop = isVertical ? size.height / 4 : size.height / 8;

    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        margin:
            EdgeInsets.fromLTRB(marginLeft, marginTop, marginLeft, marginTop),
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
                      DemoLocalizations.of(context).newVersionIsComing,
                      style: TextStyle(
                          color: widget.updateInfoColor ?? Colors.white,
                          fontSize: 20),
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
                          style: TextStyle(
                              color: widget.updateInfoColor ?? Colors.white),
                        ),
                      ),
                    ))),
            getLoadingWidget(),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: widget.updateInfoColor ?? Colors.white,
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
                                  DemoLocalizations.of(context).cancel,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16),
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
                            if (uploadingFlag == UploadingFlag.uploading)
                              return;
                            uploadingFlag = UploadingFlag.uploading;
                            if (mounted) setState(() {});
                            if (Platform.isAndroid) {
                              _androidUpdate();
                            } else if (Platform.isIOS) {
                              _iosUpdate();
                            }
                          },
                          child: Text(
                            DemoLocalizations.of(context).update,
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
    try {
      await ApiStrategy.getInstance().client.download(
          widget.updateUrl, apkPath + "todo-list.apk", cancelToken: token,
          onReceiveProgress: (int count, int total) {
        if (mounted) {
          setState(() {
            _downloadProgress = ((count / total) * 100).toInt();
            if (_downloadProgress == 100) {
              if (mounted) {
                setState(() {
                  uploadingFlag = UploadingFlag.uploaded;
                });
              }
              debugPrint("读取的目录:$apkPath");
              try {
                OpenFile.open(apkPath + "todo-list.apk");
              } catch (e) {}
              Navigator.of(context).pop();
            }
          });
        }
      },options: Options(connectTimeout: 15*1000,receiveTimeout: 360*1000),);
    } catch (e) {
      if (mounted) {
        setState(() {
          uploadingFlag = UploadingFlag.uploadingFailed;
        });
      }
    }
  }

  Widget getLoadingWidget() {
    if (_downloadProgress != 0 && uploadingFlag == UploadingFlag.uploading) {
      return Expanded(
        child: Container(
          child: LinearProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            backgroundColor: Colors.grey[300],
            value: _downloadProgress / 100,
          ),
        ),
        flex: 1,
      );
    }
    if (uploadingFlag == UploadingFlag.uploading && _downloadProgress == 0) {
      return Container(
        alignment: Alignment.center,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(widget.updateInfoColor ?? Colors.white),
            ),
            SizedBox(
              width: 5,
            ),
            Material(
              child: Text(
                DemoLocalizations.of(context).waiting,
                style: TextStyle(color: widget.updateInfoColor ?? Colors.white),
              ),
              color: Colors.transparent,
            )
          ],
        ),
      );
    }
    if (uploadingFlag == UploadingFlag.uploadingFailed) {
      return Container(
          alignment: Alignment.center,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.clear,
                color: Colors.redAccent,
              ),
              SizedBox(
                width: 5,
              ),
              Material(
                child: Text(
                  DemoLocalizations.of(context).timeOut,
                  style:
                      TextStyle(color: widget.updateInfoColor ?? Colors.white),
                ),
                color: Colors.transparent,
              )
            ],
          ));
    }
    return Container();
  }

  void _iosUpdate() {
    launch(widget.updateUrl);
  }

  @override
  void initState() {
    token = new CancelToken();
    super.initState();
  }

  @override
  void dispose() {
    if (!token.isCancelled) token?.cancel();
    super.dispose();
    debugPrint("升级销毁");
  }
}

enum UploadingFlag { uploading, idle, uploaded, uploadingFailed }
