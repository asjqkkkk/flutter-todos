import 'package:flutter/material.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/logic/all_logic.dart';
import 'package:todo_list/widgets/loading_widget.dart';
export 'package:todo_list/widgets/loading_widget.dart';

class DoneTaskPageModel extends ChangeNotifier{

  DoneTaskPageLogic logic;
  BuildContext context;


  LoadingFlag loadingFlag = LoadingFlag.loading;
  List<TaskBean> doneTasks = [];

  //当前点击到的已完成任务的index，方便再任务列表页面删除用的
  int currentTapIndex = 0;

  DoneTaskPageModel(){
    logic = DoneTaskPageLogic(this);
  }

  void setContext(BuildContext context){
    if(this.context == null){
        this.context = context;
        Future.wait([
          logic.getDoneTasks(),
        ],).then((value){
          refresh();
        });
    }
  }

  @override
  void dispose(){
    super.dispose();
    debugPrint("DoneTaskPageModel销毁了");
  }

  void refresh(){
    notifyListeners();
  }
}