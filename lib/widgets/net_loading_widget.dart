import 'package:flutter/material.dart';
import 'package:todo_list/i10n/localization_intl.dart';

import 'loading_widget.dart';

class NetLoadingWidget extends StatefulWidget {

  final LoadingController loadingController;

  const NetLoadingWidget({Key key, this.loadingController,}) : super(key: key);

  @override
  _NetLoadingWidgetState createState() => _NetLoadingWidgetState();
}

class _NetLoadingWidgetState extends State<NetLoadingWidget> {


  LoadingFlag loadingFlag = LoadingFlag.loading;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    var key;

    @override
    void initState() {
      key = GlobalKey();
      widget?.loadingController?._setState(this);
      super.initState();
    }

    return Scaffold(
      key: key,
      backgroundColor: Colors.black.withOpacity(0.3),
      body: Container(
        width: size.width,
        height: size.height,
        alignment: Alignment.center,
        child: Container(
          width: size.width / 3 * 2,
          height: size.height / 2,
          child: Card(
            child: LoadingWidget(
              flag: loadingFlag,
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
      ),
    );
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


class LoadingController{


  _NetLoadingWidgetState _state;

  void setFlag(LoadingFlag loadingFlag){
    _state.loadingFlag = loadingFlag;
    _state.setState((){});
  }


  void _setState(_NetLoadingWidgetState state){
    if(this._state == null){
      this._state = state;
    }
  }

}