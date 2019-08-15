import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/json/suggestion_bean.dart';
import 'package:todo_list/model/all_model.dart';

class FeedbackWallPageLogic{

  final FeedbackWallPageModel _model;

  FeedbackWallPageLogic(this._model);


  void getSuggestions(){
    ApiService.instance.getSuggestions(
      success: (data){
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
        _model.loadingFlag = LoadingFlag.error;
        _model.refresh();
    },
      token: _model.cancelToken,
    );
  }

}