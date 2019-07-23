import 'package:flutter/material.dart';
import 'package:todo_list/i10n/localization_intl.dart';

import 'loading_widget.dart';

class NetLoadingWidget extends StatefulWidget {

  final LoadingController loadingController;
  final Widget successWidget;

  const NetLoadingWidget({Key key, this.loadingController, this.successWidget,}) : super(key: key);

  @override
  _NetLoadingWidgetState createState() => _NetLoadingWidgetState();
}

class _NetLoadingWidgetState extends State<NetLoadingWidget> {


  LoadingFlag loadingFlag = LoadingFlag.loading;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;


    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.3),
      body: Container(
        width: size.width,
        height: size.height,
        alignment: Alignment.center,
        child: Container(
          width: size.width / 3 * 2,
          height: size.height / 2,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: LoadingWidget(
              flag: loadingFlag,
              loadingText: getLoadingText(),
              successWidget: widget.successWidget,
            ),
          ),
        ),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    widget?.loadingController?._setState(this);
  }

  String getLoadingText() {
    switch (loadingFlag) {
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


//这里面的state没有去执行dispose，不知道会不会内存泄漏
class LoadingController{


  _NetLoadingWidgetState _state;

  void setFlag(LoadingFlag loadingFlag){
    _state?.loadingFlag = loadingFlag;
    if(_state.mounted){
      _state?.setState((){});
    }
    print("设置:${_state?.loadingFlag}");
  }


  void _setState(_NetLoadingWidgetState state){
    if(this?._state == null){
      this?._state = state;
    } else {
      this._state = null;
      this._state = state;
    }
  }


}