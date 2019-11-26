import 'dart:convert';

import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/json/suggestion_bean.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/utils/shared_util.dart';

class FeedbackWallPageLogic{

  final FeedbackWallPageModel _model;

  FeedbackWallPageLogic(this._model);


  void getSuggestions(){
    ApiService.instance.getSuggestions(
      success: (data){
        SharedUtil.instance.saveString(Keys.feedbackWallCacheList, jsonEncode(data));
        SuggestionBean suggestionBean = SuggestionBean.fromMap(data);
        _model.suggestionList.clear();
        _model.suggestionList.addAll(suggestionBean.suggestions);
        ///反转列表，按照时间最新的排在最前面
        _model.suggestionList = _model.suggestionList.reversed.toList();
        if(_model.suggestionList.isEmpty){
          _model.loadingFlag = LoadingFlag.empty;
        }
        _model.refresh();
      }, error: (msg){
        if(_model.hasCache == true){
          _model.loadingFlag = LoadingFlag.error;
          _model.refresh();
        }
    },
      token: _model.cancelToken,
    );
  }

  void getCacheSuggestions() async{
    final data = await SharedUtil.instance.getString(Keys.feedbackWallCacheList);
    if(data == null) return;
    SuggestionBean suggestionBean = SuggestionBean.fromMap(jsonDecode(data));
    _model.suggestionList.clear();
    _model.suggestionList.addAll(suggestionBean.suggestions);
    _model.hasCache = true;
    _model.suggestionList = _model.suggestionList.reversed.toList();
    _model.refresh();
    print("获取到的缓存数据:$data");
  }

}