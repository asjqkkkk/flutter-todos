import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/items/task_detail_item.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/json/task_icon_bean.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/model/task_detail_page_model.dart';
import 'package:todo_list/widgets/popmenu_botton.dart';
import 'package:todo_list/widgets/task_info_widget.dart';

class TaskDetailPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);
    final mainPageModel = globalModel.mainPageModel;
    final model = Provider.of<TaskDetailPageModel>(context)
      ..setContext(context)
      ..setGlobalModel(globalModel);
    final taskColor = globalModel.isCardChangeWithBg
        ? Theme.of(context).primaryColor
        : ColorBean.fromBean(model.taskBean.taskIconBean.colorBean);

    final int heroTag = model.heroTag;
    final size = MediaQuery.of(context).size;


    return WillPopScope(
      onWillPop: () {
        model.logic.exitPage();
        return Future.value(false);
      },
      child: Stack(
        children: <Widget>[
          Hero(
            tag: "task_bg$heroTag",
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
                      icon: Icon(Platform.isAndroid
                          ? Icons.arrow_back
                          : Icons.arrow_back_ios),
                      onPressed: model.logic.exitPage,
                    )
                  : SizedBox(),
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: <Widget>[
                Hero(
                    tag: "task_more$heroTag",
                    child: Material(
                        color: Colors.transparent,
                        child: PopMenuBt(
                          iconColor: taskColor,
                          onDelete: () => model.logic.deleteTask(mainPageModel),
                          onEdit: () => model.logic.editTask(mainPageModel),
                        ))),
              ],
            ),
            //使用NotificationListener可以去掉android上默认Listview的水波纹效果
            body: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 50, top: size.width > size.height ? 0 : 20, right: 50),
                  child: TaskInfoWidget(
                    heroTag,
                    taskBean: model.taskBean,
                    isCardChangeWithBg: globalModel.isCardChangeWithBg,
                    isExisting: model.isExiting,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: !model.isExiting
                        ? NotificationListener<OverscrollIndicatorNotification>(
                            onNotification: (overScroll) {
                              overScroll.disallowGlow();
                              return true;
                            },
                            child: ListView(
                              children: List.generate(
                                model?.taskBean?.detailList?.length ?? 0,
                                (index) {
                                  TaskDetailBean taskDetailBean =
                                      model.taskBean.detailList[index];
                                  return Container(
                                    margin: EdgeInsets.only(
                                        bottom: index ==
                                                model.taskBean.detailList
                                                        .length -
                                                    1
                                            ? 20
                                            : 0,
                                        left: 50,
                                        right: 50),
                                    child: TaskDetailItem(
                                      index: index,
                                      showAnimation: model.doneTaskPageModel == null,
                                      itemProgress: taskDetailBean.itemProgress,
                                      itemName: taskDetailBean.taskDetailName,
                                      iconColor: taskColor,
                                      onProgressChanged: (progress) {
                                        model.logic.refreshProgress(
                                            taskDetailBean,
                                            progress,
                                            mainPageModel);
                                        model.refresh();
                                      },
                                      onChecked: (progress) {
                                        model.logic.refreshProgress(
                                            taskDetailBean,
                                            progress,
                                            mainPageModel);
                                        model.refresh();
                                      },
                                    ),
                                  );
                                },
                              ),
                            ))
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
