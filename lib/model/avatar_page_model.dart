import 'package:flutter/material.dart';
import 'package:todo_list/logic/all_logic.dart';
import 'package:todo_list/model/main_page_model.dart';

class AvatarPageModel extends ChangeNotifier{

  AvatarPageLogic logic;
  BuildContext context;
  MainPageModel mainPageModel;
  Widget currentAvatarWidget;

  AvatarPageModel(){
    logic = AvatarPageLogic(this);
  }

  void setContext(BuildContext context){
    if(this.context == null){
        this.context = context;
        Future.wait([
          logic.getAvatarWidget(),
        ]).then((value) {
          refresh();
        });
    }
  }

  @override
  void dispose(){
    super.dispose();
    debugPrint("AvatarPageModel销毁了");
  }

  void refresh(){
    notifyListeners();
  }

  void setMainPageModel(MainPageModel mainPageModel) {
    if(this.mainPageModel == null){
      this.mainPageModel = mainPageModel;
    }
  }
}

enum AvatarType {
  local,
  net,
}
