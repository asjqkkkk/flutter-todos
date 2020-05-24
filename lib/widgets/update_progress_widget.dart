import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:todo_list/widgets/update_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:todo_list/utils/file_util.dart';
import 'package:todo_list/utils/overlay_util.dart';
import 'package:todo_list/config/api_strategy.dart';

class UpdateProgressWidget extends StatefulWidget {

  final String updateUrl;

  const UpdateProgressWidget({Key key,@required this.updateUrl}) : super(key: key);


  @override
  _UpdateProgressWidgetState createState() => _UpdateProgressWidgetState();
}

class _UpdateProgressWidgetState extends State<UpdateProgressWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  CancelToken token;
  int _downloadProgress = 0;
  bool isHide = false;
  UploadingFlag uploadingFlag = UploadingFlag.idle;


  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = new Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
    token = new CancelToken();
    if (Platform.isAndroid) {
      _androidUpdate();
    } else if (Platform.isIOS) {
      _iosUpdate();
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    if (!token.isCancelled) token?.cancel();
    debugPrint("UpdateProgressWidget销毁");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final widgetHeight = 120.0;

    return AnimatedBuilder(
        animation: _animation,
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              Container(
                width: size.width,
                height: widgetHeight,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Card(
                    margin: EdgeInsets.only(bottom: 0.0),
                    elevation: 10,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: FlatButton(
                              onPressed: () {
                                if (!isHide) {
                                  _controller.forward();
                                  isHide = true;
                                  setState(() {});
                                }
                              },
                              child: Text(
                                "隐藏",
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              )),
                          flex: 1,
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 10,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: LinearProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor),
                                backgroundColor: Colors.grey[300],
                                value: _downloadProgress / 100,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: FlatButton(
                              onPressed: () {
                                OverlayUtil.getInstance().hide();
                              },
                              child: Text(
                                "取消",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                ),
                              )),
                          flex: 1,
                        ),
                      ],
                    )),
              ),
              isHide
                  ? GestureDetector(
                      onTap: () {
                        debugPrint("点击显示");
                        if (isHide) {
                          _controller.reverse();
                          isHide = false;
                          setState(() {});
                        }
                      },
                      child: Card(
                          margin: EdgeInsets.all(0.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(40.0),
                                  bottomRight: Radius.circular(40.0))),
                          child: Container(
                            alignment: Alignment.center,
                            width: 80,
                            height: 50,
                            child: Text(
                              "显示",
                              style: TextStyle(color: Colors.green),
                            ),
                          )),
                    )
                  : Container()
            ],
          ),
        ),
        builder: (ctx, child) {
          return Transform.translate(
            offset: Offset(0, -_animation.value * widgetHeight),
            child: child,
          );
        });
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
                OverlayUtil.getInstance().hide();
                debugPrint("读取的目录:$apkPath");
                try {
                  OpenFile.open(apkPath + "todo-list.apk");
                } catch (e) {}
                Navigator.of(context).pop();
              }
            });
          }
        },options: Options(sendTimeout: 15*1000,receiveTimeout: 360*1000),);
    } catch (e) {
      if (mounted) {
        setState(() {
          uploadingFlag = UploadingFlag.uploadingFailed;
        });
      }
    }
  }

  void _iosUpdate() {
    launch(widget.updateUrl);
  }
}
