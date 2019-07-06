import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/items/task_detail_item.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/model/main_page_model.dart';
import 'package:todo_list/model/task_detail_page_model.dart';
import 'package:todo_list/widgets/task_info_widget.dart';

class TaskDetailPage extends StatelessWidget {
  final int index;
  final MainPageModel mainPageModel;

  TaskDetailPage(this.index, {this.mainPageModel});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TaskDetailPageModel>(context);

    return WillPopScope(
      onWillPop: () {
        model.isExiting = true;
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
                    model.isExiting = true;

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
                      taskNumbers: model?.taskBean?.detailList?.length??0,
                      taskName: model?.taskBean?.taskName??"",
                      overallProgress: model.taskBean?.overallProgress??0.0,
                      canShowSucess: !model.isExiting && model.isAnimationComplete,
                    )),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 50, top: 20, right: 50, bottom: 20),
                    child: !model.isExiting
                        ? ListView(
                            children:
                                List.generate(model?.taskBean?.detailList?.length??0, (index) {
                                  TaskDetailBean taskDetailBean = model.taskBean.detailList[index];
                            return TaskDetailItem(
                              index: index,
                              itemProgress: taskDetailBean.itemProgress,
                              itemName: taskDetailBean.taskDetailName,
                              onProgressChanged: (progress){
                                model.logic.refreshProgress(taskDetailBean, progress, mainPageModel);
                                model.refresh();
                              },
                              onChecked: (progress){
                                model.logic.refreshProgress(taskDetailBean, progress, mainPageModel);
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
