import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/common_bean.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/utils/full_screen_dialog_util.dart';
import 'package:todo_list/utils/shared_util.dart';

class FeedbackPageLogic{

  final FeedbackPageModel _model;

  FeedbackPageLogic(this._model);

  void onSvgTap(int index){
    if (_model.currentSelectSvg == index) {
      _model.currentSelectSvg = -99;
    } else {
      _model.currentSelectSvg = index;
    }
    _model.refresh();
  }


  void showWrongDialog(BuildContext context, String description) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: Text(description),
          );
        });
  }

  Widget getSvg(String svgPath) {
    return SvgPicture.asset(
      svgPath,
      width: 50,
      height: 50,
    );
  }

  void onFeedbackSubmit() async {
    final context = _model.context;
    final size = MediaQuery.of(context).size;
    if (_model.feedbackContent.isEmpty) {
      showWrongDialog(
          context, DemoLocalizations.of(context).feedbackCantBeNull);
      return;
    } else if (_model.feedbackContent.length < 10) {
      showWrongDialog(
          context, DemoLocalizations.of(context).feedbackIsTooLittle);
      return;
    }
    if (_model.currentSelectSvg == -99) {
      showWrongDialog(context, DemoLocalizations.of(context).feedbackNeedEmoji);
      return;
    }
    _model.loadingFlag = LoadingFlag.loading;
    _model.refresh();
    showDialog(
        context: context,
        builder: (ctx) {



          return GestureDetector(
            onTap: (){
              _model.loadingFlag = LoadingFlag.success;
              _model.refresh();
              print("点击");
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(size.width / 6, size.height / 4,
                  size.width / 6, size.height / 4),
              child: Card(
                child: LoadingWidget(
                  flag: _model.loadingFlag,
                  loadingText: getLoadingText(),
                  successWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(DemoLocalizations.of(context).submitSuccess),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Text(DemoLocalizations.of(context).ok),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });

//    final account =
//        await SharedUtil.instance.getString(Keys.account) ?? "default";
//    ApiService.instance.postSuggestion({
//      "account": account,
//      "suggestion": _model.feedbackContent,
//      "connectWay": _model.contactWay ?? "",
//    }, (CommonBean bean) {
//      _model.loadingFlag = LoadingFlag.success;
//      _model.refresh();
//    }, (CommonBean bean) {
//      _model.loadingFlag = LoadingFlag.error;
//      _model.refresh();
//    }, (error) {
//      _model.loadingFlag = LoadingFlag.error;
//      _model.refresh();
//    }, _model.cancelToken);
  }

  String getLoadingText() {
    final context = _model.context;
    switch (_model.loadingFlag) {
      case LoadingFlag.loading:
        return DemoLocalizations.of(context).waitAMoment;
        break;
      case LoadingFlag.error:
        return DemoLocalizations.of(context).submitAgain;
        break;
      case LoadingFlag.success:
        return DemoLocalizations.of(context).submitSuccess;
        break;
      case LoadingFlag.empty:
        return "";
        break;
      case LoadingFlag.idle:
        return "";
        break;
    }
  }

}