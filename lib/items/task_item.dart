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
    final globalModel = Provider.of<GlobalModel>(context);

    final widget = TaskInfoWidget(
      index,
      space: 0,
      taskBean: taskBean,
      onDelete: onDelete,
      onEdit: onEdit,
      isCardChangeWithBg: globalModel.isCardChangeWithBg,
    );

    return Container(
      margin: EdgeInsets.all(10),
      child: Stack(
        children: <Widget>[
          Hero(
            tag: "task_bg$index",
            child: Container(
              decoration: BoxDecoration(
                color: globalModel.logic.getBgInDark(),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
          Container(
            child: Card(
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: widget,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
