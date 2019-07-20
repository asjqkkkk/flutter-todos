import 'package:todo_list/database/database.dart';
import 'package:todo_list/model/all_model.dart';

class DoneTaskPageLogic{

  final DoneTaskPageModel _model;

  DoneTaskPageLogic(this._model);


  Future getDoneTasks() async{
   final tasks = await  DBProvider.db.getTasks(isDone: true);
   if(tasks.length == 0) return;
   _model.doneTasks.clear();
   _model.doneTasks.addAll(tasks);
   _model.loadingFlag = LoadingFlag.success;
  }

}