import 'package:flutter/material.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/widgets/task_info_widget.dart';

class TaskItem extends StatelessWidget {
  final int index;
  final TaskBean taskBean;

  TaskItem(this.index, this.taskBean);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width - 100;

    return Container(
      width: width,
      height: width,
      child: Stack(
        children: <Widget>[
          Hero(
              tag: "task_bg${index}",
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                margin: EdgeInsets.all(4),
              )),
          Container(
              height: width,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                      margin: EdgeInsets.only(left: 16, right: 16),
                      child: TaskInfoWidget(
                        index,
                        space: width / 3,
                        taskName: taskBean?.taskName??"",
                        taskNumbers: taskBean?.taskDetailNum??0,
                        overallProgress: taskBean?.overallProgress??0.0,
                      )))),
        ],
      ),
    );
  }
}
