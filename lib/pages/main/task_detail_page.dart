import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/json/task_bean.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/json/task_icon_bean.dart';
import 'package:todo_list/items/task_detail_item.dart';
import 'package:todo_list/widgets/custom_cache_provider.dart';
import 'package:todo_list/widgets/popmenu_botton.dart';
import 'package:todo_list/widgets/task_info_widget.dart';
import 'package:todo_list/model/task_detail_page_model.dart';

class TaskDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);
    final mainPageModel = globalModel.mainPageModel;
    final model = Provider.of<TaskDetailPageModel>(context)
      ..setContext(context, globalModel);

    globalModel.setTaskDetailPageModel(model);
    final taskColor = globalModel.isCardChangeWithBg
        ? Theme.of(context).primaryColor
        : ColorBean.fromBean(model.taskBean.taskIconBean.colorBean);

    final textColor = model.logic.getTextColor(context);

    final int heroTag = model.heroTag;
    final size = MediaQuery.of(context).size;
    final bgUrl = model.taskBean.backgroundUrl;
    final opacity = mainPageModel.currentTransparency;
    final enableOpacity = model.doneTaskPageModel == null ? mainPageModel.enableTaskPageOpacity : false;

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
              color: globalModel.logic
                  .getBgInDark()
                  .withOpacity(enableOpacity ? opacity : 1.0),
              borderRadius: BorderRadius.circular(15.0),
              image: bgUrl == null
                  ? null
                  : DecorationImage(
                      image: getProvider(bgUrl),
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(
                            enableOpacity ? opacity : 1.0,
                          ),
                          BlendMode.dstATop),
                      fit: BoxFit.cover,
                    ),
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
                          taskBean: model.taskBean,
                          onDelete: () => model.logic.deleteTask(mainPageModel),
                          onEdit: () => model.logic.editTask(mainPageModel),
                        ))),
              ],
            ),
            //使用NotificationListener可以去掉android上默认Listview的水波纹效果
            body: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      left: 50,
                      top: size.width > size.height ? 0 : 20,
                      right: 50),
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
                                      showAnimation:
                                          model.doneTaskPageModel == null,
                                      itemProgress: taskDetailBean.itemProgress,
                                      itemName: taskDetailBean.taskDetailName,
                                      iconColor: taskColor,
                                      textColor: textColor,
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
