

import 'package:todo_list/json/all_beans.dart';

import 'api_strategy.dart';
export 'package:dio/dio.dart';

class ApiService {
  factory ApiService() => _getInstance();

  static ApiService get instance => _getInstance();
  static ApiService _instance;

  static final int SUCCEED = 0;
  static final int FAILED = 1;

  ApiService._internal() {
    //初始化
  }

  static ApiService _getInstance() {
    if (_instance == null) {
      _instance = new ApiService._internal();
    }
    return _instance;
  }

  //获取图片
  void getPhotos({
    Function success,
    Function failed,
    Function error,
    Map<String, String> params,
    CancelToken token,
  }) {
    ApiStrategy.getInstance().get(
      "https://api.unsplash.com/photos/",
      (data) {
        if (data.toString().contains("errors")) {
          failed(data);
        } else {
          List<PhotoBean> beans = PhotoBean.fromMapList(data);
          success(beans);
        }
      },
      params: params,
      errorCallBack: (errorMessage) {
        error(errorMessage);
      },
      token: token,
    );
  }

  //提交建议
  void postSuggestion(Map<String, String> params, Function success,
      Function failed, Function error, CancelToken token){
    postCommon(params, success, failed, error, "fUser/suggestion", token);
  }

  //通用的请求
  void postCommon(Map<String, String> params, Function success,
      Function failed, Function error, String url, CancelToken token) {
    ApiStrategy.getInstance().post(
        url, (data) {
          CommonBean commonBean = CommonBean.fromMap(data);
          if (commonBean.status == 0) {
            success(commonBean);
          } else {
            failed(commonBean);
          }
        },
        params: params,
        errorCallBack: (errorMessage) {
          error(errorMessage);
        },token: token);
  }

}
