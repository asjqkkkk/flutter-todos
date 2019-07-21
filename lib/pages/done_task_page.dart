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
    final model = Provider.of<DoneTaskPageModel>(context)..setContext(context);
    final globalModel = Provider.of<GlobalModel>(context);
    final size = MediaQuery.of(context).size;
    final minSize = min(size.width, size.height);

    final textColor = globalModel.logic.getWhiteInDark();

    bool isDartNow =
        globalModel.currentThemeBean.themeType == MyTheme.darkTheme;
    final bgColor = isDartNow
        ? ColorBean.fromBean(globalModel.currentThemeBean.colorBean)
        : Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: globalModel.logic.getBgInDark(),
        title: Text(
          DemoLocalizations.of(context).doneList,
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
        child: model.doneTasks.length > 0
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
                    children: <Widget>[
                      SizedBox(width: 20,),
                      Column(
                        children: <Widget>[
                          index == 0
                              ? SizedBox(
                                  height: 50,
                                )
                              : Container(
                                  color: color,
                                  width: 2,
                                  height: 50,
                                ),
                          Container(
                            width: 40,
                            height: 40,
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
                                  height: 50,
                                )
                              : Container(
                                  color: color,
                                  width: 2,
                                  height: 50,
                                ),
                        ],
                      ),
                      Container(
                        height: 1,
                        width: 20,
                        color: color,
                      ),
                      Column(
                        children: <Widget>[
                          InkWell(
                            onTap: () => model.logic.onTaskTap(index, task),
                            child: Container(
                              height: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30)),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        task.taskName,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: textColor,
                                        ),
                                      ),
                                      Text(
                                        "任务数:${task.taskDetailNum}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: textColor,
                                        ),
                                      ),
                                      Text(
                                        "创建日期:${model.logic.getTimeText(task.createDate)}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: textColor,
                                        ),
                                      ),
                                      Text(
                                        "完成日期:${model.logic.getTimeText(task.finishDate)}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: textColor,
                                        ),
                                      ),
                                      Text(
                                        "用时:${model.logic.getDiffTimeText(task.finishDate, task.createDate)}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  color: color,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                })
            : LoadingWidget(
                flag: model.loadingFlag,
                errorCallBack: () {},
                emptyText: DemoLocalizations.of(context).toFinishTask,
              ),
      ),
    );
  }
}
