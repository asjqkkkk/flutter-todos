import 'package:flutter/material.dart';
import 'package:todo_list/logic/all_logic.dart';

class FeedbackWallPageModel extends ChangeNotifier{

  FeedbackWallPageLogic logic;
  BuildContext context;

  FeedbackWallPageModel(){
    logic = FeedbackWallPageLogic(this);
  }

  void setContext(BuildContext context){
    if(this.context == null){
        this.context = context;
    }
  }

  @override
  void dispose(){
    super.dispose();
    debugPrint("FeedbackWallPageModel销毁了");
  }

  void refresh(){
    notifyListeners();
  }
}