import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/common_bean.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/utils/full_screen_dialog_util.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/widgets/net_loading_widget.dart';

class FeedbackPageLogic {
  final FeedbackPageModel _model;

  FeedbackPageLogic(this._model);

  void onSvgTap(int index) {
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

    _model.loadingController.setFlag(LoadingFlag.loading);
    showDialog(
        context: context,
        builder: (ctx) {
          return GestureDetector(
            onTap: (){
              _model.loadingController.setFlag(LoadingFlag.success);
            },
            child: NetLoadingWidget(
              loadingController: _model.loadingController,
              successWidget: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        DemoLocalizations.of(context).submitSuccess,
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        margin: EdgeInsets.only(left: 10,right: 10),
                        child: Text(
                          DemoLocalizations.of(context).thanksForFeedback,
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                  FlatButton(
                    color: Theme.of(context).primaryColor,
                    highlightColor: Theme.of(context).primaryColorLight,
                    colorBrightness: Brightness.dark,
                    splashColor: Theme.of(context).primaryColorDark,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Text(DemoLocalizations.of(context).ok),
                  )
                ],
              ),
            ),
          );
        });
    final account =
        await SharedUtil.instance.getString(Keys.account) ?? "default";
//    ApiService.instance.postSuggestion({
//      "account": account,
//      "suggestion": _model.feedbackContent,
//      "connectWay": _model.contactWay ?? "",
//    }, (CommonBean bean) {
//      _model.loadingController.setFlag(LoadingFlag.success);
//    }, (CommonBean bean) {
//      _model.loadingController.setFlag(LoadingFlag.error);
//    }, (error) {
//      _model.loadingController.setFlag(LoadingFlag.error);
//    }, _model.cancelToken);
  }
}
