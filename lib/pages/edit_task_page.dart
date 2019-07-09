import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/config/task_icon_config.dart';
import 'package:todo_list/model/edit_task_page_model.dart';
import 'package:todo_list/model/main_page_model.dart';

class EditTaskPage extends StatelessWidget {
  final TaskIcon taskIcon;
  final MainPageModel mainPageModel;

  EditTaskPage(this.taskIcon, {this.mainPageModel});

  @override
  Widget build(BuildContext context) {

    final EditTaskPageModel model = Provider.of<EditTaskPageModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text(taskIcon.taskName),backgroundColor: taskIcon.color,),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 100),
              child: ListView(
                children: List.generate(30, (index) {
                  return Text(
                    "第${index}条",
                    style: TextStyle(fontSize: 20),
                  );
                }),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    TextField(
                      onChanged: (value){
                        debugPrint("当前的内容是:${value}");
                      },
                      decoration: InputDecoration(
                          hintText: "添加任务",
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            taskIcon.iconData,
                            color: taskIcon.color,
                          ),
                          suffixIcon: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey.withOpacity(0.4)),
                            child: Icon(
                              Icons.arrow_upward,
                              color: Colors.white,
                              size: 20,
                            ),
                          )),
                    ),
                    Container(
                      height: 40,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          getIconText(
                            icon: Icon(
                              Icons.date_range,
                              color: taskIcon.color,
                            ),
                            text: "截止日期",
                            onTap: () {},
                          ),
                          getIconText(
                            icon: Icon(
                              Icons.notifications_active,
                              color: taskIcon.color,
                            ),
                            text: "提醒我",
                            onTap: () {},
                          ),
                          getIconText(
                            icon: Icon(
                              Icons.repeat,
                              color: taskIcon.color,
                            ),
                            text: "重复",
                            onTap: () {},
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getIconText({Icon icon, String text, VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.grey.withOpacity(0.2)),
        child: Row(
          children: <Widget>[
            icon,
            SizedBox(
              width: 4,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
