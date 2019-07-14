import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/items/task_detail_item.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/json/task_icon_bean.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/model/main_page_model.dart';
import 'package:todo_list/model/task_detail_page_model.dart';
import 'package:todo_list/utils/theme_util.dart';
import 'package:todo_list/widgets/popmenu_botton.dart';
import 'package:todo_list/widgets/task_info_widget.dart';

class TaskDetailPage extends StatelessWidget {
  final int index;

  TaskDetailPage(this.index);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TaskDetailPageModel>(context);
    final globalModel = Provider.of<GlobalModel>(context);
    final mainPageModel = globalModel.mainPageModel;
    model.setContext(context);
    final taskColor = globalModel.isBgChangeWithCard ? Theme.of(context).primaryColor : ColorBean.fromBean(model.taskBean.taskIconBean.colorBean);

    return WillPopScope(
      onWillPop: (){
        model.logic.exitPage();
      },
      child: Stack(
        children: <Widget>[
          Hero(
            tag: "task_bg${index}",
            child: Container(
                decoration: BoxDecoration(
              color: globalModel.logic.getBgInDark(),
              borderRadius: BorderRadius.circular(15.0),
            )),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              iconTheme: IconThemeData(color: taskColor),
              leading: model.isAnimationComplete && !model.isExiting
                  ? IconButton(
                      icon: Icon(Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios),
                      onPressed: model.logic.exitPage,)
                  : SizedBox(),
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: <Widget>[
                Hero(
                    tag: "task_more${index}",
                    child: Material(
                        color: Colors.transparent,
                        child: PopMenuBt(
                          iconColor: taskColor,
                          onDelete: () => model.logic.deleteTask(mainPageModel),
                          onEdit: () => model.logic.editTask(mainPageModel),
                        ))),
              ],
            ),
            body: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 50, top: 20, right: 50),
                    child: TaskInfoWidget(
                      index,
                      taskBean: model.taskBean,
                      isCardChangeWithBg: globalModel.isBgChangeWithCard,
                    )),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 50, top: 20, right: 50, bottom: 20),
                    child: !model.isExiting
                        ? ListView(
                            children: List.generate(
                                model?.taskBean?.detailList?.length ?? 0,
                                (index) {
                            TaskDetailBean taskDetailBean =
                                model.taskBean.detailList[index];
                            return TaskDetailItem(
                              index: index,
                              itemProgress: taskDetailBean.itemProgress,
                              itemName: taskDetailBean.taskDetailName,
                              iconColor: taskColor,
                              onProgressChanged: (progress) {
                                model.logic.refreshProgress(
                                    taskDetailBean, progress, mainPageModel);
                                model.refresh();
                              },
                              onChecked: (progress) {
                                model.logic.refreshProgress(
                                    taskDetailBean, progress, mainPageModel);
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
