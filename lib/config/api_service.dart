import 'dart:convert';

import 'package:todo_list/json/all_beans.dart';
import 'package:todo_list/json/task_bean.dart';
export 'package:todo_list/json/all_beans.dart';

import 'api_strategy.dart';
export 'package:dio/dio.dart';


///这里存放所有的网络请求接口
class ApiService {
  factory ApiService() => _getInstance();

  static ApiService get instance => _getInstance();
  static ApiService _instance;

  static final int requestSucceed = 0;
  static final int requestFailed = 1;

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
          if (commonBean.status == requestSucceed) {
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
          if (commonBean.status == requestSucceed) {
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
        if (weatherBean.heWeather6[weatherBean.heWeather6.length - 1].status ==
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
          LoginBean loginBean = LoginBean.fromMap(data);
          if (loginBean.status == requestSucceed) {
            success(loginBean);
          } else {
            failed(loginBean);
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
          if (bean.status == requestSucceed) {
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
      url: "fUser/identifyCodeCheck",
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
        if (registerBean.status == requestSucceed) {
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

  ///重设密码
  void postResetPassword({Map<String, String> params, Function success,
    Function failed, Function error, CancelToken token,}){
    postCommon(
      params: params,
      success: success,
      failed: failed,
      error: error,
      url: "fUser/resetPassword",
      token: token,
    );
  }

  ///忘记密码
  void postForgetPassword({Map<String, String> params, Function success,
    Function failed, Function error, CancelToken token}){
    postCommon(
      params: params,
      success: success,
      failed: failed,
      error: error,
      url: "fUser/forgetPassword",
      token: token,
    );
  }

  ///上传一个Task
  void postCreateTask({String token, Function success,
    Function failed, Function error, CancelToken cancelToken, TaskBean taskBean}){
    ApiStrategy.getInstance().post(
      "oneDayTask/createTask",
          (data) {
        UploadTaskBean bean = UploadTaskBean.fromMap(data);
        if (bean.status == requestSucceed) {
          success(bean);
        } else {
          failed(bean);
        }
      },
      params: {
        'taskName':taskBean.taskName,
        'taskType':taskBean.taskType,
        'account':taskBean.account,
        'taskStatus':'${taskBean.taskStatus}',
        'taskDetailNum':'${taskBean.taskDetailNum}',
        'overallProgress':'${taskBean.overallProgress}',
        'changeTimes':'${taskBean.changeTimes}',
        'finishDate':taskBean.finishDate,
        'startDate':taskBean.startDate,
        'deadLine':taskBean.deadLine,
        'taskIconBean':jsonEncode(taskBean.taskIconBean.toMap()),
        'detailList':jsonEncode(List.generate(taskBean.detailList.length, (index) {
          return taskBean.detailList[index].toMap();
        })),
        'token':token,
      },
      errorCallBack: (errorMessage) {
        error("上传出错：$errorMessage");

      },
      token: cancelToken,
    );
  }

  ///获取所有task
  void getTasks({Map<String, String> params, Function success,
    Function failed, Function error, CancelToken token}){
    ApiStrategy.getInstance().post(
      "oneDayTask/getTasks",
          (data) {
            CloudTaskBean bean = CloudTaskBean.fromMap(data);
        if (bean.status == requestSucceed) {
          success(bean);
        } else {
          failed(bean);
        }
      },
      params: params,
      errorCallBack: (errorMessage) {
        error("获取出错：$errorMessage");
      },
      token: token,
    );
  }

  ///更新一个task
  void postUpdateTask({String token, Function success,
    Function failed, Function error, CancelToken cancelToken, TaskBean taskBean}){
    postCommon(
      params: {
        'taskName':taskBean.taskName,
        'taskType':taskBean.taskType,
        'account':taskBean.account,
        'taskStatus':'${taskBean.taskStatus}',
        'taskDetailNum':'${taskBean.taskDetailNum}',
        'overallProgress':'${taskBean.overallProgress}',
        'changeTimes':'${taskBean.changeTimes}',
        'finishDate':taskBean.finishDate,
        'startDate':taskBean.startDate,
        'uniqueId':taskBean.uniqueId,
        'deadLine':taskBean.deadLine,
        'taskIconBean':jsonEncode(taskBean.taskIconBean.toMap()),
        'detailList':jsonEncode(List.generate(taskBean.detailList.length, (index) {
          return taskBean.detailList[index].toMap();
        })),
        'token':token,
      },
      success: success,
      failed: failed,
      error: error,
      url: "oneDayTask/updateTask",
      token: cancelToken,
    );
  }

  ///删除一个task
  void postDeleteTask({Map<String, String> params, Function success,
    Function failed, Function error, CancelToken token}){
    postCommon(
      params: params,
      success: success,
      failed: failed,
      error: error,
      url: "oneDayTask/deleteTask",
      token: token,
    );
  }
}
