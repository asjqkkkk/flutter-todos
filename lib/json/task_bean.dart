import 'dart:convert';

//单个任务的json数据
class TaskBean {
  int id;
  String taskName = "";
  String taskType = "";
  int taskStatus = 0;
  int taskDetailNum = 0;
  double overallProgress = 0.0;
  String createDate = "";
  String finishDate = "";
  List<TaskDetailBean> detailList = [];

  static TaskBean fromMap(Map<String, dynamic> map) {
    TaskBean taskBean = new TaskBean();
    taskBean.taskName = map['taskName'];
    taskBean.taskType = map['taskType'];
    taskBean.taskDetailNum = map['taskDetailNum'];
    taskBean.taskStatus = map['taskStatus'];
    taskBean.overallProgress = double.parse(map['overallProgress']);
    taskBean.createDate = map['createDate'];
    taskBean.finishDate = map['finishDate'];
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
      'detailList': jsonEncode(List.generate(detailList.length, (index) {
        return detailList[index].toMap();
      }))
    };
    //把list转换为string的时候不要直接使用tostring，要用jsonEncode
  }

  @override
  String toString() {
    return 'TaskBean{id: $id, taskName: $taskName, taskType: $taskType, taskStatus: $taskStatus, taskDetailNum: $taskDetailNum, overallProgress: $overallProgress, createDate: $createDate, finishDate: $finishDate, detailList: $detailList}';
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
  String taskDetailName = "";
  double itemProgress = 0.0;

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
