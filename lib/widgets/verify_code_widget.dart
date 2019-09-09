import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/common_bean.dart';
import 'package:todo_list/model/global_model.dart';

class VerifyCodeWidget extends StatefulWidget {
  final String account;
  final bool isUserNameOk;
  final bool isEmailOk;

  const VerifyCodeWidget({
    Key key,
    this.account,
    this.isUserNameOk = true,
    this.isEmailOk = true,
  }) : super(key: key);

  @override
  _VerifyCodeWidgetState createState() => _VerifyCodeWidgetState();
}

class _VerifyCodeWidgetState extends State<VerifyCodeWidget> {
  String verifyTextShow;
  Color codeColor = Colors.green;
  Timer _timer;
  bool isGettingCode = false;
  CancelToken cancelToken = CancelToken();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    cancelToken?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);

    if (verifyTextShow == null) {
      verifyTextShow = DemoLocalizations.of(context).getVerifyCode;
    }
    return FlatButton(
      onPressed: () {
        if (isGettingCode) return;
        if (!widget.isEmailOk) {
          _showTextDialog(
              DemoLocalizations.of(context).checkYourEmail, context);
          return;
        }
        if (!widget.isUserNameOk) {
          _showTextDialog(
              DemoLocalizations.of(context).checkYourUserName, context);
          return;
        }
        setState(() {
          verifyTextShow = DemoLocalizations.of(context).waiting;
          codeColor = Colors.grey;
          isGettingCode = true;
        });
        ApiService.instance.getVerifyCode(
          params: {
            "account": widget.account,
            "why": "emailRegister",
            "language": globalModel.currentLanguageCode[0]
          },
          success: (CommonBean bean) {
            _timer?.cancel();
            int count = 30;
            Timer countdownTimer =
                new Timer.periodic(new Duration(seconds: 1), (Timer timer) {
              if (count > 0) {
                verifyTextShow = "$count s";
                codeColor = Colors.grey;
                setState(() {});
                count--;
              } else {
                timer.cancel();
                isGettingCode = false;
                verifyTextShow = DemoLocalizations.of(context).getVerifyCode;
                codeColor = Colors.green;
                setState(() {});
              }
            });
            _timer = countdownTimer;
          },
          failed: (CommonBean bean) {
            _showTextDialog(bean.description, context);
            setState(() {
              initialCodeData(context);
            });
          },
          error: (msg) {
            _showTextDialog(msg, context);
            setState(() {
              initialCodeData(context);
            });
          },
          token: cancelToken,
        );
      },
      child: new Text(
        verifyTextShow,
        style: TextStyle(color: codeColor),
      ),
    );
  }

  void initialCodeData(BuildContext context) {
    verifyTextShow = DemoLocalizations.of(context).getVerifyCode;
    codeColor = Colors.green;
    isGettingCode = false;
  }

  void _showTextDialog(String text, BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            content: Text(text),
          );
        });
  }
}
