import 'dart:convert';

import 'package:todo_list/json/task_icon_bean.dart';

//单个任务的json数据
class TaskBean {
  int id;
  String taskName;
  String taskType;
  int taskStatus;
  int taskDetailNum = 0;
  double overallProgress;

  //创建任务的时间
  String createDate;

  //任务完成的时间
  String finishDate;

  //用户设置的任务开始时间
  String startDate;

  //用户设置的任务结束时间
  String deadLine;

  //当前任务的图标信息
  TaskIconBean taskIconBean;
  List<TaskDetailBean> detailList = [];

  TaskBean(
      {this.taskName = "",
      this.taskType = "",
      this.taskStatus = TaskStatus.todo,
      this.taskDetailNum,
      this.overallProgress = 0.0,
      this.createDate = "",
      this.finishDate = "",
      this.startDate = "",
      this.deadLine = "",
      this.taskIconBean,
      this.detailList});

  static TaskBean fromMap(Map<String, dynamic> map) {
    TaskBean taskBean = new TaskBean();
    taskBean.id = map['id'];
    taskBean.taskName = map['taskName'];
    taskBean.taskType = map['taskType'];
    taskBean.taskDetailNum = map['taskDetailNum'];
    taskBean.taskStatus = map['taskStatus'];
    taskBean.overallProgress = double.parse(map['overallProgress']);
    taskBean.createDate = map['createDate'];
    taskBean.finishDate = map['finishDate'];
    taskBean.startDate = map['startDate'];
    taskBean.deadLine = map['deadLine'];
    if(map['taskIconBean'] is String){
      var taskIconBean = jsonDecode(map['taskIconBean']);
      taskBean.taskIconBean = TaskIconBean.fromMap(taskIconBean);
    } else {
      taskBean.taskIconBean = TaskIconBean.fromMap(map['taskIconBean']);
    }
    if (map['detailList'] is String) {
      var detailList = jsonDecode(map['detailList']);
      taskBean.detailList = TaskDetailBean.fromMapList(detailList);
    } else {
      taskBean.detailList = TaskDetailBean.fromMapList(map['detailList']);
    }
    return taskBean;
  }

  static List<TaskBean> fromMapList(dynamic mapList) {
    List<TaskBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  Map<String, dynamic> toMap() {
    return {
      'taskName': taskName,
      'taskType': taskType,
      'taskStatus': taskStatus,
      'taskDetailNum': taskDetailNum,
      'overallProgress': overallProgress.toString(),
      'createDate': createDate,
      'finishDate': finishDate,
      'startDate': startDate,
      'deadLine': deadLine,
      'taskIconBean': jsonEncode(taskIconBean.toMap()),
      'detailList': jsonEncode(List.generate(detailList.length, (index) {
        return detailList[index].toMap();
      }))
    };
    //把list转换为string的时候不要直接使用tostring，要用jsonEncode
  }

  @override
  String toString() {
    return 'TaskBean{id: $id, taskName: $taskName, taskType: $taskType, taskStatus: $taskStatus, taskDetailNum: $taskDetailNum, overallProgress: $overallProgress, createDate: $createDate, finishDate: $finishDate, startDate: $startDate, deadLine: $deadLine, taskIconBean: $taskIconBean, detailList: $detailList}';
  }

  static getMockData() {
    return [
      {
        "taskName": "读书",
        "taskType": "read_book",
        "taskDetailNum": 4,
        "overallProgress": '0.625',
        "taskStatus": 1,
        "detailList": [
          {"taskDetailName": "白夜行", "itemProgress": '0.5'},
          {"taskDetailName": "解忧杂货铺", "itemProgress": '0.0'},
          {"taskDetailName": "恶意", "itemProgress": '1.0'},
          {"taskDetailName": "谁杀了他", "itemProgress": '1.0'}
        ]
      },
      {
        "taskName": "写博客",
        "taskType": "write_blog",
        "taskDetailNum": 1,
        "overallProgress": '0.5',
        "taskStatus": 1,
        "detailList": [
          {"taskDetailName": "文档", "itemProgress": '0.5'}
        ]
      },
      {
        "taskName": "动漫",
        "taskType": "read_book",
        "taskDetailNum": 2,
        "overallProgress": '0.75',
        "taskStatus": 1,
        "detailList": [
          {"taskDetailName": "多罗罗", "itemProgress": '1.0'},
          {"taskDetailName": "jojo第四季", "itemProgress": '0.5'}
        ]
      }
    ];
  }
}

//单个任务详情的json数据
class TaskDetailBean {
  String taskDetailName;
  double itemProgress;

  TaskDetailBean({this.taskDetailName = "", this.itemProgress = 0.0});

  static TaskDetailBean fromMap(Map<String, dynamic> map) {
    TaskDetailBean taskDetailBean = new TaskDetailBean();
    taskDetailBean.taskDetailName = map['taskDetailName'];
    taskDetailBean.itemProgress = double.parse(map['itemProgress']);
    return taskDetailBean;
  }

  static List<TaskDetailBean> fromMapList(dynamic mapList) {
    List<TaskDetailBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'taskDetailName': taskDetailName,
      'itemProgress': itemProgress.toString()
    };
  }
}

class TaskStatus {
  static const int todo = 0;
  static const int doing = 1;
  static const int done = 2;
}
