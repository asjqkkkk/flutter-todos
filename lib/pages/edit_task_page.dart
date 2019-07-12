import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/task_icon_bean.dart';
import 'package:todo_list/model/edit_task_page_model.dart';
import 'package:todo_list/model/main_page_model.dart';

class EditTaskPage extends StatelessWidget {
  final TaskIconBean taskIcon;
  final MainPageModel mainPageModel;

  EditTaskPage(this.taskIcon, {this.mainPageModel});

  @override
  Widget build(BuildContext context) {
    final EditTaskPageModel model = Provider.of<EditTaskPageModel>(context);
    model.setContext(context);
    model.setTaskIcon(taskIcon);
    final iconColor = ColorBean.fromBean(taskIcon.colorBean);
    final iconData = IconBean.fromBean(taskIcon.iconBean);

    return Scaffold(
      backgroundColor: model.bgColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: iconColor),
        backgroundColor: model.bgColor,
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.check,
                color: iconColor,
              ),
              tooltip: DemoLocalizations.of(context).submit,
              onPressed: () {})
        ],
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 100, left: 50, right: 50),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overScroll) {
                  overScroll.disallowGlow();
                },
                child: ListView.builder(
                  itemCount: model.taskDetails.length,
                  itemBuilder: (ctx, index) {
                    return Dismissible(
                      background: Container(
                        alignment: Alignment.centerLeft,
                        color: iconColor,
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      secondaryBackground: Container(
                        alignment: Alignment.centerRight,
                        color: iconColor,
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      key: ValueKey(index + Random().nextDouble()),
                      onDismissed: (d) => model.logic.removeItem(index),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10, top: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 7,
                              height: 7,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: iconColor,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Text(
                                model.taskDetails[index],
                                style: TextStyle(
                                  color: Color.fromRGBO(130, 130, 130, 1),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                color: model.bgColor,
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 1,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    TextField(
                      controller: model.textEditingController
                        ..addListener(model.logic.editListener),
                      autofocus: model.taskDetails.length > 0 ? false : true,
                      decoration: InputDecoration(
                          hintText: DemoLocalizations.of(context).addTask,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            iconData,
                            color: iconColor,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: model.logic.submitOneItem,
                            child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: model.canAddTask
                                      ? iconColor
                                      : Colors.grey.withOpacity(0.4)),
                              child: Icon(
                                Icons.arrow_upward,
                                color: model.bgColor,
                                size: 20,
                              ),
                            ),
                          )),
                    ),
                    Container(
                      height: 40,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          model.logic.getIconText(
                            icon: Icon(
                              Icons.timer,
                              color: iconColor,
                            ),
                            text:  model.logic.getEndTimeText(),
                            onTap: model.logic.pickEndTime,
                          ),
                          model.logic.getIconText(
                            icon: Icon(
                              Icons.notifications_active,
                              color: iconColor,
                            ),
                            text: DemoLocalizations.of(context).remindMe,
                            onTap: () {},
                          ),
                          model.logic.getIconText(
                            icon: Icon(
                              Icons.repeat,
                              color: iconColor,
                            ),
                            text: DemoLocalizations.of(context).repeat,
                            onTap: () {},
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}