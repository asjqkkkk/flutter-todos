//单个任务的json数据
class TaskBean {
  String taskName = "";
  String taskType = "";
  int taskDetailNum = 0;
  double overallProgress = 0.0;
  List<TaskDetailBean> detailList = [];

  static TaskBean fromMap(Map<String, dynamic> map) {
    TaskBean taskBean = new TaskBean();
    taskBean.taskName = map['taskName'];
    taskBean.taskType = map['taskType'];
    taskBean.taskDetailNum = map['taskDetailNum'];
    taskBean.overallProgress = map['overallProgress'];
    taskBean.detailList = TaskDetailBean.fromMapList(map['detailList']);
    return taskBean;
  }

  static List<TaskBean> fromMapList(dynamic mapList) {
    List<TaskBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String toString() {
    return 'TaskBean{taskName: $taskName, taskType: $taskType, taskDetailNum: $taskDetailNum, overallProgress: $overallProgress, detailList: $detailList}';
  }


  static getMockData(){
    return [
      {
        "taskName":"读书",
        "taskType":"read_book",
        "taskDetailNum":4,
        "overallProgress":0.75,
        "detailList":[
          {
            "taskDetailName":"白夜行",
            "itemProgress":0.5,
          },
          {
            "taskDetailName":"解忧杂货铺",
            "itemProgress":0.0,
          },
          {
            "taskDetailName":"恶意",
            "itemProgress":1.0,
          },
          {
            "taskDetailName":"谁杀了他",
            "itemProgress":1.0,
          },
        ],
      },
      {
        "taskName":"写博客",
        "taskType":"write_blog",
        "taskDetailNum":1,
        "overallProgress":0.5,
        "detailList":[
          {
            "taskDetailName":"文档",
            "itemProgress":0.5,
          },
        ],
      },
      {
        "taskName":"动漫",
        "taskType":"read_book",
        "taskDetailNum":2,
        "overallProgress":0.75,
        "detailList":[
          {
            "taskDetailName":"多罗罗",
            "itemProgress":1.0,
          },
          {
            "taskDetailName":"jojo第四季",
            "itemProgress":0.5,
          },
        ],
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
    taskDetailBean.itemProgress = map['itemProgress'];
    return taskDetailBean;
  }

  static List<TaskDetailBean> fromMapList(dynamic mapList) {
    List<TaskDetailBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }


}
