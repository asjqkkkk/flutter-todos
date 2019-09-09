import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:todo_list/widgets/loading_widget.dart';
import 'dart:io';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  WebViewPage(this.url, {this.title});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  FlutterWebviewPlugin flutterWebviewPlugin;
  LoadingFlag loadingFlag = LoadingFlag.loading;

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin = new FlutterWebviewPlugin();
  }

  @override
  void dispose() {
    super.dispose();
    flutterWebviewPlugin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    flutterWebviewPlugin.onProgressChanged.listen((value) {
      if (value == 1) {
        setState(() {
          loadingFlag = LoadingFlag.success;
        });
        flutterWebviewPlugin.show();
      }
    });
    flutterWebviewPlugin.onHttpError.listen((error) {
      setState(() {
        loadingFlag = LoadingFlag.error;
      });
    });
    return WillPopScope(
      onWillPop: () {
        flutterWebviewPlugin.close().then((a) {
          Navigator.of(context).pop();
        });
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title ?? widget.url,
            overflow: TextOverflow.ellipsis,
          ),
          leading: IconButton(
              icon: Platform.isIOS
                  ? Icon(Icons.arrow_back_ios)
                  : Icon(Icons.arrow_back),
              onPressed: () {
                flutterWebviewPlugin.close().then((a) {
                  Navigator.of(context).pop();
                });
              }),
        ),
        body: WebviewScaffold(
          url: widget.url,
          hidden: true,
          initialChild: Center(
            child: Container(
              alignment: Alignment.center,
              child: LoadingWidget(
                flag: loadingFlag,
                errorCallBack: () {
                  flutterWebviewPlugin.reload();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
