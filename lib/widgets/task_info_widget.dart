import 'package:flutter/material.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/json/task_icon_bean.dart';
import 'package:todo_list/model/task_detail_page_model.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/widgets/popmenu_botton.dart';

class TaskInfoWidget extends StatelessWidget {
  final int index;
  final double space;
  final TaskBean taskBean;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final bool isCardChangeWithBg;

  TaskInfoWidget(this.index,
      {this.space = 20,this.taskBean, this.onDelete, this.onEdit, this.isCardChangeWithBg = false});

  @override
  Widget build(BuildContext context) {

    final taskColor = isCardChangeWithBg ? Theme.of(context).primaryColor : ColorBean.fromBean(taskBean.taskIconBean.colorBean);
    final taskIconData = IconBean.fromBean(taskBean.taskIconBean.iconBean);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            color: taskColor,
                          ),
                          shape: BoxShape.circle),
                      child: Icon(
                        taskIconData,
                        color: taskColor,
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
                              child: PopMenuBt(
                                iconColor: taskColor,
                                onDelete: onDelete,
                                onEdit: onEdit,
                              )
                            ))),
              ),
            )
          ],
        ),
        SizedBox(
          height: space,
        ),
        Column(
          children: <Widget>[
            Container(
              height: 50,
              child: Row(
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
                            "${taskBean.taskName} ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  taskBean.overallProgress == 1.0
                      ? Expanded(
                      flex: 1,
                      child: Container(
                          width: 25,
                          height: 25,
                          child: Hero(
                            tag: "task_complete${index}",
                            child: Icon(Icons.check_circle,color: Colors.greenAccent,),
                          )))
                      : SizedBox()
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              alignment: Alignment.bottomLeft,
              child: Hero(
                tag: "task_items${index}",
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    "${DemoLocalizations.of(context).itemNumber(taskBean.taskDetailNum)}",
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
                      "${(taskBean.overallProgress * 100).toInt()}%",
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
                    AlwaysStoppedAnimation(taskColor),
                    value: taskBean.overallProgress,
                    backgroundColor: Color.fromRGBO(224, 224, 224, 1),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
