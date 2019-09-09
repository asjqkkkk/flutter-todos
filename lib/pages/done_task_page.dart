import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/color_bean.dart';
import 'package:todo_list/json/task_icon_bean.dart';
import 'package:todo_list/model/done_task_page_model.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/utils/theme_util.dart';

class DoneTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<DoneTaskPageModel>(context)
      ..setContext(context);
    final globalModel = Provider.of<GlobalModel>(context);
    final size = MediaQuery
        .of(context)
        .size;
    final minSize = min(size.width, size.height);
    final itemHeight =  minSize / 4;
    final textSize = itemHeight / 10;

    final textColor = globalModel.logic.getWhiteInDark();

    bool isDartNow =
        globalModel.currentThemeBean.themeType == MyTheme.darkTheme;
    final bgColor = isDartNow
        ? ColorBean.fromBean(globalModel.currentThemeBean.colorBean)
        : Theme
        .of(context)
        .primaryColor;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: globalModel.logic.getBgInDark(),
        title: Text(
          DemoLocalizations
              .of(context)
              .doneList,
          style: TextStyle(
            color: bgColor,
          ),
        ),
        iconTheme: IconThemeData(
          color: bgColor,
        ),
      ),
      body: Container(
        color: globalModel.logic.getBgInDark(),
        alignment: Alignment.center,
        child: model.doneTasks.isNotEmpty
            ? ListView.builder(
            itemCount: model.doneTasks.length,
            itemBuilder: (ctx, index) {
              final task = model.doneTasks[index];
              final colorBean = task.taskIconBean.colorBean;
              final iconBean = task.taskIconBean.iconBean;
              final color = isDartNow
                  ? Colors.black.withOpacity(0.2)
                  : ColorBean.fromBean(colorBean);
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () => model.logic.onTaskTap(index, task),
                    child: Container(
                      height: itemHeight,
                      width: itemHeight * 1.3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: itemHeight,
                                child: Text(
                                  task.taskName,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: textSize + 8,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                "${DemoLocalizations
                                    .of(context)
                                    .taskNum}:${task.taskDetailNum}",
                                style: TextStyle(
                                  fontSize: textSize,
                                  color: textColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${DemoLocalizations
                                    .of(context)
                                    .createDate}:${model.logic.getTimeText(
                                    task.createDate)}",
                                style: TextStyle(
                                  fontSize: textSize,
                                  color: textColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          color: color,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    width: 20,
                    color: color,
                  ),
                  Column(
                    children: <Widget>[
                      index == 0
                          ? SizedBox(
                        height: itemHeight / 2,
                      )
                          : Container(
                        color: color,
                        width: 2,
                        height: itemHeight / 2,
                      ),
                      Container(
                        width: itemHeight / 3,
                        height: itemHeight / 3,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: color,
                            ),
                            shape: BoxShape.circle),
                        child: Icon(
                          IconBean.fromBean(iconBean),
                          color: color,
                        ),
                      ),
                      index == model.doneTasks.length - 1
                          ? SizedBox(
                        height: itemHeight / 2,
                      )
                          : Container(
                        color: color,
                        width: 2,
                        height: itemHeight / 2,
                      ),
                    ],
                  ),
                  Container(
                    height: 1,
                    width: 20,
                    color: color,
                  ),
                  InkWell(
                    onTap: () => model.logic.onTaskTap(index, task),
                    child: Container(
                      height: itemHeight,
                      width: itemHeight * 1.3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30)),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: itemHeight,
                                child: Text(
                                  "${DemoLocalizations
                                      .of(context)
                                      .spendTime}:${model.logic.getDiffTimeText(
                                      task.createDate, task.finishDate)}",
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: textSize,
                                    color: textColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                "${DemoLocalizations
                                    .of(context)
                                    .changedTimes}:${task.changeTimes}",
                                style: TextStyle(
                                  fontSize: textSize,
                                  color: textColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              Text(
                                "${DemoLocalizations
                                    .of(context)
                                    .completeDate}:${model.logic.getTimeText(
                                    task.finishDate)}",
                                style: TextStyle(
                                  fontSize: textSize,
                                  color: textColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                          color: color,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            })
            : LoadingWidget(
          progressColor: globalModel.logic.getPrimaryGreyInDark(context),
          textColor: globalModel.logic.getPrimaryGreyInDark(context),
          flag: model.loadingFlag,
          errorCallBack: () {},
          emptyText: DemoLocalizations
              .of(context)
              .toFinishTask,
        ),
      ),
    );
  }
}
