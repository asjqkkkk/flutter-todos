import 'package:dio/dio.dart';
export 'package:dio/dio.dart';


///Dio的封装类
class ApiStrategy {
  static ApiStrategy _instance;

  static final String baseUrl = "http://111.230.251.115/oldchen/";
//  static final String baseUrl = "http://192.168.137.1:8080/";
  static const int connectTimeOut = 10 * 1000; //连接超时时间为10秒
  static const int receiveTimeOut = 15 * 1000; //响应超时时间为15秒

  Dio _client;

  static ApiStrategy getInstance() {
    if (_instance == null) {
      _instance = ApiStrategy._internal();
    }
    return _instance;
  }

  ApiStrategy._internal() {
    if (_client == null) {
      BaseOptions options = new BaseOptions();
      options.connectTimeout = connectTimeOut;
      options.receiveTimeout = receiveTimeOut;
      options.baseUrl = baseUrl;
      _client = new Dio(options);
      _client.interceptors.add(LogInterceptor(
        responseBody: true,
        requestHeader: false,
        responseHeader: false,
        request: false,
      )); //开启请求日志
    }
  }

  Dio get client => _client;
  static const String GET = "get";
  static const String POST = "post";

  static String getBaseUrl() {
    return baseUrl;
  }

  //get请求
  void get(
    String url,
    Function callBack, {
    Map<String, String> params,
    Function errorCallBack,
    CancelToken token,
  }) async {
    _request(
      url,
      callBack,
      method: GET,
      params: params,
      errorCallBack: errorCallBack,
      token: token,
    );
  }

  //post请求
  void post(
    String url,
    Function callBack, {
    Map<String, String> params,
    Function errorCallBack,
    CancelToken token,
  }) async {
    _request(
      url,
      callBack,
      method: POST,
      params: params,
      errorCallBack: errorCallBack,
      token: token,
    );
  }

  //post请求
  void postUpload(
    String url,
    Function callBack,
    ProgressCallback progressCallBack, {
    FormData formData,
    Function errorCallBack,
    CancelToken token,
  }) async {
    _request(
      url,
      callBack,
      method: POST,
      formData: formData,
      errorCallBack: errorCallBack,
      progressCallBack: progressCallBack,
      token: token,
    );
  }

  void _request(
    String url,
    Function callBack, {
    String method,
    Map<String, String> params,
    FormData formData,
    Function errorCallBack,
    ProgressCallback progressCallBack,
    CancelToken token,
  }) async {
    if (params != null && params.isNotEmpty) {
      print("<net> params :" + params.toString());
    }

    String errorMsg = "";
    int statusCode;
    try {
      Response response;
      if (method == GET) {
        //组合GET请求的参数
        if (params != null && params.isNotEmpty) {
          response = await _client.get(
            url,
            queryParameters: params,
            cancelToken: token,
          );
        } else {
          response = await _client.get(
            url,
            cancelToken: token,
          );
        }
      } else {
        if (params != null && params.isNotEmpty || formData.isNotEmpty) {
          response = await _client.post(
            url,
            data: formData ?? new FormData.from(params),
            onSendProgress: progressCallBack,
            cancelToken: token,
          );
        } else {
          response = await _client.post(
            url,
            cancelToken: token,
          );
        }
      }

      statusCode = response.statusCode;

      //处理错误部分
      if (statusCode < 0) {
        errorMsg = "网络请求错误,状态码:" + statusCode.toString();
        _handError(errorCallBack, errorMsg);
        return;
      }

      if (callBack != null) {
        callBack(response.data);
      }
    } catch (e) {
      _handError(errorCallBack, e.toString());
    }
  }

  //处理异常
  static void _handError(Function errorCallback, String errorMsg) {
    if (errorCallback != null) {
      errorCallback(errorMsg);
    }
    print("<net> errorMsg :" + errorMsg);
  }
}
