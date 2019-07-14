import 'package:flutter/material.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/json/task_icon_bean.dart';
import 'package:todo_list/logic/all_logic.dart';
import 'package:todo_list/model/main_page_model.dart';
import 'package:todo_list/utils/theme_util.dart';

class EditTaskPageModel extends ChangeNotifier{

  EditTaskPageLogic logic;
  BuildContext context;
  Color bgColor = Colors.white;
  final TextEditingController textEditingController = TextEditingController();
  MainPageModel mainPageModel;

  //任务清单
  List<TaskDetailBean> taskDetails = [];
  //截止日期
  DateTime deadLine;
  //开始日期
  DateTime startDate;
  TaskIconBean taskIcon;
  String currentTaskName = "";

  //能否添加一项任务
  bool canAddTaskDetail = false;

  //当这个值不为空的时候，表示不是新增一个task，而是编辑已存在的task
  TaskBean oldTaskBean;

  EditTaskPageModel({this.oldTaskBean}){
    logic = EditTaskPageLogic(this);
    logic.initialDataFromOld(oldTaskBean);
  }

  void setContext(BuildContext context){
    if(this.context == null){
        this.context = context;
        logic.getBgInDark();
    }
  }

  @override
  void dispose(){
    super.dispose();
    textEditingController?.removeListener(logic.editListener);
    textEditingController?.dispose();
    debugPrint("EditTaskPageModel销毁了");
  }

  void refresh(){
    notifyListeners();
  }

  void setTaskIcon(TaskIconBean taskIcon) {
    if(this.taskIcon == null){
      this.taskIcon = taskIcon;
    }
  }

  void setMainPageModel(MainPageModel mainPageModel) {
    this.mainPageModel = mainPageModel;
  }

}