import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/widgets/task_info_widget.dart';

class TaskItem extends StatelessWidget {
  final int index;
  final TaskBean taskBean;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  TaskItem(this.index, this.taskBean, {this.onDelete, this.onEdit});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width - 100;
    final globalModel = Provider.of<GlobalModel>(context);

    return Container(
      width: width,
      height: width,
      child: Stack(
        children: <Widget>[
          Hero(
              tag: "task_bg${index}",
              child: Container(
                decoration: BoxDecoration(
                  color: globalModel.logic.getBgInDark(),
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
                        taskBean: taskBean,
                        onDelete: onDelete,
                        onEdit: onEdit,
                      )))),
        ],
      ),
    );
  }
}
