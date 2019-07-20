import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/config/provider_config.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/color_bean.dart';
import 'package:todo_list/model/done_task_page_model.dart';

class DoneTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<DoneTaskPageModel>(context)..setContext(context);
    final size = MediaQuery.of(context).size;
    final minSize = min(size.width, size.height);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          DemoLocalizations.of(context).doneList,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: model.loadingFlag == LoadingFlag.success
            ? GridView.count(
                crossAxisCount: 2,
                children: List.generate(model.doneTasks.length, (index) {
                  final task = model.doneTasks[index];
                  final color = ColorBean.fromBean(task.taskIconBean.colorBean);
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx) {
                          return ProviderConfig.getInstance().getTaskDetailPage(index, task);
                      }));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            task.taskName,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,),
                          ),
                          color: color,
                        ),
                      ),
                    ),
                  );
                }),
              )
            : LoadingWidget(
                errorCallBack: () {},
                emptyText: DemoLocalizations.of(context).toFinishTask,
              ),
      ),
    );
  }
}
