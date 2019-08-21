import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/logic/all_logic.dart';
import 'package:todo_list/model/main_page_model.dart';

class AvatarPageModel extends ChangeNotifier{

  AvatarPageLogic logic;
  BuildContext context;
  MainPageModel mainPageModel;
  CancelToken cancelToken = CancelToken();

  //当前头像的类型
  int currentAvatarType = CurrentAvatarType.defaultAvatar;
  //当前的头像url,比如本地的就是本地路径，网络就是网络地址
  String currentAvatarUrl = "images/icon.png";

  final cropKey = GlobalKey<CropState>();

  AvatarPageModel(){
    logic = AvatarPageLogic(this);
  }


  void setContext(BuildContext context){
    if(this.context == null){
        this.context = context;
    }
  }

  @override
  void dispose(){
    cropKey?.currentState?.dispose();
    cancelToken?.cancel();
    super.dispose();
    debugPrint("AvatarPageModel销毁了");
  }

  void refresh(){
    notifyListeners();
  }

  void setMainPageModel(MainPageModel mainPageModel) {
    if(this.mainPageModel == null){
      this.mainPageModel = mainPageModel;
      this.currentAvatarType = mainPageModel.currentAvatarType;
      this.currentAvatarUrl = mainPageModel.currentAvatarUrl;
    }
  }
}

enum AvatarType {
  local,
  history,
}
