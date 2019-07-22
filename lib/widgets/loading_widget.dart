import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list/i10n/localization_intl.dart';

class LoadingWidget extends StatelessWidget {
  final Color progressColor;
  final Color textColor;
  final double textSize;
  final String loadingText;
  final String emptyText;
  final String errorText;
  final LoadingFlag flag;
  final VoidCallback errorCallBack;
  final double size;

  LoadingWidget(
      {this.progressColor,
      this.textColor,
      this.textSize,
      this.loadingText,
      this.flag = LoadingFlag.loading,
      this.errorCallBack,
      this.emptyText,
      this.errorText, this.size = 100});

  @override
  Widget build(BuildContext context) {

    final primaryColor = Theme.of(context).primaryColor;

    switch (flag) {
      case LoadingFlag.loading:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: size / 2,
                width: size / 2,
                child: CircularProgressIndicator(
                  strokeWidth: size / 10,
                  valueColor: AlwaysStoppedAnimation(
                      progressColor ?? primaryColor),
                ),
              ),
              SizedBox(
                height: size / 5,
              ),
              Text(
                loadingText ?? DemoLocalizations.of(context).loading,
                style: TextStyle(
                    fontSize: textSize ?? size / 5, color: textColor ?? primaryColor),
              )
            ],
          ),
        );
        break;
      case LoadingFlag.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                "svgs/loading_error.svg",
                color: progressColor ?? primaryColor,
                width: size,
                height: size,
                semanticsLabel: 'loading error',
              ),
              FlatButton(
                  onPressed: errorCallBack ?? (){},
                  child: Text(
                    "${errorText??""}" + DemoLocalizations.of(context).reLoading,
                    style: TextStyle(fontSize: textSize ?? size / 5, color: textColor ?? primaryColor),
                  )),
            ],
          ),
        );
        break;
      case LoadingFlag.success:
        return SizedBox();
        break;
      case LoadingFlag.empty:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                "svgs/empty_list.svg",
                color: progressColor ?? primaryColor,
                width: size,
                height: size,
                semanticsLabel: 'empty list',
              ),
              Text(
                emptyText ?? DemoLocalizations.of(context).loadingEmpty,
                style: TextStyle(
                    fontSize: textSize ?? size / 5, color:primaryColor),
              ),
            ],
          ),
        );
        break;

      case LoadingFlag.idle:
        return Center(
          child: SvgPicture.asset(
            "svgs/idle.svg",
            color: progressColor ?? primaryColor,
            width: size,
            height: size,
            semanticsLabel: 'idle',
          ),
        );
        break;
    }
  }
}

enum LoadingFlag { loading, error, success, empty ,idle}
