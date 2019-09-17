import 'package:flutter/material.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/json/photo_bean.dart';
import 'package:todo_list/logic/all_logic.dart';
import 'package:todo_list/widgets/loading_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'account_page_model.dart';


class NetPicturesPageModel extends ChangeNotifier{


  NetPicturesPageLogic logic;
  BuildContext context;

  List<PhotoBean> photos = [];
  String loadingErrorText = "";

  LoadingFlag loadingFlag = LoadingFlag.loading;
  RefreshController refreshController = RefreshController(initialRefresh: true);
  CancelToken cancelToken = CancelToken();

  ///用于判断是否被销毁，防止与dio搭配使用报错
  bool isDisposed = false;

  ///表示这个网络图片是用来干嘛的,比如用来设置账号页面的背景、侧滑栏的头部图片
  String useType;


  ///[accountPageModel]是从'我的账号'页面进入时传过来的值
  AccountPageModel accountPageModel;

  NetPicturesPageModel({String useType, AccountPageModel accountPageModel}){
    this.useType = useType;
    this.accountPageModel = accountPageModel;
    logic = NetPicturesPageLogic(this);
  }

  void setContext(BuildContext context){
    if(this.context == null){
        this.context = context;
        logic.getPhotos(cancelToken: cancelToken);
    }
  }

  @override
  void dispose(){
    isDisposed = true;
    refreshController.dispose();
    if(!cancelToken.isCancelled) cancelToken.cancel();
    super.dispose();
    debugPrint("NetPicturesPageModel销毁了");
  }

  void refresh(){
    if(!isDisposed) notifyListeners();
  }
}

