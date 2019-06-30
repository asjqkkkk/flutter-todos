import 'package:test/test.dart';
import 'package:todo_list/json/task_bean.dart';



void main(){

  getMockData(){
    return [
      {
        "taskName":"读书",
        "taskType":"read_book",
        "taskDetailNum":3,
        "overallProgress":0.5,
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

  test("\n测试\n", (){
    List<TaskBean> tasks = TaskBean.fromMapList(getMockData());
    print(tasks[0].toString());
  });


}