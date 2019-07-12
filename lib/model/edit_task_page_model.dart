import 'package:flutter/material.dart';
import 'package:todo_list/logic/all_logic.dart';
import 'package:todo_list/utils/theme_util.dart';

class EditTaskPageModel extends ChangeNotifier{

  EditTaskPageLogic logic;
  BuildContext context;
  Color bgColor = Colors.white;
  final TextEditingController textEditingController = TextEditingController();

  List<String> taskDetails = [];

  bool canAddTask = false;    //能否添加任务

  EditTaskPageModel(){
    logic = EditTaskPageLogic(this);
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

}