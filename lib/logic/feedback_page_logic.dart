import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/all_model.dart';
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
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

  void onFeedbackSubmit(FeedbackWallPageModel feedbackWallPageModel) async {
    final context = _model.context;

    ///限制建议内容不能为空，长度不能小于10
    if (_model.feedbackContent.isEmpty) {
      showWrongDialog(
          context, IntlLocalizations.of(context).feedbackCantBeNull);
      return;
    } else if (_model.feedbackContent.length < 10) {
      showWrongDialog(
          context, IntlLocalizations.of(context).feedbackIsTooLittle);
      return;
    }

    ///限制：需要选择评价表情
    if (_model.currentSelectSvg == -99) {
      showWrongDialog(context, IntlLocalizations.of(context).feedbackNeedEmoji);
      return;
    }

    ///防止过多提交
    bool canSubmitSuggest = await canSubmit();
    if(!canSubmitSuggest){
      showWrongDialog(context, IntlLocalizations.of(context).feedbackFrequently);
      return;
    }

    final userName = await SharedUtil.instance.getString(Keys.currentUserName) ?? IntlLocalizations.of(context).noName;
    final suggestion = _model.feedbackContent;
    final avatarPath = await SharedUtil.instance.getString(Keys.localAvatarPath) ?? "";
//    String fileName = avatarPath
//        .substring(avatarPath.lastIndexOf("/") + 1, avatarPath.length)
//        .replaceAll(" ", "");
//    String transFormName = Uri.encodeFull(fileName).replaceAll("%", "");
    ///由于写后端的时候忘记添加表情的字段，现在把它放这里面
    final connectWay = "${(_model.contactWay ?? "") + "<emoji>${_model.currentSelectSvg + 1}<emoji>"}";
    final account = await SharedUtil.instance.getString(Keys.account) ?? "default";

    showDialog(
        context: context,
        builder: (ctx) {
          return NetLoadingWidget(
            onRequest: () async {
              _model.loadingController.setFlag(LoadingFlag.loading);
              ApiService.instance.postSuggestionWithAvatar(
                params: FormData.fromMap({
                  "avatar": await MultipartFile.fromFile(avatarPath),
                  "account": account,
                  "suggestion": suggestion,
                  "connectWay": connectWay,
                  "userName": userName,
                }),
                success: (bean){
                  SharedUtil.instance.saveString(Keys.lastSuggestTime, DateTime.now().toIso8601String());
                  _model.loadingController.setFlag(LoadingFlag.success);
                  feedbackWallPageModel.logic.getSuggestions();
                },
                failed: (bean){
                  _model.loadingController.setFlag(LoadingFlag.error);
                },
                error: (msg){
                  _model.loadingController.setFlag(LoadingFlag.error);
                },
                token: _model.cancelToken,
              );
            },
            loadingController: _model.loadingController,
            successWidget: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      IntlLocalizations.of(context).submitSuccess,
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.only(left: 10,right: 10),
                      child: Text(
                        IntlLocalizations.of(context).thanksForFeedback,
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
                  child: Text(IntlLocalizations.of(context).ok),
                )
              ],
            ),
          );
        },);
  }


  ///通过判断本机时间，8小时内只能提交一次建议，为了之后的意见展示墙出现过多内容
  Future<bool> canSubmit() async{
    String lastTime = await SharedUtil.instance.getString(Keys.lastSuggestTime) ?? "";
    if(lastTime.isEmpty){
      return true;
    } else {
      DateTime now = DateTime.now();
      DateTime lastSuggestTime = DateTime.parse(lastTime);
      Duration diff = now.difference(lastSuggestTime);
      if(diff.inHours.abs() < 8){
        return false;
      } else {
        SharedUtil.instance.saveString(Keys.lastSuggestTime, now.toIso8601String());
        return true;
      }
    }
  }

}
