import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/model/all_model.dart';

class TaskDetailPageLogic{

  final TaskDetailPageModel _model;

  TaskDetailPageLogic(this._model);

  double _getOverallProgress(){
    int length = _model.taskBean.detailList.length;
    double overallProgress = 0.0;
    for(int i = 0; i < length;i++){
      overallProgress += _model.taskBean.detailList[i].itemProgress / length;
    }
    _model.taskBean.overallProgress = overallProgress;
    return overallProgress;
  }

  void refreshProgress(TaskDetailBean taskDetailBean, progress, MainPageModel model) {
    taskDetailBean.itemProgress = progress;
    _getOverallProgress();
    model.refresh();
    _model.refresh();
  }

}