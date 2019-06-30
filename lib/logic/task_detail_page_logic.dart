import 'package:todo_list/model/all_model.dart';

class TaskDetailPageLogic{

  final TaskDetailPageModel _model;

  TaskDetailPageLogic(this._model);

  double getOverallProgress(){
    int length = _model.taskBean.detailList.length;
    double overallProgress = 0.0;
    for(int i = 0; i < length;i++){
      overallProgress += _model.taskBean.detailList[i].itemProgress / length;
    }
    return overallProgress;
  }

}