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
    ///初始化
  }

  static ApiService _getInstance() {
    if (_instance == null) {
      _instance = new ApiService._internal();
    }
    return _instance;
  }

  ///获取图片
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

  ///提交建议(新增头像上传)
  void postSuggestionWithAvatar(
      {FormData params,
      Function success,
      Function failed,
      Function error,
      CancelToken token}) {
    ApiStrategy.getInstance().postUpload(
        "fUser/oneDaySuggestion", (data) {
      CommonBean commonBean = CommonBean.fromMap(data);
      if (commonBean.status == 0) {
        success(commonBean);
      } else {
        failed(commonBean);
      }
    }, (count, total) {},
        formData: params, errorCallBack: (errorMessage) {
      error(errorMessage);
    });
  }

  ///获取建议列表
  void getSuggestions({
    Function success,
    Function error,
    CancelToken token,
  }) {
    ApiStrategy.getInstance().get(
      "fUser/getSuggestion",
          (data) {
            success(data);
      },
      errorCallBack: (errorMessage) {
        error(errorMessage);
      },
      token: token,
    );
  }

  ///通用的请求
  void postCommon(Map<String, String> params, Function success, Function failed,
      Function error, String url, CancelToken token) {
    ApiStrategy.getInstance().post(
        url,
        (data) {
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
        },
        token: token);
  }

  ///天气获取
  void getWeatherNow({
    Function success,
    Function failed,
    Function error,
    Map<String, String> params,
    CancelToken token,
  }) {
    ApiStrategy.getInstance().get(
      "https://free-api.heweather.com/s6/weather/now",
      (data) {
        WeatherBean weatherBean = WeatherBean.fromMap(data);
        if (weatherBean.HeWeather6[weatherBean.HeWeather6.length - 1].status ==
            "ok") {
          success(weatherBean);
        } else {
          failed(weatherBean);
        }
      },
      params: params,
      errorCallBack: (errorMessage) {
        error(errorMessage);
      },
      token: token,
    );
  }

  ///检查更新
  void checkUpdate({
    Function success,
    Function error,
    Map<String, String> params,
    CancelToken token,
  }) {
    ApiStrategy.getInstance().post(
      "app/checkUpdate",
      (data) {
        UpdateInfoBean updateInfoBean = UpdateInfoBean.fromMap(data);
        success(updateInfoBean);
      },
      params: params,
      errorCallBack: (errorMessage) {
        error(errorMessage);
      },
      token: token,
    );
  }
}
