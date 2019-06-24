import 'package:flutter/material.dart';
import 'package:todo_list/widgets/task_info_widget.dart';

class TaskDetailPage extends StatelessWidget {
  final int index;

  TaskDetailPage(this.index);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Hero(
          tag: "task_bg${index}",
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            )
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Theme.of(context).primaryColor
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: <Widget>[
              IconButton(icon: Hero(tag: "task_more${index}",child: Icon(Icons.more_vert,color: Theme.of(context).primaryColor,)), onPressed: null)
            ],
          ),
          body: Container(
              margin: EdgeInsets.only(left: 50, top: 20, right: 50),
              child: TaskInfoWidget(index)),
        ),
      ],
    );
  }
}
