import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/items/task_detail_item.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/model/task_detail_page_model.dart';
import 'package:todo_list/widgets/task_info_widget.dart';

class TaskDetailPage extends StatelessWidget {
  final int index;

  TaskDetailPage(this.index);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TaskDetailPageModel>(context);

    return WillPopScope(
      onWillPop: () {
        model.isExisting = true;
        model.refresh();
        Navigator.of(context).pop();
      },
      child: Stack(
        children: <Widget>[
          Hero(
            tag: "task_bg${index}",
            child: Container(
                decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            )),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    model.isExisting = true;
                    model.refresh();
                    Navigator.of(context).pop();
                  }),
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: <Widget>[
                IconButton(
                    icon: Hero(
                        tag: "task_more${index}",
                        child: Icon(
                          Icons.more_vert,
                          color: Theme.of(context).primaryColor,
                        )),
                    onPressed: null)
              ],
            ),
            body: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 50, top: 20, right: 50),
                    child: TaskInfoWidget(
                      index,
                      taskNumbers: model?.taskBean?.taskDetailNum??0,
                      taskName: model?.taskBean?.taskName??"",
                      overallProgress: model.overallProgress,
                    )),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 50, top: 20, right: 50, bottom: 20),
                    child: !model.isExisting
                        ? ListView(
                            children:
                                List.generate(model?.taskBean?.detailList?.length??0, (index) {
                                  TaskDetailBean taskDetailBean = model.taskBean.detailList[index];
                            return TaskDetailItem(
                              itemProgress: taskDetailBean.itemProgress,
                              itemName: taskDetailBean.taskDetailName,
                              onProgressChanged: (progress){
                                taskDetailBean.itemProgress = progress;
                                model.overallProgress = model.logic.getOverallProgress();
                                model.refresh();
                              },
                              onChecked: (progress){
                                taskDetailBean.itemProgress = progress;
                                model.overallProgress = model.logic.getOverallProgress();
                                model.refresh();
                              },
                            );
                          }))
                        : SizedBox(),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
