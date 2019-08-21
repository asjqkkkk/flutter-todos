import 'package:todo_list/json/all_beans.dart';
export 'package:todo_list/json/all_beans.dart';

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
        "fUser/oneDaySuggestion",
        (data) {
          CommonBean commonBean = CommonBean.fromMap(data);
          if (commonBean.status == 0) {
            success(commonBean);
          } else {
            failed(commonBean);
          }
        },
        (count, total) {},
        formData: params,
        errorCallBack: (errorMessage) {
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
  void postCommon(
      {Map<String, String> params,
      Function success,
      Function failed,
      Function error,
      String url,
      CancelToken token}) {
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

  ///登录
  void login({
    Map<String, String> params,
    Function success,
    Function failed,
    Function error,
    CancelToken token,
  }) {
    ApiStrategy.getInstance().post(
        "fUser/login",
        (data) {
          LoginBean login_bean = LoginBean.fromMap(data);
          if (login_bean.status == 0) {
            success(login_bean);
          } else {
            failed(login_bean);
          }
        },
        params: params,
        errorCallBack: (errorMessage) {
          error(errorMessage);
        },token: token);
  }

  ///修改用户名
  void changeUserName(
      {Map<String, String> params,
      Function success,
      Function failed,
      Function error,
      CancelToken token}) {
    postCommon(
      params: params,
      success: success,
      failed: failed,
      error: error,
      url: "fUser/updateUserName",
      token: token,
    );
  }

  ///上传头像
  void uploadAvatar(
      {FormData params,
      Function success,
      Function failed,
      Function error,
      CancelToken token}) {
    ApiStrategy.getInstance().postUpload(
        "fUser/uploadAvatar",
        (data) {
          UploadAvatarBean bean = UploadAvatarBean.fromMap(data);
          if (bean.status == 0) {
            success(bean);
          } else {
            failed(bean);
          }
        },
        (count, total) {},
        formData: params,
        errorCallBack: (errorMessage) {
          error(errorMessage);
        });
  }

  ///邮箱验证码获取请求
  void getVerifyCode({
    Map<String, String> params,
    Function success,
    Function failed,
    Function error,
    CancelToken token,
  }) {
    postCommon(
      params: params,
      success: success,
      failed: failed,
      error: error,
      url: "fUser/identifyCodeSend",
      token: token,
    );
  }

  //邮箱验证码校验请求
  void postVerifyCheck({Map<String, String> params, Function success,
    Function failed, Function error, CancelToken token}) {
    postCommon(
      params: params,
      success: success,
      failed: failed,
      error: error,
      url:     "fUser/identifyCodeCheck"
      ,
      token: token,
    );
  }

  ///邮箱注册
  void postRegister(
      {Map<String, String> params,
      Function success,
      Function failed,
      Function error,
      CancelToken token}) {
    ApiStrategy.getInstance().post(
      "fUser/register",
      (data) {
        RegisterBean registerBean = RegisterBean.fromMap(data);
        if (registerBean.status == 0) {
          success(registerBean);
        } else {
          failed(registerBean);
        }
      },
      params: params,
      errorCallBack: (errorMessage) {
        error(errorMessage);
      },
      token: token,
    );
  }
}
