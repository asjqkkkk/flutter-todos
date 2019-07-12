import 'package:flutter/material.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/task_detail_page_model.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/widgets/popmenu_botton.dart';

class TaskInfoWidget extends StatelessWidget {
  final int index;
  final double space;
  final double overallProgress;
  final int taskNumbers;
  final String taskName;

  TaskInfoWidget(this.index,
      {this.space = 20,
      this.overallProgress = 0,
      this.taskNumbers = 0,
      this.taskName = "",});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 16),
                  child: Hero(
                    tag: "task_icon${index}",
                    child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                            ),
                            shape: BoxShape.circle),
                        child: Icon(
                          Icons.book,
                          color: Theme.of(context).primaryColor,
                        )),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                      width: 42,
                      height: 42,
                      margin: EdgeInsets.only(top: 16),
                      child: space == 20
                          ? SizedBox()
                          : Hero(
                              tag: "task_more${index}",
                              child: Material(
                                color: Colors.transparent,
                                child: PopMenuBt()
                              ))),
                ),
              )
            ],
          ),
          SizedBox(
            height: space,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 9,
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Hero(
                    tag: "task_title${index}",
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        "${taskName} ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              overallProgress == 1.0
                  ? Expanded(
                      flex: 1,
                      child: Container(
                          width: 40,
                          height: 40,
                          child: Hero(
                            tag: "task_complete${index}",
                            child: Icon(Icons.check_circle,color: Colors.greenAccent,),
                          )))
                  : SizedBox()
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            alignment: Alignment.bottomLeft,
            child: Hero(
              tag: "task_items${index}",
              child: Material(
                color: Colors.transparent,
                child: Text(
                  "${DemoLocalizations.of(context).itemNumber(taskNumbers)}",
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(top: 5),
            child: Hero(
              tag: "task_progress${index}",
              child: Material(
                  color: Colors.transparent,
                  child: Text(
                    "${(overallProgress * 100).toInt()}%",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  )),
            ),
          ),
          Hero(
            tag: "task_progressbar${index}",
            child: Container(
              height: 10,
              margin: EdgeInsets.only(top: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                  value: overallProgress,
                  backgroundColor: Color.fromRGBO(224, 224, 224, 1),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
