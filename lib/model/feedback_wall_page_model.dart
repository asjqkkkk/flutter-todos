import 'package:flutter/material.dart';
import 'package:todo_list/json/suggestion_bean.dart';
import 'package:todo_list/logic/all_logic.dart';
import 'package:dio/dio.dart';
import 'package:todo_list/widgets/loading_widget.dart';

class FeedbackWallPageModel extends ChangeNotifier{

  FeedbackWallPageLogic logic;
  BuildContext context;
  CancelToken cancelToken = CancelToken();


  List<SuggestionsListBean> suggestionList = [];
  LoadingFlag loadingFlag = LoadingFlag.loading;

  bool hasCache = false;

  FeedbackWallPageModel(){
    logic = FeedbackWallPageLogic(this);
  }

  void setContext(BuildContext context){
    if(this.context == null){
        this.context = context;
        logic.getCacheSuggestions();
        logic.getSuggestions();
    }
  }

  @override
  void dispose(){
    super.dispose();
    debugPrint("FeedbackWallPageModel销毁了");
  }

  void refresh(){
    notifyListeners();
  }
}